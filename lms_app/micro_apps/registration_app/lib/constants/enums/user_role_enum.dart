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

enum UserRoleTypeEnum { student, teacher }

extension UserRoleTypeEnumExtension on UserRoleTypeEnum {
  String get roleName {
    switch (this) {
      case UserRoleTypeEnum.student:
        return 'Student';
      case UserRoleTypeEnum.teacher:
        return 'Teacher';
    }
  }
}
