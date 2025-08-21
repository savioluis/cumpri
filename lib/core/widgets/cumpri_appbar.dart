import 'package:cumpri/core/extensions/color_extension.dart';
import 'package:cumpri/core/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class CumpriAppBar extends StatelessWidget implements PreferredSize {
  const CumpriAppBar({
    this.height = 96,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.onActionPressed,
    this.actionIcon,
    super.key,
  });

  final double height;
  final String title;
  final String? subtitle;
  final Function()? onBackPressed;
  final Function()? onActionPressed;
  final Icon? actionIcon;

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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.headlineLarge?.copyWith(
                    fontSize: 32,
                    color: context.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (onActionPressed != null && actionIcon != null)
                  IconButton(
                    onPressed: onActionPressed,
                    icon: actionIcon!,
                  ),
              ],
            ),
          ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle!,
                style: context.bodyLarge?.copyWith(
                  color: context.lightGreyColor,
                  fontSize: 18,
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
