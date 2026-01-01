import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/transaction_item.dart';
import '../../models/transaction.dart';
import '../../models/category.dart';

class InspectCategory extends StatelessWidget {
  final Category category;
  final TransactionType type;
  final List<Transaction> transactions;

  const InspectCategory({
    super.key,
    required this.category,
    required this.transactions,
    required this.type,
  });

  List<Transaction> get transactionsByCategory {
    final list = transactions.where((tx) => tx.category == category).toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  double get totalAmount =>
      transactionsByCategory.fold(0, (sum, tx) => sum + tx.amount);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: Text(
          "Category Overview",
          style: textTheme.displaySmall?.copyWith(color: colors.onPrimary),
        ),
        centerTitle: true,
        backgroundColor: colors.secondary,
      ),
      backgroundColor: colors.secondary,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: colors.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: category.backgroundColor,
                  child: Image.asset(category.icon, width: 30, height: 30),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.label, style: textTheme.displaySmall),
                    Text(
                      "${type == TransactionType.income ? "+" : "-"}\$ ${NumberFormat("#,##0.00").format(totalAmount)}",
                      style: textTheme.titleLarge?.copyWith(
                        color: type == TransactionType.income
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: transactionsByCategory.isEmpty
                  ? Center(
                      child: Text(
                        "No transactions found",
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: transactionsByCategory.length,
                      itemBuilder: (context, index) {
                        final tx = transactionsByCategory[index];
                        final bool showDateHeader =
                            index == 0 ||
                            !isSameDay(
                              tx.date,
                              transactionsByCategory[index - 1].date,
                            );
                        return Column(
                          children: [
                            if (showDateHeader)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 16,
                                  bottom: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(height: 20),
                                    Text(
                                      DateFormat(
                                        'EEE, MMMM d yyyy',
                                      ).format(tx.date),
                                      style: textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            TransactionItem(
                              title: tx.title,
                              amount: tx.amount,
                              type: tx.type,
                              imageAsset: tx.category.icon,
                              background: tx.category.backgroundColor,
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
