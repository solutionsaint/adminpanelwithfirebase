import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/custom_dashed_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';

class FaceRecognitionScreenWidget extends StatefulWidget {
  final bool isLoading;
  final void Function(List<File?>) onSaveFaceRecognition;
  const FaceRecognitionScreenWidget({
    super.key,
    required this.isLoading,
    required this.onSaveFaceRecognition,
  });

  @override
  State<FaceRecognitionScreenWidget> createState() => _ModelScreenWidgetState();
}

class _ModelScreenWidgetState extends State<FaceRecognitionScreenWidget> {
  List<File?> _image = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _image = List.filled(5, null);
  }

  void onMediaSelected(ImageSource imageSource, int index) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image[index] = image;
    });
  }

  void onSaveMedia() {
    if (_image.isEmpty || _image.contains(null)) {
      showSnackbar(context, "Upload all images");
      return;
    }
    widget.onSaveFaceRecognition(_image);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: screenSize.width * 0.9,
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    child: _image[index] == null
                        ? CustomDashedInput(
                            text: 'Face ${index + 1}',
                            onTap: () =>
                                onMediaSelected(ImageSource.camera, index),
                          )
                        : Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    FileImage(File(_image[index]!.path)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Face ${index + 1} uploaded',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrown,
                              ),
                            ],
                          ),
                  ),
                );
              },
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
      ),
    );
  }
}
