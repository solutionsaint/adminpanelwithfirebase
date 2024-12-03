import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_app/models/courses/search_model.dart';
import 'package:menu_app/models/courses/suggestion_category_model.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/admin/add_title_card.dart';
import 'package:menu_app/widgets/admin/batch_offered_card.dart';
import 'package:menu_app/widgets/common/custom_dashed_input.dart';
import 'package:menu_app/widgets/common/custom_elevated_button.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/registration_media_dialog.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';

class AddItemWidget extends StatefulWidget {
  const AddItemWidget({
    super.key,
    required this.isLoading,
    required this.addItem,
    required this.subCategory,
    required this.onAddSuggestion,
    required this.superCategories,
    required this.categories,
    required this.suggestionHierarchy,
  });

  final bool isLoading;
  final Function(Map<String, dynamic>, List<File> images) addItem;
  final String subCategory;
  final List<String> superCategories;
  final List<String> categories;
  final Future<bool> Function(String name, File) onAddSuggestion;
  final List<SuggestionCategoriesModel> suggestionHierarchy;

  @override
  AddItemWidgetState createState() => AddItemWidgetState();
}

class AddItemWidgetState extends State<AddItemWidget> {
  final _formKey = GlobalKey<FormState>();
  // final titleController = TextEditingController();
  String title = '';
  List<SearchModel> _manualSearch = [];
  List<SearchModel> _suggestionSearch = [];
  List<File?> _image = [];
  bool _isUploadValid = true;
  bool _isBatchOfferedSelected = false;
  String? _isBatchOfferedError;
  String? _titleError;
  String _itemTitle = '';
  String _shortDescription = '';
  String _aboutDescription = '';
  List<String> _selectedDays = [];
  List<String> _batchTime = [];
  String _amountDetails = '';
  String _totalHours = '';
  int _selectedFieldType = -1;
  bool showInputType = false;
  bool isFieldEnabled = true;

  final _picker = ImagePicker();

  void _handleBatchOfferedDaysChange(List<String> days) {
    setState(() {
      _selectedDays = days;
    });
  }

  void _handleTitleChange(String value,
      [String? suggestionImageURL, bool? skip]) {
    List<String> newItems = value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    setState(() {
      title = value;
      _itemTitle = value;
      _titleError = null;
      if (skip == null || skip == false) {
        showInputType = value.isEmpty ||
                value[value.length - 1] == ',' ||
                value[value.length - 1] == ' '
            ? true
            : false;
        _selectedFieldType = -1;
        isFieldEnabled = true;
      }
      Set<String> oldItems = Set.from(_manualSearch.map((item) => item.name))
        ..addAll(_suggestionSearch.map((item) => item.name));
      Set<String> newItemSet = Set.from(newItems);

      // Find items to remove
      Set<String> itemsToRemove = oldItems.difference(newItemSet);

      // Remove items from _manualSearch and _suggestionSearch
      _manualSearch.removeWhere((item) => itemsToRemove.contains(item.name));
      _suggestionSearch
          .removeWhere((item) => itemsToRemove.contains(item.name));

      // Find items to add
      Set<String> itemsToAdd = newItemSet.difference(oldItems);

      // Add new items to _manualSearch
      _manualSearch.addAll(itemsToAdd.map((item) => SearchModel(
            name: item,
            valid: false,
            file: null,
          )));

      // If a new suggestion was added
      if (suggestionImageURL != null && newItems.isNotEmpty) {
        String lastItem = newItems.last;
        if (!_suggestionSearch
            .any((suggestion) => suggestion.name == lastItem)) {
          _suggestionSearch.add(SearchModel(
            name: lastItem,
            valid: true,
            url: suggestionImageURL,
          ));
          // Remove the last item from _manualSearch if it was added there
          // _manualSearch.removeWhere((item) => item.name == lastItem);
        }
      }
    });
  }

  void onSelectSuggestion(QueryDocumentSnapshot suggestion, bool? skip) {
    final SearchModel _suggestion = SearchModel(
        name: suggestion['name'], valid: true, url: suggestion['image']);
    if (skip == false || skip == null) {
      _manualSearch.add(_suggestion);
    } else {
      _suggestionSearch.add(_suggestion);
    }
    if (skip == false || skip == null) {
      _handleTitleChange(
        '${title.isNotEmpty ? title : ''}${suggestion['name']}',
        suggestion['image'],
        skip,
      );
    } else {
      _handleTitleChange(
        '${title.isNotEmpty ? (title[title.length - 1] == ',' ? title : '$title,') : ''}${suggestion['name']}',
        suggestion['image'],
        skip,
      );
    }
  }

  void onDeselectSuggestion(QueryDocumentSnapshot suggestion, bool? skip) {
    if (skip == false || skip == null) {
      _manualSearch.removeWhere((search) => search.name == suggestion['name']);
    } else {
      _suggestionSearch
          .removeWhere((search) => search.name == suggestion['name']);
    }
    // _suggestionSearch
    //     .removeWhere((search) => search.name == suggestion['name']);
    final inputValue =
        title.split(',').where((val) => val != suggestion['name']).join(',');
    if (skip == false || skip == null) {
      _handleTitleChange(
        inputValue,
        null,
        skip,
      );
    } else {
      _handleTitleChange(
        inputValue,
        null,
        skip,
      );
    }
  }

  void _handleSelectedFieldType(int value) {
    setState(() {
      _selectedFieldType = value;
      isFieldEnabled = false;
    });
  }

  void resetFieldEnabled(int value) {
    setState(() {
      _selectedFieldType = value;
      isFieldEnabled = true;
    });
  }

  void onSaveMedia(List<File?> files) {
    setState(() {
      _manualSearch = _manualSearch.asMap().entries.map((entry) {
        int index = entry.key;
        SearchModel e = entry.value;
        return SearchModel(
          name: e.name,
          valid: true,
          file: files.length > index ? files[index] : null,
        );
      }).toList();
    });
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _image = [];
    setState(() {
      _isUploadValid = true;
      _itemTitle = '';
      _shortDescription = '';
      _aboutDescription = '';
      _selectedDays = [];
      _batchTime = [];
      _amountDetails = '';
      _totalHours = '';
      _isBatchOfferedSelected = false;
      _isBatchOfferedError = null;
      _titleError = null;
      title = '';
      // titleController.clear();
    });
  }

  void _onAddItem() {
    if (_selectedDays.isEmpty || _batchTime.isEmpty) {
      showSnackbar(context, "Select Time and Days");
      return;
    }
    bool isFormValid = _formKey.currentState!.validate();
    if (_manualSearch.any((item) => !item.valid)) {
      setState(() {
        _isUploadValid = false;
      });
      showSnackbar(context, 'Please upload all images');
      return;
    }

    if (_itemTitle == '') {
      setState(() {
        _titleError = "Invalid title";
      });
      return;
    }

    if (widget.subCategory == 'courses' && _isBatchOfferedSelected == false) {
      setState(() {
        _isBatchOfferedError = "Invalid batch offered";
      });
      return;
    }
    if (isFormValid) {
      _formKey.currentState!.save();
      Map<String, dynamic> formData = {
        'itemTitle': _itemTitle,
        'manualSearch': _manualSearch,
        'suggestionSearch': _suggestionSearch,
        'shortDescription': _shortDescription,
        'aboutDescription': _aboutDescription,
        'batchDay': widget.subCategory == 'courses' ? _selectedDays : null,
        'batchTime': widget.subCategory == 'courses' ? _batchTime : null,
        'amount': _amountDetails,
        'totalHours':
            _totalHours.trim().isNotEmpty ? int.parse(_totalHours) : null,
      };

      widget.addItem({...formData}, _image.whereType<File>().toList());
      resetForm();
    }
  }

  void _onProfileUpload() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegistrationMediaDialog(
          itemTitles: _manualSearch.map((e) => e.name).toList(),
          mediaHeading: Strings.addImage,
          onSaveMedia: onSaveMedia,
        );
      },
    );
  }

  void _handleBatchOfferedChange(bool? value) {
    setState(() {
      _isBatchOfferedSelected = value!;
      _isBatchOfferedError = null;
    });
  }

  void _handleBatchOfferedTimeChange(List<String> value) {
    setState(() {
      _batchTime = value;
    });
  }

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onAddSuggestion(String value) {
    final TextEditingController suggestionNameController =
        TextEditingController();
    suggestionNameController.text = value;
    File? selectedImage;
    String? nameError;
    String? imageError;
    bool isLoading = false;
    String? message;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const SVGLoader(
                            image: icons.Icons.closeRed,
                            width: 16,
                            height: 16,
                          ),
                          onTap: () => closeModal(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add Suggestion',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      FormInput(
                        controller: suggestionNameController,
                        // initialValue: value,
                        text: 'Name',
                      ),
                      // Display error text for the name if it's empty
                      if (nameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            nameError!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 20),
                      selectedImage == null
                          ? CustomDashedInput(
                              text: "Image",
                              onTap: () async {
                                final pickedFile = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null) {
                                  setModalState(() {
                                    selectedImage = File(pickedFile.path);
                                    imageError = null;
                                  });
                                }
                              },
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      FileImage(File(selectedImage!.path)),
                                  backgroundColor: ThemeColors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Image uploaded',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMediumTitleBrown,
                                ),
                              ],
                            ),
                      if (imageError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            imageError!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (message != null)
                        Text(
                          message!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMediumTitleBrownSemiBold,
                        ),
                      const SizedBox(height: 20),
                      message == null
                          ? SizedBox(
                              width: double.infinity,
                              child: CustomElevatedButton(
                                isLoading: isLoading,
                                text: Strings.save,
                                onPressed: () async {
                                  setModalState(() {
                                    nameError =
                                        suggestionNameController.text.isEmpty
                                            ? 'Please enter a name'
                                            : null;
                                    imageError = selectedImage == null
                                        ? 'Please select an image'
                                        : null;
                                  });

                                  if (nameError == null && imageError == null) {
                                    setModalState(() {
                                      isLoading = true;
                                    });
                                    final response =
                                        await widget.onAddSuggestion(
                                      suggestionNameController.text,
                                      selectedImage!,
                                    );
                                    if (response) {
                                      setModalState(() {
                                        isLoading = false;
                                        message =
                                            Strings.suggestionAddedSuccessfully;
                                      });
                                    } else {
                                      setModalState(() {
                                        message =
                                            Strings.suggestionAddingFailed;
                                      });
                                    }
                                  }
                                },
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: CustomElevatedButton(
                                text: 'OK',
                                onPressed: () {
                                  closeModal(context);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void toggleShowInputType(bool value) {
    setState(() {
      showInputType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final finalTitleList = [..._manualSearch, ..._suggestionSearch];

    return SingleChildScrollView(
      child: SizedBox(
        width: screenSize.width * 0.95,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AddTitleCard(
                image: finalTitleList.isNotEmpty ? finalTitleList.first : null,
                text: title,
                titleError: _titleError,
                showInputType: showInputType,
                selectedFieldType: _selectedFieldType,
                isFieldEnabled: isFieldEnabled,
                manualSearch: _manualSearch,
                suggestionSearch: _suggestionSearch,
                toggleShowInputType: toggleShowInputType,
                onAutoChange: (int value) => _handleSelectedFieldType(value),
                onTitleChange: (String value) => _handleTitleChange(value),
                onTap: _onProfileUpload,
                onAddSuggestion: onAddSuggestion,
                onSelectSuggestion: onSelectSuggestion,
                onDeselectSuggestion: onDeselectSuggestion,
                resetFieldEnabled: resetFieldEnabled,
                superCategories: widget.superCategories,
                categories: widget.categories,
                suggestionHierarchy: widget.suggestionHierarchy,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.shortDescription,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                text: _shortDescription,
                onSaved: (value) => {_shortDescription = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidShortDescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    Strings.aboutDescription,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                text: _aboutDescription,
                onSaved: (value) => {_aboutDescription = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidAboutDescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (widget.subCategory == 'courses')
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isBatchOfferedSelected,
                          onChanged: _handleBatchOfferedChange,
                          activeColor: ThemeColors.titleBrown,
                        ),
                        Text(
                          Strings.addBatchOffered,
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                      ],
                    ),
                    if (_isBatchOfferedError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _isBatchOfferedError!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ThemeColors.primary),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (_isBatchOfferedSelected)
                      Column(
                        children: [
                          BatchOfferedCard(
                            selectedDays: _selectedDays,
                            selectedTime: _batchTime,
                            onSelectedDaysChanged:
                                _handleBatchOfferedDaysChange,
                            onSelectedTimeChanged:
                                _handleBatchOfferedTimeChange,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Total Hours (Number)",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FormInput(
                      keyboardType: TextInputType.number,
                      text: _totalHours,
                      onSaved: (value) => {_totalHours = value!},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Row(
                children: [
                  Text(
                    Strings.amountDetails,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FormInput(
                keyboardType: TextInputType.number,
                text: _amountDetails,
                onSaved: (value) => {_amountDetails = value!},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return Strings.invalidAmountDetails;
                  }
                  return null;
                },
                onChanged: (value) {
                  _amountDetails = value;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.addItem,
                  onPressed: _onAddItem,
                  color: ThemeColors.primary,
                  buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                  svgIcon: icons.Icons.bookIcon,
                  isLoading: widget.isLoading,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
