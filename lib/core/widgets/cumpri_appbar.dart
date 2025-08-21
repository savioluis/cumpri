import 'package:cumpri/core/extensions/color_extension.dart';
import 'package:cumpri/core/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class CumpriAppBar extends StatelessWidget implements PreferredSize {
  const CumpriAppBar({
    this.height = 96,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    super.key,
  });

  final double height;
  final String title;
  final String? subtitle;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ?onBackPressed != null
              ? IconButton(
                  onPressed: onBackPressed,
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                )
              : null,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              title,
              style: context.displayMedium?.copyWith(
                fontSize: 36,
                color: context.primaryColor,
              ),
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                subtitle!,
                style: context.bodyLarge?.copyWith(
                  color: context.lightGreyColor,
                ),
              ),
            ),
          SizedBox(height: 12),
          Divider(
            thickness: 0.2,
            color: context.lightGreyColor,
            height: 2,
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => Size.fromHeight(height);
}
