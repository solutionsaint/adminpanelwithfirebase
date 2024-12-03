import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({
    super.key,
    required this.isInstitute,
    required this.name,
    required this.phone,
    required this.email,
    required this.logout,
    required this.isLoading,
    required this.isEditing,
    required this.saveInstituteName,
    required this.setEditing,
    required this.isPhoneLoading,
    required this.isPhoneEditing,
    required this.isEmailLoading,
    required this.isEmailEditing,
    required this.setPhoneEditing,
    required this.setEmailEditing,
    required this.saveUserPhone,
    required this.saveUserEmail,
    required this.addPartnerEmailLoading,
    required this.partnerEmails,
    required this.addPartnerEmail,
    required this.removePartnerEmail,
    this.changeEmail,
  });

  final bool isInstitute;
  final String name;
  final String phone;
  final String email;
  final bool isLoading;
  final bool isEditing;
  final bool isPhoneLoading;
  final bool isPhoneEditing;
  final bool isEmailLoading;
  final bool isEmailEditing;
  final String? changeEmail;
  final List<String> partnerEmails;
  final bool addPartnerEmailLoading;
  final void Function() logout;
  final void Function(String, bool) saveInstituteName;
  final void Function(bool) setEditing;
  final void Function(bool) setPhoneEditing;
  final void Function(bool) setEmailEditing;
  final Future<void> Function(String) saveUserPhone;
  final void Function(BuildContext, String, bool) saveUserEmail;
  final void Function(String) addPartnerEmail;
  final void Function(String) removePartnerEmail;

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreenWidget> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _partnerEmailController = TextEditingController();

  void saveName() {
    _nameController.text = _nameController.text.trim();
    if (_nameController.text.trim().isEmpty) {
      showSnackbar(context, 'Name cannot be empty');
      widget.setEditing(false);
      return;
    }

    if (_nameController.text.trim() == widget.name) {
      showSnackbar(context, 'No changes made');
      widget.setEditing(false);
      return;
    }

    widget.saveInstituteName(_nameController.text.trim(), widget.isInstitute);
  }

  void savePhone() {
    if (_phoneController.text.isEmpty) {
      showSnackbar(context, 'Phone cannot be empty');
      widget.setPhoneEditing(false);
      return;
    }

    if (_phoneController.text == widget.phone) {
      showSnackbar(context, 'No changes made');
      widget.setPhoneEditing(false);
      return;
    }

    widget.saveUserPhone(_phoneController.text);
  }

  void saveEmail() {
    if (_emailController.text.isEmpty) {
      showSnackbar(context, 'Email cannot be empty');
      widget.setPhoneEditing(false);
      return;
    }

    if (_emailController.text == widget.email) {
      showSnackbar(context, 'No changes made');
      widget.setPhoneEditing(false);
      return;
    }
    widget.saveUserEmail(context, _emailController.text, widget.isInstitute);
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;
    _emailController.text = widget.email;
  }

  void onEdit() {
    widget.setEditing(true);
    FocusScope.of(context).requestFocus(_nameFocusNode);
  }

  void onPhoneEdit() {
    widget.setPhoneEditing(true);
    FocusScope.of(context).requestFocus(_phoneFocusNode);
  }

  void onEmailEdit() {
    widget.setEmailEditing(true);
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: screenWidth * 0.9,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: ThemeColors.cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.isInstitute
                                      ? Strings.instituteName
                                      : Strings.userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMediumTitleBrown,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: FormInput(
                                    controller: _nameController,
                                    text: "",
                                    readOnly: !widget.isEditing,
                                    hintText: "",
                                    borderColor: widget.isEditing
                                        ? ThemeColors.primary
                                        : ThemeColors.white,
                                    focusNode: _nameFocusNode,
                                  ),
                                ),
                                widget.isLoading
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 3,
                                      )
                                    : SizedBox(
                                        child: widget.isEditing
                                            ? IconButton(
                                                icon: const Icon(Icons.check),
                                                onPressed: saveName,
                                              )
                                            : IconButton(
                                                onPressed: onEdit,
                                                icon: const Icon(Icons.edit),
                                              ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Strings.contactInfo,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMediumTitleBrown,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: FormInput(
                                    controller: _phoneController,
                                    text: "",
                                    readOnly: !widget.isPhoneEditing,
                                    hintText: "",
                                    borderColor: widget.isPhoneEditing
                                        ? ThemeColors.primary
                                        : ThemeColors.white,
                                    focusNode: _phoneFocusNode,
                                  ),
                                ),
                                widget.isPhoneLoading
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 3,
                                      )
                                    : SizedBox(
                                        child: widget.isPhoneEditing
                                            ? IconButton(
                                                icon: const Icon(Icons.check),
                                                onPressed: savePhone,
                                              )
                                            : IconButton(
                                                onPressed: onPhoneEdit,
                                                icon: const Icon(Icons.edit),
                                              ),
                                      ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Primary Email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMediumTitleBrown,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: FormInput(
                                    controller: _emailController,
                                    text: "",
                                    readOnly: !widget.isEmailEditing,
                                    hintText: "",
                                    borderColor: widget.isEmailEditing
                                        ? ThemeColors.primary
                                        : ThemeColors.white,
                                    focusNode: _emailFocusNode,
                                    helperText: widget.changeEmail!.isNotEmpty
                                        ? 'Verification pending for updated email'
                                        : null,
                                  ),
                                ),
                                widget.isEmailLoading
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 3,
                                      )
                                    : SizedBox(
                                        child: widget.isEmailEditing
                                            ? IconButton(
                                                icon: const Icon(Icons.check),
                                                onPressed: saveEmail,
                                              )
                                            : IconButton(
                                                onPressed: onEmailEdit,
                                                icon: const Icon(Icons.edit),
                                              ),
                                      ),
                              ],
                            ),
                            ...[
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'Partner Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMediumTitleBrown,
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     SizedBox(
                              //       width: 240,
                              //       child: FormInput(
                              //         controller: _partnerEmailController,
                              //         text: "",
                              //         hintText: "",
                              //         borderColor: ThemeColors.white,
                              //       ),
                              //     ),
                              //     widget.addPartnerEmailLoading
                              //         ? const CircularProgressIndicator(
                              //             strokeWidth: 3,
                              //           )
                              //         : SizedBox(
                              //             child: IconButton(
                              //               icon: const Icon(Icons.add),
                              //               onPressed: () =>
                              //                   widget.addPartnerEmail(
                              //                       _partnerEmailController
                              //                           .text),
                              //             ),
                              //           ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: widget.partnerEmails.isEmpty
                                          ? Text(
                                              'No Partner Emails',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          ThemeColors.primary),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  widget.partnerEmails.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.partnerEmails[
                                                              index],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      // IconButton(
                                                      //   icon: Icon(Icons.close,
                                                      //       color:
                                                      //           ThemeColors.primary),
                                                      //   onPressed: () {
                                                      //     widget.removePartnerEmail(
                                                      //         widget.partnerEmails[
                                                      //             index]);
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.phone,
                            //       color: ThemeColors.primary,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Text(
                            //       widget.phone,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .titleSmallTitleBrown,
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.mail_rounded,
                            //       color: ThemeColors.primary,
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Expanded(
                            //       child: Text(
                            //         overflow: TextOverflow.ellipsis,
                            //         maxLines: 2,
                            //         widget.email,
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .titleSmallTitleBrown,
                            //       ),
                            //     )
                            //   ],
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: screenWidth * 0.7,
                height: 50,
                child: IconTextButton(
                  text: Strings.logout,
                  onPressed: widget.logout,
                  color: ThemeColors.primary,
                  iconHorizontalPadding: 5,
                  icon: Icons.logout,
                  iconColor: ThemeColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
