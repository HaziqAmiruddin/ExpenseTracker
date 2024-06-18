import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  //onRemoveExpense is for delete swipe data
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //not a good practise to use column when many listing. it will run in the background. cost performance
    return ListView.builder(
      itemCount: expenses.length,
      //dismissible funstion for swipe to delete
      itemBuilder: (context, index) => Dismissible(
        //ValueKey make own key
        //need key because flutter in to know the widget sociate with it and remove the content
        key: ValueKey(expenses[index]),
        //to avoid error
        //need to add this
        //onDissed allow to trigger a function after swipe remove data
        //background is for while swipe to delete have background color effect
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.4),
          //add margin/gap for the backgroud swipe to delete
          //for only horizontal gap value to inlude and call out at main.dart using theme
          //need to use edgeinsets.symmetric
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),

        //Expense(
        // title: 'flutter course',
        // amount: 20,
        // date: DateTime.now(),
        // category: Category.leisure),
      ),
    );
  }
}
