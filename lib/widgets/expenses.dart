import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense(
    //   title: 'Flutter Course',
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   category: Category.work,
    // ),
    // Expense(
    //   title: 'Cinema',
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   category: Category.leisure,
    // ),
    // Expense(
    //   title: 'Sport Car',
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   category: Category.work,
    // ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      //flutter will adjust the space for if the phone have camera space at above
      //this useSafeArea is for making more space to details expenses enter details
      //would not hit cemera at other for all phone
      useSafeArea: true,
      // isScrollControlled is to make add expense take all full screen
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ), //Text('Model bottom sheet')
    );
  }

  //add expenses at board
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //for onDismmiss (avoid error for after swipre delete expense)
  void _removeExpense(Expense expense) {
    //to find just deleted expenses
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    //if remove multiple time then the first one dont appear for undo button
    ScaffoldMessenger.of(context).clearSnackBars();
    //show message we delete
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('You just delete expense'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //for check how many space we still have
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    //manipulate the rotate left/right view to fit our widget
    final width = MediaQuery.of(context).size.width;

    //for show word background if no expenses
    Widget mainContent = const Center(
      child: Text('No expenses'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // add width valiable to adjust the width size to fit our widget
      //mean we can change the column to row depanding the width < 600
      // ? means it also can be a null like if else statement
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                //const Text('The Chart'),
                //Text('Expenses List.......'),
                //
                // Expanded(
                //   child: ExpensesList(
                //     expenses: _registeredExpenses,
                //     onRemoveExpense: _removeExpense,
                //   ),
                // ),
                //
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                //need to add expanded because inside chart, state double infinity
                //mean chart take as much space for row also row take as much space for row
                //flutter cannot accept this situasion
                //so need to add expanded because expanded constraints the child(chart)
                //to take as much width as available in the row
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
