import 'dart:math';

String createInstituteID() {
  const int length = 6;
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  Random random = Random();
  String instituteID = '';

  for (int i = 0; i < length; i++) {
    instituteID += chars[random.nextInt(chars.length)];
  }

  return instituteID;
}
