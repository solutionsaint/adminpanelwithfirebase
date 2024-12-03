import 'package:flutter/material.dart';

import 'package:enquiry_app/screens/student_teacher_app/access_code_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/my_ticket_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/my_tickets_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/resolved_enquiry_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/enquiry_reception_screen.dart';
import 'package:enquiry_app/screens/student_teacher_app/raise_enquiry_screen.dart';

class StudentTeacherRoutes {
  const StudentTeacherRoutes._();

  static const raiseEnquiry = '/raise-enquiry';
  static const enquiryReception = '/enquiry-reception';
  static const myTickets = '/my-tickets';
  static const myTicket = '/my-ticket';
  static const accessCode = '/access-code';
  static const resolvedEnquiry = '/resolved-enquiry';

  static Map<String, WidgetBuilder> get buildStudentTeacherRoutes {
    return {
      raiseEnquiry: (context) => const RaiseEnquiryScreen(),
      enquiryReception: (context) => const EnquiryReceptionScreen(),
      myTickets: (context) => const MyTicketsScreen(),
      myTicket: (context) => const MyTicketScreen(),
      accessCode: (context) => const AccessCodeScreen(),
      resolvedEnquiry: (context) => const ResolvedEnquiryScreen(),
    };
  }

  static String get initialRoute {
    return StudentTeacherRoutes.accessCode;
  }
}
