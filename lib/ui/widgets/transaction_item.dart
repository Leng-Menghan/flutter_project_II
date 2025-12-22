import 'package:flutter/material.dart';
import '../../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final String imageAsset;
  final String title;
  final TransactionType type;
  final Color background;
  final double amount;
  const TransactionItem({
    super.key,
    required this.background,
    required this.imageAsset,
    required this.title,
    required this.type,
    required this.amount
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
          radius: 22.5,
          backgroundColor: background,
          child: Image.asset(imageAsset, width: 25, height: 25,),
        ),
        title: Text(title, style: textTheme.titleLarge),
        trailing: Text("${(type.name == "income")? "+":"-"} \$$amount"  , style: textTheme.titleLarge?.copyWith(color: type.color)),
      ),
    );
  }
}