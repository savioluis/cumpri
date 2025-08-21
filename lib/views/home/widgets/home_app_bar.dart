import 'package:cumpri/core/theme/extensions/color_extension.dart';
import 'package:cumpri/core/theme/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSize {
  const HomeAppBar({
    this.height = 96,
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.surfaceColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Bem-vindo',
              style: context.displayMedium?.copyWith(
                fontSize: 36,
                color: context.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '12 tarefas encontradas',
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
