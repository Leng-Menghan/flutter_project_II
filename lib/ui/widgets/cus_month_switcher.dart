import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomMonthSwitcher extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final DateTime date;
  const CustomMonthSwitcher({super.key, required this.onNext, required this.onBack, required this.date});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onBack,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: colorTheme.primary,
            size: 20,
          ),
        ),
        SizedBox(width: 150, child: Text(DateFormat.yMMMM().format(date), textAlign: TextAlign.center, style: textTheme.titleLarge?.copyWith(color: colorTheme.onSurface))),
        GestureDetector(
          onTap: onNext,               
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorTheme.primary,
            size: 20,
          ),
        ),
      ],
    );
  }
}