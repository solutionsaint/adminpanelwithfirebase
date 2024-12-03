import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_app/constants/enums/user_role_enum.dart';
import 'package:menu_app/models/auth/user_model.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> changeDBEmail() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }
      DocumentSnapshot userSnapshot =
          await _firestore.collection('lms-users').doc(user.uid).get();
      if (userSnapshot.exists) {
        UserModel userModel =
            UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
        String email = userModel.email;
        String changeEmail = userModel.changeEmail!;

        String role = userModel.role;
        List<String> accessCode = userModel.institute;

        if (email != user.email) {
          await _firestore
              .collection('lms-users')
              .doc(user.uid)
              .update({'email': changeEmail, 'changeEmail': ''});
          if (role == UserRoleEnum.admin.roleName) {
            String code = accessCode.first;
            await _firestore
                .collection('institutes')
                .doc(code)
                .update({'email': changeEmail});
          }
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
