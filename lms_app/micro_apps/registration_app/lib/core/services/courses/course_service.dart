import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/utils/logger/logger.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final log = CustomLogger.getLogger('CourseService');

  Stream<List<CourseModel>> getCourses(
    String instituteId,
    String userId,
  ) async* {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('lms-users').doc(userId).get();

      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      List<String> registeredCourses =
          List<String>.from(userData?['registeredCourses'] ?? []);

      yield* _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .snapshots()
          .map((querySnapshot) {
        List<CourseModel> courses = querySnapshot.docs
            .map((doc) =>
                CourseModel.fromJson(doc.data() as Map<String, dynamic>))
            .where((course) => !registeredCourses.contains(course.courseId))
            .toList();

        courses.sort((a, b) =>
            a.courseTitle.toLowerCase().compareTo(b.courseTitle.toLowerCase()));

        return courses;
      });
    } catch (e) {
      log.e('Error getting courses: $e');
      throw Exception('Failed to get courses');
    }
  }
}
