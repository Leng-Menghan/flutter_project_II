import 'package:uuid/uuid.dart';
import './category.dart';

var uuid = Uuid();

class BudgetGoal {
  final String id;
  final Category category;
  final double goalAmount;
  final int year;
  final int month;

  BudgetGoal({
    String? id,
    required this.category,
    required this.goalAmount,
    required this.year,
    required this.month,
  }) : id = id ?? uuid.v4();
}
