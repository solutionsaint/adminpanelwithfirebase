String parseErrorMessage(dynamic error) {
  String message = error.toString();
  if (message.contains(':')) {
    message = message.split(':').last.trim();
  }
  return message;
}
