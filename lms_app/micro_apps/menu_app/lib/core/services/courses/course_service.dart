import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/models/courses/item_model.dart';
import 'package:menu_app/models/courses/search_model.dart';
import 'package:menu_app/models/courses/suggestion_category_model.dart';
import 'package:menu_app/models/courses/suggestion_model.dart';
import 'package:menu_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final log = CustomLogger.getLogger('CourseService');

  Future<String?> hasSelectedCategory(String accessCode) async {
    try {
      DocumentReference instituteDocRef =
          _firestore.collection('institutes').doc(accessCode);

      DocumentSnapshot instituteDoc = await instituteDocRef.get();

      if (instituteDoc.exists) {
        Map<String, dynamic>? data =
            instituteDoc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('selectedCategory')) {
          return data['selectedCategory'] as String;
        }
      }
      return null;
    } catch (e) {
      print(e);
      log.e('Error checking selectedCategory: $e');
      throw Exception('Failed to check selectedCategory');
    }
  }

  Future<bool> migrateCourse(
    String accessCode,
    String newCourseId,
    String oldCourseId,
  ) async {
    try {
      final datas = await _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection('courses')
          .where('courseId', isEqualTo: newCourseId)
          .get();
      List<CourseModel> newCourseData = datas.docs.map(
        (doc) {
          return CourseModel.fromJson(doc.data());
        },
      ).toList();

      final registrations = await _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection('students-registrations')
          .where('courseId', isEqualTo: oldCourseId)
          .get();

      List<String> registeredBy = registrations.docs.map<String>(
        (doc) {
          return (doc.data())['registeredBy'] as String;
        },
      ).toList();

      for (String studentId in registeredBy) {
        final studentRegistrations = await _firestore
            .collection('institutes')
            .doc(accessCode)
            .collection('students-registrations')
            .where('registeredBy', isEqualTo: studentId)
            .get();

        bool hasNewCourse = studentRegistrations.docs.any((doc) {
          return (doc.data())['courseId'] == newCourseId;
        });
        if (hasNewCourse) {
          // for (var doc in studentRegistrations.docs) {
          //   if (doc['courseId'] == oldCourseId) {
          //     await doc.reference.delete();
          //   }
          // }
        }
        if (!hasNewCourse) {
          for (var doc in studentRegistrations.docs) {
            if (doc['courseId'] == oldCourseId) {
              await doc.reference.update({
                'batchDay': newCourseData[0].batchDay,
                'batchTime': newCourseData[0].batchTime,
                'courseId': newCourseId,
              });

              final studentDoc =
                  await _firestore.collection('lms-users').doc(studentId).get();

              if (studentDoc.exists) {
                await studentDoc.reference.update({
                  'registeredCourses': FieldValue.arrayRemove([oldCourseId]),
                });
                await studentDoc.reference.update({
                  'registeredCourses': FieldValue.arrayUnion([newCourseId]),
                });
              }

              final oldAttendanceCourseDoc = await _firestore
                  .collection('lms-users')
                  .doc(studentId)
                  .collection('courses')
                  .doc(oldCourseId)
                  .get();

              if (oldAttendanceCourseDoc.exists) {
                Map<String, dynamic> data =
                    oldAttendanceCourseDoc.data() as Map<String, dynamic>;

                DocumentReference newCourseDoc = _firestore
                    .collection('lms-users')
                    .doc(studentId)
                    .collection('courses')
                    .doc(newCourseId);

                await newCourseDoc.set(data);

                QuerySnapshot attendanceSnapshot = await oldAttendanceCourseDoc
                    .reference
                    .collection('attendance')
                    .get();
                for (QueryDocumentSnapshot doc in attendanceSnapshot.docs) {
                  await newCourseDoc
                      .collection('attendance')
                      .doc(doc.id)
                      .set(doc.data() as Map<String, dynamic>);
                }

                await oldAttendanceCourseDoc.reference.delete();
              }
            }
          }
        }
      }
      await deleteCourse(accessCode, oldCourseId);
      return true;
    } catch (e) {
      log.e("Failed to migrate course");
      return false;
    }
  }

  Future<List<String>> checkExistingCourse(
    String accessCode,
    String courseName,
    String courseId,
  ) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection('courses')
          .get();

      List<String> courses = [];

      for (var doc in querySnapshot.docs) {
        if ((doc.data() as Map<String, dynamic>)['courseTitle'] == courseName &&
            doc.id != courseId) {
          courses.add(doc.id);
        }
      }

      return courses;
    } catch (e) {
      print(e);
      log.e('Error checking course: $e');
      throw Exception('Failed to check course');
    }
  }

  Future<List<CourseModel>> fetchListedCourses(
    String accessCode,
    List<String> courseIds,
  ) async {
    try {
      List<CourseModel> courses = [];
      final datas = await _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection('courses')
          .where('courseId', whereIn: courseIds)
          .get();
      for (var doc in datas.docs) {
        courses.add(
          CourseModel.fromJson(
            doc.data(),
          ),
        );
      }
      return courses;
    } catch (e) {
      print(e);
      log.e('Error fetching courses: $e');
      throw Exception('Failed to fetch courses');
    }
  }

  Future<bool> deleteCourse(String accessCode, String courseId) async {
    try {
      DocumentReference courseDocRef = _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection('courses')
          .doc(courseId);

      await courseDocRef.delete();
      return true;
    } catch (e) {
      print(e);
      log.e('Error deleting course: $e');
      throw Exception('Failed to delete course');
    }
  }

  Future<bool> addSuggestion(String name, File image) async {
    try {
      String url = await _storageService.uploadFile(
        image,
        'suggestions/',
        image.path.split('/').last,
      );
      SuggestionModel newSuggestion = SuggestionModel(
        name: name,
        image: url,
        isApproved: false,
        isRejected: false,
      );
      await _firestore.collection('suggestions').add(newSuggestion.toJson());

      return true;
    } catch (e) {
      print(e);
      log.e('Error adding category: $e');
      return false;
    }
  }

  Future<String?> addItem(
    Map<String, dynamic> formData,
    List<File> imageFile,
    String accessCode,
    String subCategory,
  ) async {
    try {
      final itemTitles =
          formData['itemTitle'].split(',').map((e) => e.trim()).toList();

      // List<String> manualImageUrls = [];
      for (int i = 0; i < formData['manualSearch'].length; i++) {
        String url = await _storageService.uploadFile(
          formData['manualSearch'][i].file,
          'institutes/$accessCode',
          formData['manualSearch'][i].file.path.split('/').last,
        );
        print(url);
        // formData['manualSearch'][i].file = url;
        formData['manualSearch'][i] = SearchModel(
          name: formData['manualSearch'][i].name,
          file: formData['manualSearch'][i].file,
          valid: true,
          url: url,
        );
        // manualImageUrls.add(url);
      }
      final List<SearchModel> finalTitleList = [
        ...formData['manualSearch'],
        ...formData['suggestionSearch']
      ];

      String? lastAddedItemId;
      // Check if the selectedCategory field exists in the document
      DocumentReference instituteDocRef =
          _firestore.collection('institutes').doc(accessCode);

      DocumentSnapshot instituteDoc = await instituteDocRef.get();

      // Check if the document exists and if the selectedCategory field is present
      if (instituteDoc.exists) {
        Map<String, dynamic>? data =
            instituteDoc.data() as Map<String, dynamic>?;
        if (data == null || !data.containsKey('selectedCategory')) {
          // If selectedCategory field doesn't exist, add it
          await instituteDocRef.update({
            'selectedCategory': subCategory,
          });
          log.i(
              'selectedCategory set to "$subCategory" for institute "$accessCode"');
        }
      }
      WriteBatch batch = _firestore.batch();

      for (SearchModel search in finalTitleList) {
        print('...................................');
        print(search.name);
        List batchDays = formData['batchDay'] ?? [];
        List batchTimes = formData['batchTime'] ?? [];
        // int index = finalTitleList.indexOf(search);
        // print(index);
        if (subCategory != 'courses') {
          final itemId = _firestore
              .collection('institutes')
              .doc(accessCode)
              .collection(subCategory)
              .doc()
              .id;

          ItemModel newItem = ItemModel(
            courseId: itemId,
            courseTitle: search.name,
            imageUrl: search.url ?? '',
            shortDescription: formData['shortDescription'],
            aboutDescription: formData['aboutDescription'],
            amount: double.parse(formData['amount']),
          );

          await _firestore
              .collection('institutes')
              .doc(accessCode)
              .collection(subCategory)
              .doc(itemId)
              .set(
                newItem.toJson(),
              );
          lastAddedItemId = itemId;
        }
        for (String day in batchDays) {
          for (String time in batchTimes) {
            final itemId = _firestore
                .collection('institutes')
                .doc(accessCode)
                .collection(subCategory)
                .doc()
                .id;
            CourseModel newCourse = CourseModel(
              courseId: itemId,
              courseTitle: search.name,
              imageUrl: search.url ?? '',
              shortDescription: formData['shortDescription'],
              aboutDescription: formData['aboutDescription'],
              batchDay: day,
              batchTime: time,
              totalHours: formData['totalHours'],
              amount: double.parse(formData['amount']),
            );

            // Add the write operation to the batch
            batch.set(
              _firestore
                  .collection('institutes')
                  .doc(accessCode)
                  .collection(subCategory)
                  .doc(itemId),
              newCourse.toJson()
                ..removeWhere((key, value) => value == null || value == ''),
            );
            lastAddedItemId = itemId;
          }
        }
      }

      // for (String itemTitle in itemTitles) {
      //   print('...................................');
      //   print(itemTitle);
      //   List batchDays = formData['batchDay'] ?? [];
      //   List batchTimes = formData['batchTime'] ?? [];
      //   int index = itemTitles.indexOf(itemTitle);
      //   print(imageUrls);
      //   print(index);
      //   //Todo:If no batch days and batch times then different logic
      //   if (subCategory != 'courses') {
      //     final itemId = _firestore
      //         .collection('institutes')
      //         .doc(accessCode)
      //         .collection(subCategory)
      //         .doc()
      //         .id;

      //     ItemModel newItem = ItemModel(
      //       courseId: itemId,
      //       courseTitle: itemTitle,
      //       imageUrl: formData['suggestionImage'] ?? imageUrls[index],
      //       shortDescription: formData['shortDescription'],
      //       aboutDescription: formData['aboutDescription'],
      //       amount: double.parse(formData['amount']),
      //     );

      //     await _firestore
      //         .collection('institutes')
      //         .doc(accessCode)
      //         .collection(subCategory)
      //         .doc(itemId)
      //         .set(
      //           newItem.toJson(),
      //         );
      //     lastAddedItemId = itemId;
      //   }
      //   for (String day in batchDays) {
      //     for (String time in batchTimes) {
      //       final itemId = _firestore
      //           .collection('institutes')
      //           .doc(accessCode)
      //           .collection(subCategory)
      //           .doc()
      //           .id;
      //       CourseModel newCourse = CourseModel(
      //         courseId: itemId,
      //         courseTitle: itemTitle,
      //         imageUrl: formData['suggestionImage'] ?? imageUrls[index],
      //         shortDescription: formData['shortDescription'],
      //         aboutDescription: formData['aboutDescription'],
      //         batchDay: day,
      //         batchTime: time,
      //         totalHours: formData['totalHours'],
      //         amount: double.parse(formData['amount']),
      //       );

      //       // Add the write operation to the batch
      //       batch.set(
      //         _firestore
      //             .collection('institutes')
      //             .doc(accessCode)
      //             .collection(subCategory)
      //             .doc(itemId),
      //         newCourse.toJson()
      //           ..removeWhere((key, value) => value == null || value == ''),
      //       );
      //       lastAddedItemId = itemId;
      //     }
      //   }
      // }

      await batch.commit();

      log.i('Batch write completed successfully for all items.');

      return lastAddedItemId;
    } catch (e) {
      print(e);
      throw Exception('Failed to add item');
    }
  }

  Stream<List<CourseModel>> getItems(
    String accessCode,
    String subCategory,
  ) async* {
    try {
      yield* _firestore
          .collection('institutes')
          .doc(accessCode)
          .collection(subCategory)
          .snapshots()
          .map((querySnapshot) {
        // Convert the querySnapshot to a list of CourseModel
        List<CourseModel> courses = querySnapshot.docs
            .map((doc) =>
                CourseModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        // Sort the list by courseTitle alphabetically, case-insensitively
        courses.sort((a, b) =>
            a.courseTitle.toLowerCase().compareTo(b.courseTitle.toLowerCase()));

        return courses;
      });
    } catch (e) {
      log.e('Error getting items: $e');
      throw Exception('Failed to get items');
    }
  }

  Future<int> getApprovedRegistrationsCount(
    String instituteId,
    String courseId,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .where('courseId', isEqualTo: courseId)
          .where('status', isEqualTo: 'Approved')
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      log.e('Error getting approved registrations count: $e');
      return 0;
    }
  }

  Future<int> getPendingRegistrationsCount(
    String instituteId,
    String courseId,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .where('courseId', isEqualTo: courseId)
          .where('status', isEqualTo: 'Pending')
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      log.e('Error getting pending registrations count: $e');
      return 0;
    }
  }

  Future<int> getRejectedRegistrationsCount(
    String instituteId,
    String courseId,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .where('courseId', isEqualTo: courseId)
          .where('status', isEqualTo: 'Rejected')
          .get();

      return querySnapshot.docs.length;
    } catch (e) {
      log.e('Error getting rejected registrations count: $e');
      return 0;
    }
  }

  Future<List<SuggestionCategoriesModel>> getSuggestionCategories() async {
    try {
      final suggestionCategoriesRef =
          _firestore.collection('suggestion-hierarchy');
      final querySnapshot = await suggestionCategoriesRef.get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      List<SuggestionCategoriesModel> suggestionCategories = [];

      for (var docSnapshot in querySnapshot.docs) {
        final secondLevelCollectionRef = _firestore
            .collection('suggestion-hierarchy')
            .doc(docSnapshot.id)
            .collection('2nd Level');

        final secondLevelSnapshot = await secondLevelCollectionRef.get();
        List<String> secondLevelCategories =
            secondLevelSnapshot.docs.map((doc) => doc.id).toList();

        suggestionCategories.add(
          SuggestionCategoriesModel(
            superCategory: SuperCategory(
              name: docSnapshot.id,
              secondLevelCategories: secondLevelCategories,
            ),
          ),
        );
      }

      return suggestionCategories;
    } catch (e) {
      log.e('Error fetching suggestion categories: $e');
      return [];
    }
  }
}
