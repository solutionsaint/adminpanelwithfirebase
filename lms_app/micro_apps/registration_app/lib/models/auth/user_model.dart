class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String role;
  final List<String> institute;
  final String? changeEmail;
  final String? address;
  final String? city;
  final String? profileUrl;
  final String? state;
  final List<String> registeredCourses;
  final List<String> roleType;
  final bool? isFaceRecognized;
  final bool? isSomeone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.institute,
    this.changeEmail,
    this.isSomeone,
    this.profileUrl,
    this.address,
    this.state,
    this.city,
    this.registeredCourses = const [],
    required this.roleType,
    this.isFaceRecognized = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
      changeEmail: data['changeEmail'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      profileUrl: data['profileUrl'] ?? '',
      institute: List<String>.from(data['institute'] ?? []),
      registeredCourses: List<String>.from(data['registeredCourses'] ?? []),
      roleType: List<String>.from(data['roleType'] ?? []),
      isFaceRecognized: data['isFaceRecognized'] ?? false,
      isSomeone: data['isSomeone'] ?? false,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      uid: '',
      name: '',
      email: '',
      role: '',
      phone: '',
      city: '',
      state: '',
      address: '',
      changeEmail: '',
      profileUrl: '',
      institute: [],
      registeredCourses: [],
      roleType: [],
      isFaceRecognized: false,
      isSomeone: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'institute': institute,
      'address': address,
      'city': city,
      'state': state,
      'profileUrl': profileUrl,
      'registeredCourses': registeredCourses,
      'roleType': roleType,
      'isFaceRecognized': isFaceRecognized,
      'changeEmail': changeEmail,
    };
  }
}
