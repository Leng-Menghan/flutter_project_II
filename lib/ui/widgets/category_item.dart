import 'package:flutter/material.dart';
import '../../l10n/app_localization.dart';
import '../../models/category.dart';
import '../../models/transaction.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final TransactionType type;
  final List<Transaction> transactions;
  final double totalAmount;
  const CategoryItem({
    super.key,
    required this.category,
    required this.transactions,
    required this.type,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final language = AppLocalizations.of(context)!;
    double amountCategory = 0;
    for(Transaction t in transactions){
      amountCategory+= t.amount;
    }
    int percentage = (amountCategory*100/totalAmount).round();
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22.5,
        backgroundColor: category.backgroundColor,
        child: Image.asset(
          category.icon,
          width: 25,
          height: 25,
        ),
      ),
      title: Text(category.label, style: textTheme.titleLarge?.copyWith(color: colorTheme.onSurface)),
      subtitle: Text(
        "${percentage.toString()} %",
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${(type == TransactionType.income) ? "+" : "-"} \$$amountCategory",
            style: textTheme.titleLarge?.copyWith(
              color:(type == TransactionType.income) ? Colors.green : Colors.red,
            ),
          ),
          Text(
            "${transactions.length} ${language.transaction}",
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}