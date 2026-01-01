import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/transaction.dart';
import '../../models/user.dart';
import '../widgets/header.dart';
import '../widgets/dashboard_amount.dart';
import '../widgets/transaction_filter_button.dart';
import '../widgets/transaction_item.dart';
import '../../l10n/app_localization.dart';
import 'transaction_form.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TransactionType? filter;

  void onCreate() async {
    Transaction? newTransaction = await Navigator.push<Transaction>(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionFormScreen(),
      ),
    );
    setState(() {
      if(newTransaction != null){
        widget.user.addTransaction(newTransaction);
      }
    });
  }

  void onEdit(Transaction t) async {
    Transaction? newTransaction = await Navigator.push<Transaction>(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionFormScreen(editTransaction: t),
      ),
    );
    setState(() {
      if(newTransaction != null){
        widget.user.updateTransaction(newTransaction, t.id);
      }
    });
  }

  List<Transaction> get transactions => widget.user.getTransactionsToday(type: filter);
  double get rawBalance => widget.user.getTotalBalance(transactionList: transactions);
  double get balance => rawBalance.abs();
  String get sign => rawBalance >= 0 ? '+' : '-';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final language = AppLocalizations.of(context)!;
    final formattedDate = DateFormat("dd MMMM y", Localizations.localeOf(context).toString()).format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.secondary,
        title: Text("Smart Finance", style: textTheme.displayMedium?.copyWith(color: colorTheme.onPrimary),),
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -1800,
              right: -1000,
              left: -1000,
              child: Container(
                height: 2000,
                width: 2000,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorTheme.secondary
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(greeting: widget.user.getLocalizedGreeting(language), userName: widget.user.name, onPress: onCreate, profileLabel: widget.user.getProfileLabel(),),
                  const SizedBox(height: 10),
                  DashboardAmount(
                    total: widget.user.getTotalBalance(), 
                    income: widget.user.getTotalAmountByType(type: TransactionType.income), 
                    expense: widget.user.getTotalAmountByType(type: TransactionType.expense), 
                    isTotalExist: true,
                  ),
                  const SizedBox(height: 30),
                  TransactionFilterButton(
                    isExistAll: true, 
                    onPress: (type){
                      setState(() {
                        filter = type;
                      });
                    }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${language.today} $formattedDate", style: textTheme.titleLarge),
                      Text("$sign \$$balance" , style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: filter == null? Colors.blue : filter!.color))
                    ],
                  ),
                  const SizedBox(height: 10),
                  transactions.isNotEmpty ? ListView.builder(
                    shrinkWrap: true, 
                    physics: NeverScrollableScrollPhysics(), 
                    itemCount: transactions.length,
                    itemBuilder: (context, index){
                      Transaction t = transactions[index];
                      return Slidable(
                        key: ValueKey(t.id),
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.2,
                          children: [
                            SlidableAction(
                              onPressed: (context) => onEdit(t),
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.blue,
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.2,
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                setState(() {
                                  widget.user.removeTransaction(t.id); 
                                });
                                ScaffoldMessenger.of(context)
                                  ..clearSnackBars()
                                  ..showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 3),
                                    content: Text(language.transactionDeleted),
                                    behavior: SnackBarBehavior.floating,
                                    action: SnackBarAction(
                                      label: language.undo,
                                      onPressed: () {
                                        setState(() {
                                          widget.user.addTransaction(t);
                                        });
                                      },
                                    ),
                                  )
                                );
                              },
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.red,
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: TransactionItem(
                          background: t.category.backgroundColor, 
                          imageAsset: t.category.icon, 
                          title: t.title, 
                          type: t.type, 
                          amount: t.amount),
                      );
                    }
                  ) : 
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text("There is no transaction, Today!", style: textTheme.titleMedium?.copyWith(color: colorTheme.onSurface),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
    ));
  }
}