import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/extension/mediaquery_extension.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });
  final VoidCallback onTap;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    double height = context.mediaQueryHeight;
    double width = context.mediaQueryWidth;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: height * 0.017,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
