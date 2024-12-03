import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<bool> saveFaceRecognition(List<File?> images, String userId) async {
  try {
    final futures = images.map((file) => _uploadSingleFile(file!, userId));
    final results = await Future.wait(futures);
    return results.every((result) => result);
  } catch (e) {
    print('Error uploading files: $e');
    return false;
  }
}

Future<bool> _uploadSingleFile(File file, String userId) async {
  try {
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(
          'https://vxvjea2x80.execute-api.ap-south-1.amazonaws.com/gph/register'),
      body: jsonEncode(
        {
          'image_data': base64File,
          "name": userId,
          "file_name": file.path.split('/').last,
        },
      ),
    );
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}
