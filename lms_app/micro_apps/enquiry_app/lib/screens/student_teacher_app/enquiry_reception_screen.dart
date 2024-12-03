import 'package:enquiry_app/widgets/student_teacher/raise_enquiry_widget.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/student_teacher/enquiry_reception_container.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class EnquiryReceptionScreen extends StatelessWidget {
  const EnquiryReceptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EnquiryArguments args =
        ModalRoute.of(context)!.settings.arguments as EnquiryArguments;

    return ScreenLayout(
      topBarText: args.title,
      child: EnquiryReceptionContainer(type: args.title),
    );
  }
}
