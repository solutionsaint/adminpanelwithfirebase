class ConstantsModel {
  final String loggedInStatusFlag;
  final String apiKey;

  ConstantsModel({
    required this.loggedInStatusFlag,
    required this.apiKey,
  });

  // Factory method to create a ConstantsModel from a map
  factory ConstantsModel.fromMap(Map<String, dynamic> map) {
    return ConstantsModel(
      loggedInStatusFlag: map['loggedInStatusFlag'] as String,
      apiKey: map['apiKey'] as String,
    );
  }
}
