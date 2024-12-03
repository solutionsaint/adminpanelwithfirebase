import 'package:attendance_app/models/courses/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/utils/logger/logger.dart';

class ItemsService {
  ItemsService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final ItemsService _instance = ItemsService._privateConstructor();

  // Factory constructor to return the static instance
  factory ItemsService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CourseModel>> getCourses(String instituteId) async {
    try {
      // Step 1: Query the courses collection within the specific institute
      QuerySnapshot coursesSnapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('courses')
          .get();

      // Step 2: Convert the snapshot data to a list of CourseModel
      List<CourseModel> courses = [];
      for (var doc in coursesSnapshot.docs) {
        // Fetch the course data
        Map<String, dynamic> courseData = doc.data() as Map<String, dynamic>;

        // Fetch the number of registrations for this course
        QuerySnapshot studentsRegistrationSnapshot = await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .where('courseId', isEqualTo: courseData['courseId'])
            .where('status', isEqualTo: 'Approved')
            .get();
        QuerySnapshot teachersRegistrationSnapshot = await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('teachers-registrations')
            .where('courseId', isEqualTo: courseData['courseId'])
            .where('status', isEqualTo: 'Approved')
            .get();

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

        int noOfRegistrations = studentsRegistrationSnapshot.size;
        int noOfTeachersRegistrations = teachersRegistrationSnapshot.size;

        courseData['noOfRegistrations'] = noOfRegistrations;
        courseData['noOfTeachersRegistrations'] = noOfTeachersRegistrations;
        courseData['students'] = userNames;
        courseData['teachers'] = teacherNames;
        courses.add(CourseModel.fromJson(courseData));
      }
      courses.sort((a, b) =>
          a.courseTitle.toLowerCase().compareTo(b.courseTitle.toLowerCase()));
      return courses;
    } catch (e) {
      log.e('Error fetching courses: $e');
      return [];
    }
  }
}
