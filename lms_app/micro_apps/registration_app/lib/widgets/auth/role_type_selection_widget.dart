import 'package:flutter/material.dart';
import 'package:registration_app/resources/images.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/custom_elevated_button.dart';

class RoleTypeSelectionWidget extends StatefulWidget {
  const RoleTypeSelectionWidget({
    super.key,
    required this.isLoading,
    required this.onSubmit,
  });

  final bool isLoading;
  final Function(String) onSubmit;

  @override
  State<RoleTypeSelectionWidget> createState() =>
      _RoleTypeSelectionWidgetState();
}

class _RoleTypeSelectionWidgetState extends State<RoleTypeSelectionWidget> {
  String? _selectedRole;

  void onSubmitType() {
    widget.onSubmit(_selectedRole ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Registration List',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoleCard('Student', Images.student),
              _buildRoleCard('Teacher', Images.teacher),
            ],
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            isLoading: widget.isLoading,
            text: 'Submit',
            onPressed: _selectedRole != null ? onSubmitType : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(String role, String imagePath) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: ThemeColors.brown, width: 2)
              : Border.all(color: ThemeColors.white, width: 2),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
