//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work
} //dart feature which reconise category and can use like string

const uuid =
    Uuid(); //make this function for can use at other places and other file code

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); //generate unique id, then the unique id name is id.

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

//to make chart for expenses

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  //add addictional consructor function
  //List<Expense> allExpenses < to get list of all allExpenses in each caterogy
  //and pass to this class for programmer to use
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    //tell dart to go through all this list this expenses
    //with all the list go through then store data at expense
    for (final expense in expenses) {
      // sum = sum + expense.amount;
      //or write like this
      sum += expense.amount;
    }

    return sum;
  }
}
