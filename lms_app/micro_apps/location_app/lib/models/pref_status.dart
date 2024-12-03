import 'package:flutter/foundation.dart';

/// This is the model structure for shared preference data.
/// Use [PrefStatus] constructor when Authentication is success.
///
///  ```dart
///  PrefStatus res = PrefStatus({status: true, value: 'test'});
///  log.i(res.status);
///  ```
///
class PrefStatus {
  final dynamic status;
  final dynamic value;
  const PrefStatus({
    @required this.status,
    @required this.value,
  });
}
