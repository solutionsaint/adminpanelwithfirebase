enum UserRoleEnum { admin, user }

extension UserRoleEnumExtension on UserRoleEnum {
  String get roleName {
    switch (this) {
      case UserRoleEnum.user:
        return 'User';
      case UserRoleEnum.admin:
        return 'Admin';
      default:
        return '';
    }
  }
}
