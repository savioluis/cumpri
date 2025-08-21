import 'package:cumpri/core/theme/extensions/color_extension.dart';
import 'package:cumpri/core/theme/extensions/text_extension.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.title,
    this.description,
    required this.isDone,
    required this.onCheckPressed,
    required this.onTaskPressed,
  });

  final String title;
  final String? description;
  final VoidCallback onCheckPressed;
  final VoidCallback onTaskPressed;

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(color: context.lightGreyColor, width: 0.4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: context.bodyLarge!.copyWith(
            decoration: isDone ? TextDecoration.lineThrough : null,
            decorationThickness: 1.5,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: description != null && description!.isNotEmpty
            ? Text(
                description!,
                style: context.bodySmall?.copyWith(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                  decorationThickness: 1.5,
                  color: context.greyColor,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: GestureDetector(
          onTap: onCheckPressed,
          child: Checkbox(
            value: isDone,
            onChanged: (_) => onCheckPressed(),
          ),
        ),
        onTap: onTaskPressed,
      ),
    );
  }
}
