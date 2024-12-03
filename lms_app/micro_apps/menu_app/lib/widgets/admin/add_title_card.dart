import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/models/courses/search_model.dart';
import 'package:menu_app/models/courses/suggestion_category_model.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/special_form_input.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class AddTitleCard extends StatefulWidget {
  final Function() onTap;
  final String text;
  final SearchModel? image;
  final String? titleError;
  final bool showInputType;
  final int selectedFieldType;
  final bool isFieldEnabled;
  final List<SearchModel> manualSearch;
  final List<SearchModel> suggestionSearch;
  final Function(String) onTitleChange;
  final Function(String) onAddSuggestion;
  final Function(int) onAutoChange;
  final Function(int) resetFieldEnabled;
  final Function(bool) toggleShowInputType;
  final Function(QueryDocumentSnapshot, bool?) onSelectSuggestion;
  final Function(QueryDocumentSnapshot, bool?) onDeselectSuggestion;
  final List<String> superCategories;
  final List<String> categories;
  final List<SuggestionCategoriesModel> suggestionHierarchy;

  const AddTitleCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.text,
    required this.showInputType,
    required this.selectedFieldType,
    required this.manualSearch,
    required this.suggestionSearch,
    required this.isFieldEnabled,
    required this.onTitleChange,
    required this.titleError,
    required this.onAddSuggestion,
    required this.onAutoChange,
    required this.toggleShowInputType,
    required this.onSelectSuggestion,
    required this.resetFieldEnabled,
    required this.onDeselectSuggestion,
    required this.superCategories,
    required this.categories,
    required this.suggestionHierarchy,
  });

  @override
  State<AddTitleCard> createState() => _AddTitleCardState();
}

class _AddTitleCardState extends State<AddTitleCard> {
  List<String> selectedSuggestions = [];
  late FocusNode _allAvailableFocusNode;
  List<String> matchingCategories = [];
  String? selectedSuperCategory;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _allAvailableFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextEditingController _typeAheadController = TextEditingController();
    FocusNode _titleFocusNode = FocusNode();

    void onFocusChange(bool hasFocus) {
      if (hasFocus && widget.text.isEmpty) {
        widget.toggleShowInputType(true);
      }
    }

    return GestureDetector(
      onTap: () {
        widget.toggleShowInputType(false);
        widget.resetFieldEnabled(-1);
        FocusScope.of(context).unfocus();
        // FocusScope.of(context).requestFocus(_titleFocusNode);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: ThemeColors.cardColor,
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 5,
              spreadRadius: 0,
              color: ThemeColors.black.withOpacity(0.1),
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: widget.image == null
                      ? const SVGLoader(image: icons.Icons.profileBackup)
                      : ClipOval(
                          child: widget.image!.url != null
                              ? Image.network(
                                  widget.image!.url!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : widget.image!.file != null
                                  ? Image.file(
                                      widget.image!.file!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : const SVGLoader(
                                      image: icons.Icons.profileBackup,
                                    ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.addTitle,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: screenSize.width * 0.60,
                    child: SpecialFormInput(
                      text: widget.text,
                      hintText: widget.text,
                      focusNode: _titleFocusNode,
                      onChanged: (value) => widget.onTitleChange(value),
                      fillColor: ThemeColors.white,
                      borderColor: ThemeColors.cardBorderColor,
                      borderWidth: 0.4,
                      hasShadow: true,
                      onFocusChange: onFocusChange,
                      readOnly: !widget.isFieldEnabled,
                      suffixIcon: widget.showInputType
                          ? GestureDetector(
                              onTap: () {},
                              child: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  widget.toggleShowInputType(false);
                                  widget.resetFieldEnabled(-1);
                                },
                              ),
                            )
                          : null,
                    ),
                  ),
                  if (widget.titleError != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 5,
                      ),
                      child: Text(
                        widget.titleError!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: ThemeColors.primary),
                      ),
                    ),
                  const SizedBox(height: 18.0),
                  Visibility(
                    visible: widget.showInputType,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Super Category',
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        const SizedBox(height: 18.0),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ThemeColors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: DropdownButton<String>(
                              value: selectedSuperCategory,
                              elevation: 16,
                              alignment: Alignment.center,
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedSuperCategory = value;
                                  matchingCategories = widget
                                      .suggestionHierarchy
                                      .firstWhere((suggestion) =>
                                          suggestion.superCategory.name ==
                                          selectedSuperCategory)
                                      .superCategory
                                      .secondLevelCategories;
                                });
                              },
                              items: widget.superCategories
                                  .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMediumPrimary
                                          .copyWith(
                                            fontFamily: ThemeFonts.poppins,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.showInputType,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        const SizedBox(height: 18.0),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ThemeColors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: DropdownButton<String>(
                              value: selectedCategory,
                              elevation: 16,
                              alignment: Alignment.center,
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                              isExpanded: true,
                              menuMaxHeight: 300,
                              items: matchingCategories
                                  .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMediumPrimary
                                            .copyWith(
                                              fontFamily: ThemeFonts.poppins,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: widget.showInputType,
                    child: Text(
                      Strings.inputType,
                      style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                    ),
                  ),
                  Visibility(
                    visible: widget.showInputType,
                    child: Transform.translate(
                      offset: const Offset(-10, 0),
                      child: Column(
                        children: [
                          RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: widget.selectedFieldType == 0,
                            groupValue: true,
                            onChanged: (value) => widget.onAutoChange(0),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            title: Text(
                              'By Prompt',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumTitleBrown,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0, -20),
                            child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: widget.selectedFieldType == 1,
                              groupValue: true,
                              onChanged: (value) {
                                widget.onAutoChange(1);
                                if (_allAvailableFocusNode != null) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    FocusScope.of(context)
                                        .requestFocus(_allAvailableFocusNode);
                                  });
                                }
                              },
                              title: Text(
                                'All Available',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.selectedFieldType >= 0,
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: Text(
                        '${widget.selectedFieldType == 0 ? 'By Prompt' : 'All Available'} Field',
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.selectedFieldType == 0,
                    child: TypeAheadField<QueryDocumentSnapshot>(
                      controller: _typeAheadController,
                      builder: (context, controller, focusNode) {
                        return FormInput(
                          text: '',
                          focusNode: focusNode,
                          controller: controller,
                          hintText: '',
                          borderColor: ThemeColors.cardBorderColor,
                          fillColor: ThemeColors.white,
                          borderWidth: 0.4,
                          hasShadow: true,
                        );
                      },
                      loadingBuilder: (context) =>
                          const CircularProgressIndicator(),
                      suggestionsCallback: (search) async {
                        if (search.isEmpty) {
                          return null;
                        }

                        try {
                          final lowercaseSearch = search.toLowerCase();
                          final uppercaseSearch = search.toUpperCase();
                          final capitalizedSearch = search.capitalize();
                          final QuerySnapshot querySnapshot =
                              await FirebaseFirestore.instance
                                  .collection('suggestions')
                                  .where('tag',
                                      arrayContains: selectedCategory?.trim())
                                  .where(
                                    Filter.or(
                                      Filter.and(
                                        Filter('name',
                                            isGreaterThanOrEqualTo:
                                                lowercaseSearch),
                                        Filter('name',
                                            isLessThanOrEqualTo:
                                                '$lowercaseSearch\uf8ff'),
                                      ),
                                      Filter.and(
                                        Filter('name',
                                            isGreaterThanOrEqualTo:
                                                uppercaseSearch),
                                        Filter('name',
                                            isLessThanOrEqualTo:
                                                '$uppercaseSearch\uf8ff'),
                                      ),
                                      Filter.and(
                                        Filter('name',
                                            isGreaterThanOrEqualTo:
                                                capitalizedSearch),
                                        Filter('name',
                                            isLessThanOrEqualTo:
                                                '$capitalizedSearch\uf8ff'),
                                      ),
                                    ),
                                  )
                                  .get();
                          final listValues =
                              querySnapshot.docs.map((ele) => ele).where((ele) {
                            return !widget.suggestionSearch.any((searchModel) =>
                                searchModel.name == ele['name']);
                          }).toList();
                          return Future.value(listValues);
                        } catch (e) {
                          print(e);
                          return [];
                        }
                      },
                      debounceDuration: const Duration(milliseconds: 500),
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: suggestion['image'] != null
                                ? NetworkImage(suggestion['image'])
                                    as ImageProvider
                                : null,
                          ),
                          title: Text(
                            suggestion['name'] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      },
                      emptyBuilder: (context) => Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Text(
                          'No Suggestion Found',
                          style: TextStyle(
                            fontSize: 14,
                            color: ThemeColors.primary,
                          ),
                        ),
                      ),
                      onSelected: (suggestion) {
                        widget.onSelectSuggestion(suggestion, false);
                        _typeAheadController.clear();
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.selectedFieldType == 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: TypeAheadField<QueryDocumentSnapshot>(
                            controller: _typeAheadController,
                            hideOnUnfocus: true,
                            hideWithKeyboard: false,
                            hideOnSelect: false,
                            debounceDuration: const Duration(milliseconds: 500),
                            builder: (context, controller, focusNode) {
                              _allAvailableFocusNode = focusNode;
                              return FormInput(
                                text: '',
                                focusNode: focusNode,
                                controller: controller,
                                hintText: '',
                                borderColor: ThemeColors.cardBorderColor,
                                fillColor: ThemeColors.white,
                                borderWidth: 0.4,
                                hasShadow: true,
                              );
                            },
                            loadingBuilder: (context) =>
                                const CircularProgressIndicator(),
                            suggestionsCallback: (search) async {
                              try {
                                final QuerySnapshot querySnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('suggestions')
                                        .where('tag',
                                            arrayContains:
                                                selectedCategory?.trim())
                                        .get();
                                final listValues = querySnapshot.docs
                                    .map((ele) => ele)
                                    .where((ele) {
                                  // return !widget.manualSearch
                                  //     .contains(ele['name']);
                                  return !widget.manualSearch.any(
                                      (searchModel) =>
                                          searchModel.name == ele['name']);
                                }).toList();
                                return Future.value(listValues);
                              } catch (e) {
                                print('e');
                                return [];
                              }
                            },
                            itemBuilder: (context, suggestion) {
                              return IgnorePointer(
                                child: CheckboxListTile(
                                  key: ValueKey(suggestion['id']),
                                  title: Text(
                                    suggestion['name'] as String,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  value: selectedSuggestions
                                      .contains(suggestion['id']),
                                  onChanged: (value) {},
                                ),
                              );
                            },
                            onSelected: (suggestion) {
                              setState(() {
                                if (selectedSuggestions
                                    .contains(suggestion['id'])) {
                                  selectedSuggestions = selectedSuggestions
                                      .where((id) => id != suggestion['id'])
                                      .toList();
                                  widget.onDeselectSuggestion(suggestion, true);
                                } else {
                                  selectedSuggestions = [
                                    ...selectedSuggestions,
                                    suggestion['id']
                                  ];
                                  widget.onSelectSuggestion(suggestion, true);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
