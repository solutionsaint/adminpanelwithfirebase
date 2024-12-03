import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:registration_app/constants/enums/button_size.dart';
import 'package:registration_app/resources/regex.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/custom_elevated_button.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/themes/fonts.dart';

class KidRegistrationWidget extends StatefulWidget {
  const KidRegistrationWidget({
    super.key,
    required this.mobileNumber,
    required this.isLoading,
    required this.registerKid,
  });

  final String mobileNumber;
  final bool isLoading;
  final Function(String, String, String, String) registerKid;

  @override
  State<KidRegistrationWidget> createState() => _KidRegistrationWidgetState();
}

class _KidRegistrationWidgetState extends State<KidRegistrationWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _userName;
  String? _userEmail;
  String? _phone;
  String? _userPassword;
  String? _userConfirmPassword;
  bool _isTermsAccepted = false;
  String? _isTermsAcceptedError;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phone = widget.mobileNumber;
  }

  void revealPassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void revealConfirmPassword() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _handleCheckBox(bool? value) {
    setState(() {
      _isTermsAccepted = value!;
      _isTermsAcceptedError = null;
    });
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate() && _isTermsAccepted) {
      _formKey.currentState!.save();
      widget.registerKid(_userName!, _userEmail!, _phone!, _userPassword!);
    } else if (!_isTermsAccepted) {
      setState(() {
        _isTermsAcceptedError = "Please read the terms and agree!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: ThemeColors.white),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 70),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormInput(
              text: 'Name',
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.invalidFullName;
                }
                return null;
              },
              onSaved: (value) => {_userName = value!},
              initialValue: _userName,
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => {_userEmail = value!},
              initialValue: _userEmail,
              validator: (value) {
                final emailPattern = RegExp(Regex.emailRegEx);
                if (value == null ||
                    value.isEmpty ||
                    !emailPattern.hasMatch(value)) {
                  return Strings.invalidEmail;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.mobileNumber,
              keyboardType: TextInputType.phone,
              onSaved: (value) => {_phone = value!},
              initialValue: _phone,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return Strings.invalidMobileNumber;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.password,
              keyboardType: TextInputType.text,
              onSaved: (value) => {_userPassword = value!},
              suffixIcon: InkWell(
                onTap: revealPassword,
                child: _isPasswordVisible
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              obscureText: _isPasswordVisible,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return Strings.passwordValidationString;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormInput(
              text: Strings.confirmPassword,
              keyboardType: TextInputType.text,
              onSaved: (value) => {_userConfirmPassword = value!},
              suffixIcon: InkWell(
                onTap: revealConfirmPassword,
                child: _isConfirmPasswordVisible
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.remove_red_eye_outlined),
              ),
              obscureText: _isConfirmPasswordVisible,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passwordController.text) {
                  return Strings.passwordsShouldMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  activeColor: ThemeColors.black,
                  onChanged: _handleCheckBox,
                ),
                Flexible(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.iAgreeWithThe,
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumBlack
                              .copyWith(fontSize: 15.0),
                        ),
                        TextSpan(
                          text: Strings.termsAndConditions,
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumPrimary
                              .copyWith(fontSize: 15.0),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (_isTermsAcceptedError != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _isTermsAcceptedError!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ThemeColors.primary),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: Strings.register,
                buttonSize: ButtonSize.large,
                onPressed: _handleSignup,
                isLoading: widget.isLoading,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
