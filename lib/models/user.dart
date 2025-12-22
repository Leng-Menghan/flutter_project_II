import './category.dart';
import './budget_goal.dart';
import './transaction.dart';

class User {
  String name;
  final String profileImage;
  String preferredLanguage;
  String preferredAmountType;
  List<Transaction> transactions = [];
  final List<BudgetGoal> budgetGoals = [];

  User({
    required this.name,
    required this.profileImage,
    required this.preferredLanguage,
    required this.preferredAmountType,
    required this.transactions,
  });

  String getProfileLabel() {
    final words = name.trim().split(' ');
    final initials = words.map((word) => word[0].toUpperCase()).join();
    return initials;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
  }

  void removeTransaction(String id) {
    transactions.removeWhere((t) => t.id == id);
  }

  void updateTransaction(Transaction updated, String id) {
    int index = transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      transactions[index] = updated;
    }
  }

  List<Transaction> getTransactions({
    int? year,
    int? month,
    int? day,
    TransactionType? type,
    Category? category,
  }) {
    return transactions.where((t) {
      if (year != null && t.date.year != year) return false;
      if (month != null && t.date.month != month) return false;
      if (day != null && t.date.day != day) return false;
      if (type != null && t.type != type) return false;
      if (category != null && t.category != category) return false;
      return true;
    }).toList();
  }

  double getTotalAmountByType({
    List<Transaction>? transactionList,
    required TransactionType type,
  }) {
    double total = 0;
    final listToSum = transactionList ?? transactions;
    for (var t in listToSum) {
      if (t.type == type) {
        total += t.amount;
      }
    }
    return total;
  }

  List<Transaction> getTransactionsToday({TransactionType? type}) {
    return transactions.where((t) {
      if (t.date.day != DateTime.now().day) return false;
      if (t.date.month != DateTime.now().month) return false;
      if (t.date.year != DateTime.now().year) return false;
      if (type != null && t.type != type) return false;
      return true;
    }).toList();
  }

  double getTotalBalance({List<Transaction>? transactionList}) {
    double total = 0;
    final listToSum = transactionList ?? transactions;
    for (Transaction t in listToSum) {
      if (t.isIncome) {
        total += t.amount;
      } else {
        total -= t.amount;
      }
    }
    return total;
  }

  void addBudgetGoal(BudgetGoal budgetGoal) {
    budgetGoals.add(budgetGoal);
  }

  void removeBudgetGoal(String id) {
    budgetGoals.removeWhere((b) => b.id == id);
  }

  void updateBudgetGoal(BudgetGoal updated, String id) {
    int index = budgetGoals.indexWhere((b) => b.id == id);
    if (index != -1) {
      budgetGoals[index] = updated;
    }
  }

  List<BudgetGoal> getBudgetGoal({int? year, int? month, Category? category}) {
    return budgetGoals.where((b) {
      if (year != null && b.year != year) return false;
      if (month != null && b.month != month) return false;
      if (category != null && b.category != category) return false;
      return true;
    }).toList();
  }

  double getTotalGoalAmount(List<BudgetGoal> budgetGoalList) {
    double total = 0;
    for (BudgetGoal b in budgetGoalList) {
      total += b.goalAmount;
    }
    return total;
  }
}
