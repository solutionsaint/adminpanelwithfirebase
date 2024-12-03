class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String role;
  final List<String> roleType;
  final List<String> institute;
  final String? changeEmail;
  final String? address;
  final String? city;
  final String? profileUrl;
  final String? state;
  final List<String> registeredCourses;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.roleType,
    required this.phone,
    required this.institute,
    this.changeEmail,
    this.profileUrl,
    this.address,
    this.state,
    this.city,
    this.registeredCourses = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      roleType: List<String>.from(data['roleType'] ?? []),
      phone: data['phone'] ?? '',
      changeEmail: data['changeEmail'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      profileUrl: data['profileUrl'] ?? '',
      institute: List<String>.from(data['institute'] ?? []),
      registeredCourses: List<String>.from(data['registeredCourses'] ?? []),
    );
  }

  factory UserModel.empty() {
    return UserModel(
      uid: '',
      name: '',
      email: '',
      role: '',
      roleType: [],
      phone: '',
      city: '',
      state: '',
      address: '',
      profileUrl: '',
      changeEmail: '',
      institute: [],
      registeredCourses: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'roleType': roleType,
      'phone': phone,
      'institute': institute,
      'address': address,
      'city': city,
      'state': state,
      'profileUrl': profileUrl,
      'registeredCourses': registeredCourses,
      'changeEmail': changeEmail,
    };
  }
}
