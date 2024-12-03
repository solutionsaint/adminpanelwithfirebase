import 'package:attendance_app/models/auth/constants_model.dart';

final constantsMap = {
  'loggedInStatusFlag': 'loggedInStatusFlag',
};
final accessCodeMap = {
  'accessCodeFlag': 'accessCodeFlag',
};

final passwordMap = {
  'passwordFlag': 'passwordFlag',
};

class AccessCodeConstantsModel {
  final String accessCodeFlag;
  AccessCodeConstantsModel({
    required this.accessCodeFlag,
  });

  // Factory method to create a AccessCodeConstantsModel from a map
  factory AccessCodeConstantsModel.fromMap(Map<String, dynamic> map) {
    return AccessCodeConstantsModel(
      accessCodeFlag: map['accessCodeFlag'] as String,
    );
  }
}

class PasswordModel {
  final String passwordFlag;
  PasswordModel({
    required this.passwordFlag,
  });

  // Factory method to create a PasswordModel from a map
  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      passwordFlag: map['passwordFlag'] as String,
    );
  }
}

final passwordConstants = PasswordModel.fromMap(passwordMap);

final accessCodeConstants = AccessCodeConstantsModel.fromMap(accessCodeMap);

final constants = ConstantsModel.fromMap(constantsMap);
