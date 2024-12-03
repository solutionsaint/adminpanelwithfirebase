import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:registration_app/constants/constants.dart';
import 'package:registration_app/core/services/auth/auth_service.dart';
import 'package:registration_app/core/services/firebase/firebase_auth_service.dart';
import 'package:registration_app/core/services/firebase/firebase_storage_service.dart';
import 'package:registration_app/models/auth/auth_model.dart';
import 'package:registration_app/models/auth/user_model.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/utils/error/parse_exception.dart';
import 'package:registration_app/utils/get_institute_id.dart';
import 'package:registration_app/utils/logger/logger.dart';
import 'package:registration_app/utils/shared_preference/shared_preference.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = true;
  UserModel? _currentUser;
  bool _loggedInStatus = false;
  String selectedinstituteCode = "";
  List<CourseModel> _cart = [];

  final log = CustomLogger.getLogger('AuthProvider');
  final storageService = FirebaseStorageService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get user => _user;
  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  bool get loggedInStatus => _loggedInStatus;
  List<CourseModel> get cart => _cart;

  set cart(List<CourseModel> cart) {
    _cart = cart;
    notifyListeners();
  }

  AuthProvider() {
    _delayUserCheck();
  }

  Future<void> _delayUserCheck() async {
    await Future.delayed(const Duration(seconds: 1));
    _checkUser();
  }

  void updateRegisteredCourses(String courseId) {
    notifyListeners();
  }

  Future<String> getInstituteName(String accessCode) async {
    try {
      final instituteRef =
          FirebaseFirestore.instance.collection('institutes').doc(accessCode);

      final docSnapshot = await instituteRef.get();

      final data = docSnapshot.data();
      return data!['instituteName'];
    } catch (e) {
      return "";
    }
  }

  void updateRegisteredCoursesList(List<String> courseIds) {
    if (_currentUser != null) {
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        name: _currentUser!.name,
        email: _currentUser!.email,
        role: _currentUser!.role,
        phone: _currentUser!.phone,
        institute: _currentUser!.institute,
        profileUrl: _currentUser!.profileUrl,
        address: _currentUser!.address,
        state: _currentUser!.state,
        city: _currentUser!.city,
        registeredCourses: [..._currentUser!.registeredCourses, ...courseIds],
        roleType: _currentUser!.roleType,
        isFaceRecognized: _currentUser!.isFaceRecognized ?? false,
        isSomeone: _currentUser!.isSomeone,
        changeEmail: _currentUser!.changeEmail,
      );
    }
    notifyListeners();
  }

  void saveFaceRecognitionFlag() {
    if (_currentUser != null) {
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        name: _currentUser!.name,
        email: _currentUser!.email,
        role: _currentUser!.role,
        phone: _currentUser!.phone,
        institute: _currentUser!.institute,
        profileUrl: _currentUser!.profileUrl,
        address: _currentUser!.address,
        state: _currentUser!.state,
        city: _currentUser!.city,
        registeredCourses: _currentUser!.registeredCourses,
        roleType: _currentUser!.roleType,
        isFaceRecognized: true,
        isSomeone: _currentUser!.isSomeone,
        changeEmail: _currentUser!.changeEmail,
      );
    }
    notifyListeners();
  }

  // void setUserRoleType(String roleType) {
  //   _currentUser = UserModel(
  //     uid: _currentUser!.uid,
  //     name: _currentUser!.name,
  //     email: _currentUser!.email,
  //     role: _currentUser!.role,
  //     phone: _currentUser!.phone,
  //     institute: _currentUser!.institute,
  //     profileUrl: _currentUser!.profileUrl,
  //     address: _currentUser!.address,
  //     state: _currentUser!.state,
  //     city: _currentUser!.city,
  //     registeredCourses: _currentUser!.registeredCourses,
  //     roleType: roleType,
  //     isFaceRecognized: _currentUser!.isFaceRecognized ?? false,
  //     isSomeone: _currentUser!.isSomeone,
  //   );
  //   notifyListeners();
  // }

  Future<bool> updateUserPhone(String phone) async {
    try {
      await FirebaseAuthService().updateUserPhone(
        _currentUser!.uid,
        phone,
      );
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        name: _currentUser!.name,
        email: _currentUser!.email,
        role: _currentUser!.role,
        phone: phone,
        address: _currentUser!.address,
        institute: _currentUser!.institute,
        state: _currentUser!.state,
        city: _currentUser!.city,
        profileUrl: _currentUser!.profileUrl,
        registeredCourses: _currentUser!.registeredCourses,
        changeEmail: _currentUser!.changeEmail,
        roleType: _currentUser!.roleType,
        isFaceRecognized: _currentUser!.isFaceRecognized ?? false,
        isSomeone: _currentUser!.isSomeone ?? false,
      );
      notifyListeners();
      return true;
    } catch (e) {
      log.e('Failed to update user name: $e');
      return false;
    }
  }

  void addToCart(CourseModel course) {
    _cart.add(course);
    notifyListeners();
  }

  void removeFromCart(String courseId) {
    _cart.removeWhere((course) => course.courseId == courseId);
    notifyListeners();
  }

  Future<void> _checkUser() async {
    final User? user = FirebaseAuthService().currentUser;
    if (user != null) {
      await user.reload();
      final User? reloadedUser = FirebaseAuthService().currentUser;
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      final loggedInStatus = loggedInStatuses.status
          ? loggedInStatuses.value[user.uid] ?? false
          : false;
      if (loggedInStatus) {
        final loggedUser = await FirebaseAuthService().getUser(user.uid);
        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          institute: loggedUser.institute,
          profileUrl: user.photoURL,
          state: loggedUser.state,
          city: loggedUser.city,
          address: loggedUser.address,
          registeredCourses: loggedUser.registeredCourses,
          roleType: loggedUser.roleType,
          isFaceRecognized: loggedUser.isFaceRecognized ?? false,
          isSomeone: loggedUser.isSomeone ?? false,
          changeEmail: loggedUser.changeEmail,
        );
      }
      _loggedInStatus = loggedInStatus;
      _user = reloadedUser;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthModel> signUp(
    String userName,
    String email,
    String password,
    String phone,
    String role,
  ) async {
    try {
      final instituteId = createInstituteID();
      final credential = await FirebaseAuthService().signUpWithEmailAndPassword(
        userName,
        email,
        password,
        phone,
        role,
        instituteId,
      );
      await credential.user!.sendEmailVerification();
      return AuthModel.success(
        userName: userName,
        email: email,
        password: password,
        credential: credential.credential,
        isEmailVerified: credential.user!.emailVerified,
        userId: credential.user!.uid,
        phoneNumber: '',
        imageUrl: credential.user!.photoURL ?? '',
        role: role,
      );
    } catch (e) {
      log.e(e);
      return AuthModel.error(message: parseErrorMessage(e.toString()));
    }
  }

  Future<AuthModel> signIn(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuthService().signInWithEmailAndPassword(
        email,
        password,
      );
      if (userCredential.user != null) {
        final loggedUser =
            await FirebaseAuthService().getUser(userCredential.user!.uid);
        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          address: loggedUser.address,
          institute: loggedUser.institute,
          state: loggedUser.state,
          city: loggedUser.city,
          profileUrl: userCredential.user!.photoURL,
          registeredCourses: loggedUser.registeredCourses,
          roleType: loggedUser.roleType,
          isFaceRecognized: loggedUser.isFaceRecognized ?? false,
          isSomeone: loggedUser.isSomeone ?? false,
          changeEmail: loggedUser.changeEmail,
        );
        if (loggedUser.uid != '') {
          return AuthModel.success(
            userName: loggedUser.name,
            email: email,
            password: password,
            credential: userCredential.credential,
            isEmailVerified: userCredential.user!.emailVerified,
            userId: userCredential.user!.uid,
            phoneNumber: loggedUser.phone,
            imageUrl: userCredential.user!.photoURL ?? '',
            role: loggedUser.role,
          );
        }
      }
      // notifyListeners();
      return AuthModel.error(message: 'An error occurred!');
    } catch (e) {
      log.i('Error fetching user: $e');
      return AuthModel.error(message: parseErrorMessage(e.toString()));
    }
  }

  Future<bool> saveUser(Map<String, String> data, File? profile) async {
    User? user = FirebaseAuth.instance.currentUser;
    String? url = user?.photoURL;
    if (user != null) {
      try {
        // If profile is not null, upload the new picture to storage and get the URL
        if (profile != null) {
          url = await storageService.uploadFile(
            profile,
            'users/${user.uid}/profile',
            user.uid,
          );
        }

        // Update the user's profile
        await user.updateProfile(displayName: data['name'], photoURL: url);
        await user.reload();
        user = FirebaseAuth.instance.currentUser!;

        // Update Firestore document
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        data.removeWhere((key, value) => value.isEmpty);
        await userRef.update(data);

        // Fetch the updated user data
        final loggedUser = await FirebaseAuthService().getUser(user.uid);

        // Update the current user model
        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          address: loggedUser.address,
          institute: loggedUser.institute,
          state: loggedUser.state,
          city: loggedUser.city,
          profileUrl: url,
          registeredCourses: loggedUser.registeredCourses,
          roleType: loggedUser.roleType,
          isFaceRecognized: loggedUser.isFaceRecognized ?? false,
          isSomeone: loggedUser.isSomeone ?? false,
          changeEmail: loggedUser.changeEmail,
        );

        notifyListeners();
        return true;
      } catch (e) {
        log.e('Failed to update user: $e');
        throw Exception('Failed to update user');
      }
    }
    return false;
  }

  Future<AuthModel> signInWithGoogle() async {
    try {
      final userCredential = await FirebaseAuthService().signInWithGoogle();
      if (userCredential!.user != null) {
        final user = userCredential.user!;

        // Check if the user exists in Firestore
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userSnapshot = await userDoc.get();

        if (!userSnapshot.exists) {
          // User does not exist, create a new user document
          await _createUserInFirestore(user);
        }

        final loggedUser = await FirebaseAuthService().getUser(user.uid);

        _currentUser = UserModel(
          uid: loggedUser.uid,
          name: loggedUser.name,
          email: loggedUser.email,
          role: loggedUser.role,
          phone: loggedUser.phone,
          address: loggedUser.address,
          institute: loggedUser.institute,
          state: loggedUser.state,
          city: loggedUser.city,
          profileUrl: user.photoURL,
          registeredCourses: loggedUser.registeredCourses,
          roleType: loggedUser.roleType,
          isFaceRecognized: loggedUser.isFaceRecognized ?? false,
          isSomeone: loggedUser.isSomeone ?? false,
          changeEmail: loggedUser.changeEmail,
        );
        _user = user;
        _loggedInStatus = true;
        notifyListeners();

        return AuthModel.success(
          isEmailVerified: user.emailVerified,
          userName: loggedUser.name,
          email: loggedUser.email,
          userId: user.uid,
          phoneNumber: loggedUser.phone,
          imageUrl: user.photoURL ?? '',
          role: loggedUser.role,
          credential: userCredential.credential,
        );
      } else {
        return AuthModel.error(
            message: 'An error occurred during Google Sign-In.');
      }
    } catch (e) {
      log.e('Error signing in with Google: $e');
      return AuthModel.error(message: parseErrorMessage(e.toString()));
    }
  }

  Future<void> _createUserInFirestore(User user) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userData = {
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'role': 'patient',
        'phone': user.phoneNumber ?? '',
      };

      await userRef.set(userData, SetOptions(merge: true));
    } catch (e) {
      log.e('Error creating user document: $e');
    }
  }

  Future<bool> signOut() async {
    try {
      final response = await FirebaseAuthService().signOut();
      await _googleSignIn.signOut();
      if (response) {
        _user = null;
        _currentUser = null;
        _loggedInStatus = false;
        return true;
      }
      return false;
    } catch (e) {
      log.e('Failed to sign out: $e');
      return false;
    }
  }

  Future<bool> changeUserPassword(
    String email,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await FirebaseAuthService().changeUserPassword(
        email,
        oldPassword,
        newPassword,
      );
      if (response != null) {
        await response.reload();
        final User? reloadedUser = FirebaseAuthService().currentUser;
        _user = reloadedUser;
        return true;
      }
      return false;
    } catch (e) {
      log.e('Failed to reset password: $e');
      return false;
    }
  }

  Future<bool> checkExistingInstituteCode(String instituteCode) async {
    if (currentUser!.institute.isEmpty ||
        !currentUser!.institute.contains(instituteCode)) {
      bool doesClinicExists =
          await FirebaseAuthService().doesInstituteExist(instituteCode);

      if (!doesClinicExists) {
        return false;
      }
      final response = await FirebaseAuthService().updateUserInstitutes(
        currentUser!.uid,
        [instituteCode, ...currentUser!.institute],
      );
      final User? user = FirebaseAuthService().currentUser;

      if (response && currentUser != null) {
        selectedinstituteCode = instituteCode;
        _currentUser = UserModel(
          uid: currentUser!.uid,
          name: currentUser!.name,
          email: currentUser!.email,
          role: currentUser!.role,
          phone: currentUser!.phone,
          address: currentUser!.address,
          state: currentUser!.state,
          city: currentUser!.city,
          institute: [instituteCode, ...currentUser!.institute],
          profileUrl: user!.photoURL,
          roleType: currentUser!.roleType,
          isFaceRecognized: currentUser!.isFaceRecognized ?? false,
          isSomeone: currentUser!.isSomeone ?? false,
          changeEmail: currentUser!.changeEmail,
        );
        notifyListeners();
        return true;
      }
      return false;
    } else {
      selectedinstituteCode = instituteCode;
      notifyListeners();
      return true;
    }
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('lms-users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      log.e('Error checking email existence: $e');
      return true;
    }
  }

  Future<String> createLMSUser(
    String uid,
    String name,
    String email,
    String role,
    String phone,
    List<String> roleType,
  ) async {
    return await FirebaseAuthService().createLMSUser(
      uid,
      name,
      email,
      role,
      phone,
      roleType,
    );
  }

  Future<bool> updateUserRoleType(String roleType, String uid) async {
    return await FirebaseAuthService().updateUserRoleType(roleType, uid);
  }

  Future<bool> updateUserName(
      String accessCode, String name, bool isInstitute) async {
    try {
      if (isInstitute) {
        await FirebaseAuthService().updateInstituteName(accessCode, name);
      }
      await FirebaseAuthService().updateUserName(
        _currentUser!.uid,
        name,
      );
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        name: name,
        email: _currentUser!.email,
        role: _currentUser!.role,
        phone: _currentUser!.phone,
        address: _currentUser!.address,
        institute: _currentUser!.institute,
        state: _currentUser!.state,
        city: _currentUser!.city,
        profileUrl: _currentUser!.profileUrl,
        registeredCourses: _currentUser!.registeredCourses,
        roleType: _currentUser!.roleType,
        isFaceRecognized: _currentUser!.isFaceRecognized,
        isSomeone: _currentUser!.isSomeone,
        changeEmail: _currentUser!.changeEmail,
      );
      notifyListeners();
      return true;
    } catch (e) {
      log.e('Failed to update user name: $e');
      return false;
    }
  }

  Future<bool> updateUserEmail(String email, String password) async {
    try {
      final response = await FirebaseAuthService()
          .updateUserEmail(_currentUser!.uid, email, password);
      return response;
    } catch (e) {
      log.e('Failed to update user name: $e');
      return false;
    }
  }

  Future<bool> changeDBEmail() async {
    final response = await AuthService().changeDBEmail();

    if (response) {
      _currentUser = UserModel(
        uid: _currentUser!.uid,
        name: _currentUser!.name,
        email: _currentUser!.changeEmail!,
        role: _currentUser!.role,
        phone: _currentUser!.phone,
        address: _currentUser!.address,
        institute: _currentUser!.institute,
        state: _currentUser!.state,
        city: _currentUser!.city,
        profileUrl: _currentUser!.profileUrl,
        registeredCourses: _currentUser!.registeredCourses,
        roleType: _currentUser!.roleType,
        changeEmail: '',
      );
      // notifyListeners();
    }
    return response;
  }
}
