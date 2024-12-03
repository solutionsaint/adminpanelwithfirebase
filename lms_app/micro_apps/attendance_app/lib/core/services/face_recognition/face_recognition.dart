import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<bool> verifyFace(File file, String userId) async {
  try {
    final bytes = await file.readAsBytes();
    final base64File = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(
          'https://vxvjea2x80.execute-api.ap-south-1.amazonaws.com/gph/parse'),
      body: jsonEncode(
        {
          'body': base64File,
        },
      ),
    );
    return response.statusCode == 200;
  } catch (e) {
    print(e);
    return false;
  }
}
