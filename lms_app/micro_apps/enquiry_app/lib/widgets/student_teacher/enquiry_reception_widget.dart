import 'dart:io';

import 'package:enquiry_app/widgets/common/custom_radio_button.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/form_input.dart';
import 'package:enquiry_app/widgets/student_teacher/choose_file_button.dart';
import 'package:enquiry_app/widgets/student_teacher/enquiry_reception_title_card.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';
import 'package:image_picker/image_picker.dart';

class EnquiryReceptionWidget extends StatefulWidget {
  const EnquiryReceptionWidget({
    super.key,
    required this.name,
    required this.onCreateEnquiry,
  });

  final String name;
  final void Function(
    String issue,
    String subject,
    String description,
    String priority,
    File? file,
  ) onCreateEnquiry;

  @override
  State<EnquiryReceptionWidget> createState() => _EnquiryReceptionWidgetState();
}

class _EnquiryReceptionWidgetState extends State<EnquiryReceptionWidget> {
  final _formKey = GlobalKey<FormState>();
  String issue = '';
  String subject = '';
  String description = '';
  String _selectedPriority = "High";
  String? _fileName;
  File? _image;
  bool isLoading = false;

  String? formValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter something";
    }
    return null;
  }

  void handleCreateTicket() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      setState(() {
        isLoading = true;
      });
      widget.onCreateEnquiry(
        issue,
        subject,
        description,
        _selectedPriority,
        _image,
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _fileName = pickedFile.name; // Store the file name
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        EnquiryReceptionTitleCard(name: widget.name),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          Strings.whatAreYouFacingIssueWith,
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                        ),
                        Text(
                          Strings.required,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmallPrimarySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormInput(
                      text: "",
                      validator: (value) => formValidator(value),
                      onSaved: (value) => {issue = value!},
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          Strings.subject,
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                        ),
                        Text(
                          Strings.required,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmallPrimarySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormInput(
                      text: "",
                      validator: (value) => formValidator(value),
                      onSaved: (value) => {subject = value!},
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          Strings.describeTheIssue,
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                        ),
                        Text(
                          Strings.required,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmallPrimarySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: FormInput(
                        text: "",
                        isDescription: true,
                        validator: (value) => formValidator(value),
                        onSaved: (value) => {description = value!},
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          "Priority ",
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                        ),
                        Text(
                          Strings.required,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmallPrimarySemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomRadioButton(
                          text: "High",
                          value: "High",
                          groupValue: _selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                        ),
                        CustomRadioButton(
                          text: "Medium",
                          value: "Medium",
                          groupValue: _selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                        ),
                        CustomRadioButton(
                          text: "Low",
                          value: "Low",
                          groupValue: _selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          Strings.file,
                          style:
                              Theme.of(context).textTheme.bodyLargeTitleBrown,
                        ),
                        const SizedBox(width: 10),
                        ChooseFileButton(
                          onTap: _pickImage,
                          text: Strings.chooseFile,
                        ),
                        if (_fileName != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              _fileName!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Text(
                          Strings.supportedFiles,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: screenSize.width * 0.7,
                        height: 50,
                        child: IconTextButton(
                          isLoading: isLoading,
                          iconHorizontalPadding: 7,
                          radius: 20,
                          text: "Create Ticket",
                          onPressed: handleCreateTicket,
                          color: ThemeColors.primary,
                          buttonTextStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          svgIcon: icons.Icons.ticket,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
