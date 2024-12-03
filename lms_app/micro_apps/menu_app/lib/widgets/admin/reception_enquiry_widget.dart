import 'package:flutter/material.dart';

import 'package:menu_app/widgets/common/enquiry_card.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/themes/colors.dart';

class ReceptionEnquiryWidget extends StatelessWidget {
  const ReceptionEnquiryWidget({
    super.key,
    required this.isLoading,
    required this.enquiries,
  });

  final bool isLoading;
  final List<EnquiryModel> enquiries;

  void navigateToEnquiryDetailScreen(
      BuildContext context, EnquiryModel enquiry) {
    Navigator.of(context)
        .pushNamed(AdminRoutes.receptionEnquiryDetail, arguments: enquiry);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (enquiries.isEmpty) {
      return Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 200,
                height: 40,
                margin: const EdgeInsets.only(top: 10, right: 10),
                child: IconTextButton(
                  text: Strings.resolvedHistory,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AdminRoutes.resolvedEnquiry);
                  },
                  color: ThemeColors.primary,
                  iconHorizontalPadding: 5,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  Strings.noEnquiriesFound,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ThemeColors.primary,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: screenSize.width * 0.90,
      margin: const EdgeInsets.only(top: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 200,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: IconTextButton(
                text: Strings.resolvedHistory,
                onPressed: () {
                  Navigator.of(context).pushNamed(AdminRoutes.resolvedEnquiry);
                },
                color: ThemeColors.primary,
                iconHorizontalPadding: 5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: enquiries.length,
              itemBuilder: (context, index) {
                final enquiry = enquiries[index];
                return EnquiryCard(
                  enquiry: enquiry,
                  onTap: () => navigateToEnquiryDetailScreen(context, enquiry),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
