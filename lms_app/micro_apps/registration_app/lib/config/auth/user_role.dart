import 'package:registration_app/constants/enums/user_role_enum.dart';
import 'package:registration_app/models/auth/role_model.dart';
import 'package:registration_app/resources/strings.dart';

final List<RoleModel> userRoles = [
  RoleModel(
    roleId: 1,
    roleName: Strings.user,
    roleConstant: UserRoleEnum.user.roleName,
  ),
  RoleModel(
    roleId: 2,
    roleName: Strings.admin,
    roleConstant: UserRoleEnum.admin.roleName,
  ),
];

final List<RoleTypeModel> userRoleTypes = [
  RoleTypeModel(
    roleTypeId: 1,
    roleTypeName: Strings.teacher,
    roleTypeConstant: UserRoleTypeEnum.teacher.roleName,
  ),
  RoleTypeModel(
    roleTypeId: 2,
    roleTypeName: Strings.student,
    roleTypeConstant: UserRoleTypeEnum.student.roleName,
  ),
];
