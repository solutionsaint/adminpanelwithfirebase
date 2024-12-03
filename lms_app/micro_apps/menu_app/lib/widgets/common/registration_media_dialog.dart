import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/custom_dashed_input.dart';
import 'package:menu_app/widgets/common/custom_elevated_button.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';

class RegistrationMediaDialog extends StatefulWidget {
  final String mediaHeading;
  final void Function(List<File?> file) onSaveMedia;
  final List<String> itemTitles;
  const RegistrationMediaDialog({
    super.key,
    required this.mediaHeading,
    required this.onSaveMedia,
    required this.itemTitles,
  });

  @override
  State<RegistrationMediaDialog> createState() =>
      _RegistrationMediaDialogState();
}

class _RegistrationMediaDialogState extends State<RegistrationMediaDialog> {
  final _picker = ImagePicker();
  List<File?> _image = [];

  @override
  void initState() {
    super.initState();
    _image = List.filled(widget.itemTitles.length, null);
  }

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onMediaSelected(ImageSource imageSource, int index) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image[index] = image;
    });
  }

  void onSaveMedia(BuildContext context) {
    if (_image.isEmpty) return;
    widget.onSaveMedia(_image);
    closeModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: const SVGLoader(image: icons.Icons.closeRed),
                    onTap: () => closeModal(context),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.mediaHeading,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: widget.itemTitles.length <= 2 ? 200 : 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.itemTitles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          child: _image[index] == null
                              ? CustomDashedInput(
                                  text: Strings.gallery,
                                  onTap: () => onMediaSelected(
                                      ImageSource.gallery, index),
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
                                      'Image ${index + 1} uploaded',
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
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.save,
                    onPressed: () => onSaveMedia(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
