import 'package:location_app/constants/enums/user_role_enum.dart';
import 'package:location_app/models/auth/role_model.dart';
import 'package:location_app/resources/strings.dart';

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
