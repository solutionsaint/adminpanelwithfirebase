import 'package:attendance_app/models/courses/attendance_model.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/models/courses/display_attendance_model.dart';
import 'package:attendance_app/utils/logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  AttendanceService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final AttendanceService _instance =
      AttendanceService._privateConstructor();

  // Factory constructor to return the static instance
  factory AttendanceService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses(
    String userId,
    String instituteId,
    String roleType,
  ) async {
    try {
      // Fetch the user document
      DocumentSnapshot userSnapshot =
          await _firestore.collection('lms-users').doc(userId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        List<String> registeredCourses =
            List<String>.from(userData['registeredCourses']);

        List<CourseModel> courses = [];
        if (registeredCourses.isNotEmpty) {
          for (String courseId in registeredCourses) {
            DocumentSnapshot courseSnapshot = await _firestore
                .collection('institutes')
                .doc(instituteId)
                .collection('courses')
                .doc(courseId)
                .get();

            if (courseSnapshot.exists) {
              Map<String, dynamic> courseData;

              // Fetch the number of registrations
              QuerySnapshot studentsRegistrationSnapshot = await _firestore
                  .collection('institutes')
                  .doc(instituteId)
                  .collection('students-registrations')
                  .where('courseId', isEqualTo: courseId)
                  .get();

              QuerySnapshot teachersRegistrationSnapshot = await _firestore
                  .collection('institutes')
                  .doc(instituteId)
                  .collection('teachers-registrations')
                  .where('courseId', isEqualTo: courseId)
                  .get();

              bool hasApproval = false;

              // Check approval status based on role type
              if (roleType == "Student") {
                hasApproval = studentsRegistrationSnapshot.docs.any((doc) {
                  return doc['registeredBy'] == userId &&
                      doc['status'] == "Approved";
                });
              } else if (roleType == "Teacher") {
                hasApproval = teachersRegistrationSnapshot.docs.any((doc) {
                  return doc['registeredBy'] == userId &&
                      doc['status'] == "Approved";
                });
              }

              if (hasApproval) {
                courseData = courseSnapshot.data() as Map<String, dynamic>;
                int noOfRegistrations = studentsRegistrationSnapshot.size;
                int noOfTeachersRegistrations =
                    teachersRegistrationSnapshot.size;

                // Extract user names from the registrations
                List<Map<String, String>> userNames =
                    studentsRegistrationSnapshot.docs.map((registrationDoc) {
                  String studentId = registrationDoc['registeredBy'] as String;
                  String studentName = registrationDoc['userName'] as String;
                  return {studentId: studentName};
                }).toList();

                List<Map<String, String>> teacherNames =
                    teachersRegistrationSnapshot.docs.map((registrationDoc) {
                  String teacherId = registrationDoc['registeredBy'] as String;
                  String teacherName = registrationDoc['userName'] as String;
                  return {teacherId: teacherName};
                }).toList();

                courseData['noOfRegistrations'] = noOfRegistrations;
                courseData['noOfTeachersRegistrations'] =
                    noOfTeachersRegistrations;
                courseData['students'] = userNames;
                courseData['teachers'] = teacherNames;

                // Convert to CourseModel and add to list
                courses.add(CourseModel.fromJson(courseData));
              }
            }
          }
        }
        courses.sort((a, b) =>
            a.courseTitle.toLowerCase().compareTo(b.courseTitle.toLowerCase()));
        return courses;
      } else {
        log.e('User with ID $userId does not exist.');
        return [];
      }
    } catch (e) {
      log.e('Error fetching courses: $e');
      return [];
    }
  }

  Future<bool> markAttendance(
    Map<String, bool> attendanceStatus,
    Map<String, bool> teachersAttendanceStatus,
    String courseId,
    String date,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      for (var entry in attendanceStatus.entries) {
        String studentId = entry.key;
        bool status = entry.value;

        // Create an instance of AttendanceModel
        AttendanceModel attendanceModel = AttendanceModel(status: status);

        // Convert the model to a map
        Map<String, dynamic> attendanceData = attendanceModel.toJson();

        // Step 1: Set the timestamp in the course document
        DocumentReference courseDocRef = _firestore
            .collection('lms-users')
            .doc(studentId)
            .collection('courses')
            .doc(courseId);

        await courseDocRef.set(
            {
              'lastUpdated':
                  FieldValue.serverTimestamp(), // Set the timestamp field
            },
            SetOptions(
              merge: true,
            )); // Use merge to avoid overwriting other fields

        // Step 2: Set the attendance document with the same timestamp
        DocumentReference attendanceDocRef =
            courseDocRef.collection('attendance').doc(date);

        // Add or update the document with the attendance data
        await attendanceDocRef.set(attendanceData);
      }
      for (var entry in teachersAttendanceStatus.entries) {
        String teacherId = entry.key;
        bool status = entry.value;

        // Create an instance of AttendanceModel
        AttendanceModel attendanceModel = AttendanceModel(status: status);

        // Convert the model to a map
        Map<String, dynamic> attendanceData = attendanceModel.toJson();

        // Define the path to the document
        DocumentReference attendanceDocRef = firestore
            .collection('lms-users')
            .doc(teacherId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(date);

        // Add or update the document with the attendance data
        await attendanceDocRef.set(attendanceData);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, bool>> getAttendance(
    String courseId,
    String date,
    Map<String, bool> attendanceStatus,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Create a map to hold student IDs and their attendance status
      Map<String, bool> attendanceMap = {};

      // Iterate through the student IDs in attendanceStatus map
      for (var studentId in attendanceStatus.keys) {
        // Fetch the attendance document for the given courseId and date
        DocumentSnapshot attendanceDoc = await firestore
            .collection('lms-users')
            .doc(studentId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(date)
            .get();

        if (attendanceDoc.exists) {
          // Convert the document data to AttendanceModel
          AttendanceModel attendanceModel = AttendanceModel.fromJson(
            attendanceDoc.data() as Map<String, dynamic>,
          );

          // Add to the map
          attendanceMap[studentId] = attendanceModel.status;
        } else {
          // If no attendance record exists for this date, assume false (absent)
          attendanceMap[studentId] = false;
        }
      }

      return attendanceMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<Map<String, bool>> getTeachersAttendance(
    String courseId,
    String date,
    Map<String, bool> attendanceStatus,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // Create a map to hold student IDs and their attendance status
      Map<String, bool> attendanceMap = {};

      // Iterate through the student IDs in attendanceStatus map
      for (var teacherId in attendanceStatus.keys) {
        // Fetch the attendance document for the given courseId and date
        DocumentSnapshot attendanceDoc = await firestore
            .collection('lms-users')
            .doc(teacherId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(date)
            .get();

        if (attendanceDoc.exists) {
          // Convert the document data to AttendanceModel
          AttendanceModel attendanceModel = AttendanceModel.fromJson(
            attendanceDoc.data() as Map<String, dynamic>,
          );

          // Add to the map
          attendanceMap[teacherId] = attendanceModel.status;
        } else {
          // If no attendance record exists for this date, assume false (absent)
          attendanceMap[teacherId] = false;
        }
      }

      return attendanceMap;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<int> getTotalHours(String accessId, String courseId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Define the path to the document
      DocumentSnapshot courseDoc = await firestore
          .collection('institutes')
          .doc(accessId)
          .collection('courses')
          .doc(courseId)
          .get();

      // Check if the document exists and return the totalHours field
      if (courseDoc.exists) {
        // Extract the totalHours field
        int totalHours =
            courseDoc.get('totalHours') ?? 0; // Default to 0 if not found
        return totalHours;
      } else {
        // Document does not exist
        print('Document does not exist');
        return 0;
      }
    } catch (e) {
      // Handle any errors
      print(e);
      return 0;
    }
  }

  Future<int> attendedHours(String userId, String courseId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Define the path to the attendance collection
      QuerySnapshot attendanceSnapshot = await firestore
          .collection('lms-users')
          .doc(userId)
          .collection('courses')
          .doc(courseId)
          .collection('attendance')
          .where('status', isEqualTo: true)
          .get();

      // Count the number of documents in the collection
      int documentCount = attendanceSnapshot.size;

      return documentCount;
    } catch (e) {
      // Handle any errors
      print(e);
      return 0;
    }
  }

  Future<String> getStudentName(String userId) async {
    try {
      // Fetch the user's document from the 'lms-users' collection
      DocumentSnapshot userDoc =
          await _firestore.collection('lms-users').doc(userId).get();

      // Check if the document exists
      if (userDoc.exists) {
        // Extract the user's name (ensure 'name' is the correct field)
        String userName = userDoc['name'];
        return userName;
      } else {
        return 'User not found';
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching user name: $e');
      return 'Error fetching name';
    }
  }

  Future<List<DisplayAttendanceModel>> getStudentAttendance(
    String userId,
    String courseId,
  ) async {
    List<DisplayAttendanceModel> attendanceList = [];
    try {
      // Fetch the attendance collection for the specified user and course
      CollectionReference attendanceRef = _firestore
          .collection('lms-users')
          .doc(userId)
          .collection('courses')
          .doc(courseId)
          .collection('attendance');

      QuerySnapshot attendanceSnapshot = await attendanceRef.get();

      // Iterate through each document in the attendance collection
      for (var doc in attendanceSnapshot.docs) {
        // Use the document ID as the date
        String date = doc.id;

        // Extract the 'status' field from the document data
        bool status = doc['status'];

        // Create a DisplayAttendanceModel and add it to the list

        attendanceList.add(DisplayAttendanceModel(
          status: status,
          date: date,
        ));
      }
      return attendanceList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> updateStudentAttendance(
    String userId,
    String courseId,
    List<DisplayAttendanceModel> attendanceUpdates,
  ) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Update the attendance records
      for (var attendance in attendanceUpdates) {
        // Path to the attendance document in Firestore
        DocumentReference attendanceDocRef = firestore
            .collection('lms-users')
            .doc(userId)
            .collection('courses')
            .doc(courseId)
            .collection('attendance')
            .doc(attendance.date); // Document ID is the date

        // Create a map to store the new attendance status
        Map<String, dynamic> updatedAttendance = {
          'status': attendance.status,
        };

        // Update the attendance document with the new status
        await attendanceDocRef.set(updatedAttendance, SetOptions(merge: true));
      }

      // Count the number of documents with status = true
      final attendanceCollectionRef = firestore
          .collection('lms-users')
          .doc(userId)
          .collection('courses')
          .doc(courseId)
          .collection('attendance');

      final snapshot =
          await attendanceCollectionRef.where('status', isEqualTo: true).get();

      // Return the count of documents with status = true
      return snapshot.size;
    } catch (e) {
      print('Error updating attendance: $e');
      return 0; // Return 0 in case of an error
    }
  }
}
