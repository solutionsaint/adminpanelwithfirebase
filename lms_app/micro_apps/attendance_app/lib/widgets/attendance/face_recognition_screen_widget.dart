import 'dart:io';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:attendance_app/widgets/common/custom_dashed_input.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceRecognitionScreenWidget extends StatefulWidget {
  final bool isLoading;
  final void Function(File) onSaveFaceRecognition;
  const FaceRecognitionScreenWidget({
    super.key,
    required this.isLoading,
    required this.onSaveFaceRecognition,
  });

  @override
  State<FaceRecognitionScreenWidget> createState() => _ModelScreenWidgetState();
}

class _ModelScreenWidgetState extends State<FaceRecognitionScreenWidget> {
  File? _image;
  final _picker = ImagePicker();

  void onMediaSelected(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  void onSaveMedia() {
    if (_image == null) {
      showSnackbar(context, "Upload all images");
      return;
    }
    widget.onSaveFaceRecognition(_image!);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          _image == null
              ? CustomDashedInput(
                  text: 'Face ',
                  onTap: () => onMediaSelected(ImageSource.camera),
                )
              : Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: FileImage(File(_image!.path)),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Face uploaded',
                      style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          SizedBox(
            height: 45,
            width: screenSize.width * 0.4,
            child: IconTextButton(
              isLoading: widget.isLoading,
              text: "Submit",
              onPressed: onSaveMedia,
              color: ThemeColors.primary,
              iconHorizontalPadding: 7,
            ),
          ),
        ],
      ),
    );
  }
}
