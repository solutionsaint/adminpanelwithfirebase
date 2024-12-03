String sentenceCase(String value) {
  final name = value.trim();
  String firstLetter = name[0].toUpperCase();
  String restOfSentence = name.substring(1).toLowerCase();
  return firstLetter + restOfSentence;
}
