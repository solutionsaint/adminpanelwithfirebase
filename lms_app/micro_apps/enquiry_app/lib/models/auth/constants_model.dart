class ConstantsModel {
  final String loggedInStatusFlag;

  ConstantsModel({
    required this.loggedInStatusFlag,
  });

  // Factory method to create a ConstantsModel from a map
  factory ConstantsModel.fromMap(Map<String, dynamic> map) {
    return ConstantsModel(
      loggedInStatusFlag: map['loggedInStatusFlag'] as String,
    );
  }
}
