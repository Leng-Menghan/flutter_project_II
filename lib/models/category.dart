import 'package:flutter/material.dart';

enum Category {
  // Expense
  bill(
    icon: 'assets/expenseIcons/bill.png',
    backgroundColor: Colors.redAccent,
    label: "Bills",
  ),
  clothing(
    icon: "assets/expenseIcons/cloth.png",
    backgroundColor: Colors.indigo,
    label: "Clothing",
  ),
  education(
    icon: "assets/expenseIcons/education.png",
    backgroundColor: Colors.blueGrey,
    label: "Education",
  ),
  entertainment(
    icon: "assets/expenseIcons/entertainment.png",
    backgroundColor: Colors.deepPurple,
    label: "Entertainment",
  ),
  fitness(
    icon: "assets/expenseIcons/fitness.png",
    backgroundColor: Colors.teal,
    label: "Fitness",
  ),
  food(
    icon: "assets/expenseIcons/food.png",
    backgroundColor: Colors.orangeAccent,
    label: "Food",
  ),
  gift(
    icon: "assets/expenseIcons/gift.png",
    backgroundColor: Colors.pinkAccent,
    label: "Gifts",
  ),
  health(
    icon: "assets/expenseIcons/health.png",
    backgroundColor: Colors.red,
    label: "Health",
  ),
  furniture(
    icon: "assets/expenseIcons/furniture.png",
    backgroundColor: Colors.brown,
    label: "Furniture",
  ),
  pet(
    icon: "assets/expenseIcons/pets.png",
    backgroundColor: Colors.deepOrange,
    label: "Pets",
  ),
  shopping(
    icon: "assets/expenseIcons/shopping.png",
    backgroundColor: Colors.purple,
    label: "Shopping",
  ),
  transportation(
    icon: "assets/expenseIcons/transportation.png",
    backgroundColor: Colors.blueAccent,
    label: "Transportation",
  ),
  travel(
    icon: "assets/expenseIcons/bill.png",
    backgroundColor: Colors.amber,
    label: "Travel",
  ),
  // Income
  allowance(
    icon: "assets/incomeIcons/allowance.png",
    backgroundColor: Colors.deepPurple,
    label: "Allowance",
  ), // Dark Green
  award(
    icon: "assets/incomeIcons/award.png",
    backgroundColor: Colors.red,
    label: "Award",
  ), // Medium Green
  bonus(
    icon: "assets/incomeIcons/bonus.png",
    backgroundColor: Colors.orangeAccent,
    label: "Bonus",
  ), // Deep Green
  dividend(
    icon: "assets/incomeIcons/dividends.png",
    backgroundColor: Colors.blueGrey,
    label: "Dividend",
  ), // Teal
  investment(
    icon: "assets/incomeIcons/investment.png",
    backgroundColor: Colors.indigo,
    label: "Investment",
  ), // Cyan
  lottery(
    icon: "assets/incomeIcons/lottery.png",
    backgroundColor: Colors.teal,
    label: "Lottery",
  ), // Olive Green
  salary(
    icon: "assets/incomeIcons/salary.png",
    backgroundColor: Colors.amber,
    label: "Salary",
  ), // Forest Green
  tip(
    icon: "assets/incomeIcons/tip.png",
    backgroundColor: Colors.blueAccent,
    label: "Tips",
  ), // Medium Green
  other(
    icon: "assets/expenseIcons/other.png",
    backgroundColor: Color(0xFF616161),
    label: "Others",
  );

  final String icon;
  final Color backgroundColor;
  final String label;
  const Category({
    required this.icon,
    required this.backgroundColor,
    required this.label,
  });

  static List<Category> get incomeCategories => [
    allowance,
    award,
    bonus,
    dividend,
    investment,
    lottery,
    salary,
    tip,
    other,
  ];

  static List<Category> get expenseCategories => [
    bill,
    clothing,
    education,
    entertainment,
    fitness,
    food,
    gift,
    health,
    furniture,
    pet,
    shopping,
    transportation,
    travel,
  ];
}
