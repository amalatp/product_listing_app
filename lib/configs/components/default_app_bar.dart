import 'package:flutter/material.dart';
import 'package:product_listing_app/configs/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.isLeading = true,
    this.onTap,
    this.action,
    this.centerTitle = true,
    this.backgroundColor = AppColors.secondary,
    this.horizontalPadding = 16,
  });

  final String? title;
  final bool isLeading;
  final VoidCallback? onTap;
  final Widget? action;
  final bool centerTitle;
  final Color backgroundColor;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiary.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: height * 0.06,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            if (isLeading)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: AppColors.primary,
                onPressed: onTap ?? () => Navigator.of(context).pop(),
              )
            else
              SizedBox(width: height * 0.05),
            Expanded(
              child: Text(
                title ?? "",
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (action != null) action! else SizedBox(width: height * 0.05),
          ],
        ),
      ),
    );
  }
}
