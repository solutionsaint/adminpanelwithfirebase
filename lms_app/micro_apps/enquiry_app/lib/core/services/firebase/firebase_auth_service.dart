import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/constants/enums/user_role_enum.dart';
import 'package:enquiry_app/models/auth/user_model.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/utils/logger/logger.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this line
  final log = CustomLogger.getLogger('AuthService');
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Private constructor
  FirebaseAuthService._privateConstructor();

  // Static instance variable
  static final FirebaseAuthService _instance =
      FirebaseAuthService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseAuthService() {
    return _instance;
  }

  // Stream to listen to authentication state changes
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String userName,
    String email,
    String password,
    String phone,
    String role,
    String accessCodeId,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final bool isAdmin = role == UserRoleEnum.admin.roleName ? true : false;

      // Create user document in 'lms-users' collection
      await _firestore
          .collection('lms-users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'name': userName,
        'email': email,
        'role': role,
        'phone': phone,
        'institute': isAdmin ? [accessCodeId] : [],
      });

      // If the role is admin, create institute document and add default categories
      if (isAdmin) {
        await _firestore.collection('institutes').doc(accessCodeId).set({
          'uid': accessCodeId,
          'email': email,
          'instituteId': accessCodeId,
          'instituteName': userName,
        });

        // Add default categories under 'institutes > accessCodeId > categories'
        CollectionReference categoriesRef = _firestore
            .collection('institutes')
            .doc(accessCodeId)
            .collection('categories');

        List<Map<String, String>> defaultCategories = [
          {
            'categoryName': 'courses',
            'categoryTitle': 'course',
            'iconUrl':
                'https://firebasestorage.googleapis.com/v0/b/ultrasonic-clinic.appspot.com/o/categories%2Fcourses%2Ficon%2F1000009075.png?alt=media&token=fd2ed7d2-3164-4249-ae1f-45b87e97dd10',
          },
          {
            'categoryName': 'food',
            'categoryTitle': 'food',
            'iconUrl':
                'https://firebasestorage.googleapis.com/v0/b/ultrasonic-clinic.appspot.com/o/categories%2Ffood%2Ficon%2F1000009074.png?alt=media&token=d1cdaa6d-bf55-4471-8234-713570e632a4',
          },
          {
            'categoryName': 'tailor',
            'categoryTitle': 'tailor',
            'iconUrl':
                'https://firebasestorage.googleapis.com/v0/b/ultrasonic-clinic.appspot.com/o/categories%2Ftailor%2Ficon%2F1000009076.png?alt=media&token=91806f40-bcd7-4596-b378-5bbcbdd422f1',
          }
        ];

        for (var category in defaultCategories) {
          await categoriesRef.add(category);
        }
      }

      return userCredential;
    } on FirebaseAuthException {
      log.e('Error signing up: ');
      throw Exception(Strings.invalidCredentials);
    } catch (e) {
      throw Exception(Strings.anErrorOccurred);
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  // Sign out
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      log.e('Error signing out: $e');
      return false;
    }
  }

  // Fetch user role from Firestore
  Future<String> getUserRole(User user) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('lms-users').doc(user.uid).get();
      if (doc.exists) {
        return doc['role'] ?? 'student';
      } else {
        return 'student'; // default role if no data found
      }
    } catch (e) {
      log.e('Error fetching user role: $e');
      rethrow;
    }
  }

  // Fetch user from Firebase
  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('lms-users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return UserModel.empty();
      }
    } catch (e) {
      log.e('Error fetching user: $e');
      rethrow;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log.e("Error sending password reset email: $e");
      return false;
    }
  }

  Future<User?> changeUserPassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        UserCredential newUserCredential =
            await user.reauthenticateWithCredential(credential);
        await newUserCredential.user!.updatePassword(newPassword);
        return newUserCredential.user;
      } else {
        log.e("No user is currently signed in.");
        return null;
      }
    } catch (e) {
      log.e("Error resetting password: $e");
      return null;
    }
  }

  Future<bool> doesInstituteExist(String instituteId) async {
    try {
      DocumentSnapshot instituteDoc =
          await _firestore.collection('institutes').doc(instituteId).get();
      return instituteDoc.exists;
    } catch (e) {
      log.e('Error checking institute existence: $e');
      return false;
    }
  }

  Future<bool> updateUserInstitutes(String uid, List<String> institutes) async {
    try {
      await _firestore.collection('lms-users').doc(uid).update({
        'institute': institutes,
      });
      log.i('institutes updated successfully for user $uid');
      return true;
    } catch (e) {
      log.e('Error updating institutes for user $uid: $e');
      return false;
    }
  }

  Future<void> updateInstituteName(String accessCode, String name) async {
    try {
      await _firestore.collection('institutes').doc(accessCode).update({
        'instituteName': name,
      });
    } catch (e) {
      log.e('Error updating institute name: $e');
      throw Exception('Error updating institute name: $e');
    }
  }

  Future<void> updateUserName(String uid, String name) async {
    try {
      await _firestore.collection('lms-users').doc(uid).update({
        'name': name,
      });
    } catch (e) {
      log.e('Error updating user name: $e');
      throw Exception('Error updating user name: $e');
    }
  }

  Future<void> updateUserPhone(String uid, String phone) async {
    try {
      await _firestore.collection('lms-users').doc(uid).update({
        'phone': phone,
      });
    } catch (e) {
      log.e('Error updating user name: $e');
      throw Exception('Error updating user name: $e');
    }
  }

  Future<bool> updateUserEmail(
    String uid,
    String newEmail,
    String password,
  ) async {
    try {
      User? user = _firebaseAuth.currentUser;
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('lms-users')
          .where('email', isEqualTo: newEmail)
          .limit(1)
          .get();
      if (result.docChanges.isNotEmpty) {
        return false;
      }
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        UserCredential reAuthenticatedCredential =
            await user.reauthenticateWithCredential(credential);
        await reAuthenticatedCredential.user!.verifyBeforeUpdateEmail(newEmail);
        await _firestore.collection('lms-users').doc(uid).update({
          'changeEmail': newEmail,
        });
        return await signOut();
      }
      return false;
    } catch (e) {
      log.e('Error updating user name: $e');
      throw Exception('Error updating user name: $e');
    }
  }
}
