import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import './category.dart';

enum TransactionType {
  expense(color: Colors.red),
  income(color: Colors.green);

  final Color color;
  const TransactionType({required this.color});
}

var uuid = Uuid();

class Transaction {
  final String id;
  final String title;
  final double amount;
  final Category category;
  final TransactionType type;
  final DateTime date;

  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
  }) : id = id ?? uuid.v4();

  bool get isIncome => type == TransactionType.income ? true : false;
  bool get isExpense => type == TransactionType.expense ? true : false;
}
