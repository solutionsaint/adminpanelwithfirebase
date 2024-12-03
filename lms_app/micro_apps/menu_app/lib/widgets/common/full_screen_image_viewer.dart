import 'package:flutter/material.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class FullScreenImageViewer extends StatelessWidget {
  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return MenuLayout(
      topBarText: "Image",
      showBottomBar: false,
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
