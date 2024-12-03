class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String role;
  final List<String> institute;
  final String? address;
  final String? city;
  final String? profileUrl;
  final String? state;
  final List<String> registeredCourses;
  final String? changeEmail;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.institute,
    this.profileUrl,
    this.address,
    this.state,
    this.city,
    this.changeEmail,
    this.registeredCourses = const [],
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      changeEmail: data['changeEmail'] ?? '',
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
      phone: '',
      city: '',
      state: '',
      address: '',
      changeEmail: '',
      profileUrl: '',
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
