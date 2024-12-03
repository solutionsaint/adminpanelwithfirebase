import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/custom_dashed_input.dart';
import 'package:registration_app/widgets/common/custom_elevated_button.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';

class GenericMediaDialog extends StatefulWidget {
  final String mediaHeading;
  final void Function(File file) onSaveMedia;
  const GenericMediaDialog({
    super.key,
    required this.mediaHeading,
    required this.onSaveMedia,
  });

  @override
  State<GenericMediaDialog> createState() => _GenericMediaDialogState();
}

class _GenericMediaDialogState extends State<GenericMediaDialog> {
  final _picker = ImagePicker();
  File? _image;

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onMediaSelected(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    final image = File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  void onSaveMedia(BuildContext context) {
    if (_image == null) return;
    widget.onSaveMedia(_image!);
    closeModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
            if (_image == null)
              Column(
                children: [
                  CustomDashedInput(
                    text: Strings.gallery,
                    onTap: () => onMediaSelected(ImageSource.gallery),
                  ),
                  const SizedBox(height: 20),
                  CustomDashedInput(
                    text: Strings.camera,
                    onTap: () => onMediaSelected(ImageSource.camera),
                  ),
                ],
              ),
            if (_image != null) Image.file(File(_image!.path)),
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
    );
  }
}
