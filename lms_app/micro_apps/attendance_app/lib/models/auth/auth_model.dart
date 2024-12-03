import 'package:firebase_auth/firebase_auth.dart';

/// This is the Model Structure for Authentication Response.
/// [AuthModel] has 4 structures(Default, Success, Error, Reset).
/// Use Default [AuthModel] like:
///
///   ```dart
///   AuthModel res = AuthModel({userId: 'userId', email: 'email@g.com', password: '123', error: null: message: null});
///   log.i(res.email);
///   ```
///
class AuthModel {
  final String userId;
  final String email;
  final String? password;
  final bool error;
  final String message;
  final bool isEmailVerified;
  final String userName;
  final String imageUrl;
  final String phoneNumber;
  final AuthCredential? credential;
  final String role;

  const AuthModel({
    required this.userId,
    required this.email,
    this.password,
    required this.error,
    required this.message,
    required this.isEmailVerified,
    required this.userName,
    required this.imageUrl,
    required this.phoneNumber,
    required this.credential,
    required this.role,
  });

  /// Use [AuthModel.success()] named constructor when Authentication is success
  ///
  ///  ```dart
  ///  AuthModel res = AuthModel.success({userId: 'userId', email: 'a@g.com', password: '123',});
  ///  log.i(res.email);
  ///  ```
  ///
  AuthModel.success({
    required String userId,
    required String email,
    String? password,
    required bool isEmailVerified,
    required String userName,
    required String imageUrl,
    required String phoneNumber,
    required AuthCredential? credential,
    required String role,
  }) : this(
          userId: userId,
          email: email,
          password: password,
          error: false,
          message: '',
          isEmailVerified: isEmailVerified,
          userName: userName,
          imageUrl: imageUrl,
          phoneNumber: phoneNumber,
          credential: credential,
          role: role,
        );

  /// Use [AuthModel.error()] named constructor when Authentication is success
  ///
  ///  ```dart
  ///  AuthModel res = AuthModel.error({error: true, message: 'Failed'});
  ///  log.i(res.message);
  ///  ```
  ///
  AuthModel.error({
    required message,
    bool error = true,
  }) : this(
          userId: '',
          email: '',
          password: '',
          isEmailVerified: false,
          error: true,
          message: message,
          userName: '',
          imageUrl: '',
          phoneNumber: '',
          credential: null,
          role: '',
        );

  /// Use [AuthModel.reset()] named constructor when Authentication is success
  ///
  ///  ```dart
  ///  AuthModel res = AuthModel.reset();
  ///  log.i(res.email);
  ///  ```
  ///
  AuthModel.reset()
      : this(
          userId: '',
          password: '',
          email: '',
          error: false,
          message: '',
          isEmailVerified: false,
          userName: '',
          imageUrl: '',
          phoneNumber: '',
          credential: null,
          role: '',
        );
}
