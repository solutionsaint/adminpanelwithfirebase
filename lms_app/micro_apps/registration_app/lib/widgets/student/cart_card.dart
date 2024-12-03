import 'package:flutter/material.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.amount,
    this.discount = 0,
    this.description,
    this.batchDay,
    this.batchTime,
    this.onRemoveFromCart,
  });

  final String imageUrl;
  final String title;
  final String? amount;
  final String? batchDay;
  final String? batchTime;
  final int discount;
  final String? description;
  final void Function()? onRemoveFromCart;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: ThemeColors.cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (onRemoveFromCart != null)
                      IconButton(
                        onPressed: onRemoveFromCart,
                        icon: Icon(
                          Icons.delete,
                          color: ThemeColors.primary,
                          size: 20,
                        ),
                      ),
                  ],
                ),
                if (description != null)
                  Text(
                    description!,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 13),
                    maxLines: 3,
                  ),
                if (batchDay != null)
                  Row(
                    children: [
                      Text(
                        'Batch: ',
                        style: Theme.of(context).textTheme.titleSmallTitleBrown,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        batchDay!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                if (batchTime != null)
                  Row(
                    children: [
                      Text(
                        'Time: ',
                        style: Theme.of(context).textTheme.titleSmallTitleBrown,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        batchTime!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                const SizedBox(height: 8.0),
                if (amount != null)
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 8,
                    children: [
                      Text(
                        Strings.amount,
                        style: Theme.of(context).textTheme.titleSmallTitleBrown,
                      ),
                      const SizedBox(width: 8.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.rs,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmallTitleBrown,
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 5),
                            ),
                            TextSpan(
                              text: amount,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: ThemeColors.authPrimary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                        alignment: Alignment.center,
                        width: screenSize.width * 0.17,
                        child: Text(
                          '$discount% off',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ThemeColors.white,
                                  ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
