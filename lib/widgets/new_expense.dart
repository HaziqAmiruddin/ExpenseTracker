import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

//Date display format
final formatter = DateFormat.yMMMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  //add key in expenses to the board
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //1.
  //for user enter input then we store the input.
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  //2.
  //using flutter method for user enter input then we store the input.
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  //? meaning it does not contain any data(null) or either store or not store data
  DateTime? _selectedDate;
  //for category display at
  Category _selectedCategory = Category.leisure;

  //async and await meaning we want to the data after the user select
  //it a future data user pick
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //use cupertino to make dispay for eirther in
  //ios platform or android platform
  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, data and category was enetered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    } else {
      //show error message
      //show pop up
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, data and category was enetered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    //make amount need to be more that 0
    //change amount controller from text to number
    //tryparse can string and change the value to double
    //tryParse('Hello') => null, tryParse('1.12') => 1.12
    final enteredAmount = double.tryParse(_amountController.text);

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //trim is trim user input blank space
    //isEmpty(can be call for list and string) is trim properties while trim is method
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    //pass data from NewExpense class to _NewExpenseState
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    // to make after adding expense then the task section close
    Navigator.pop(context);
  }

  //need to add this dipose function because flutter method store the user input.
  //dispose method will dispose the user input when not needed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  //beside mediaquery, you can use widget layout builder
  //widget builder automaticaly adjust the ui to available spaces

  @override
  Widget build(BuildContext context) {
    // use below coding to find how much keyboard space it take
    // MediaQuery.of(context).viewInsets.bottom;

    //use the keyboard space to make adjustment
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    //use layout builder to adjust add details expenses next to how much money you spent
    return LayoutBuilder(
      builder: (ctx, constraints) {
        //can view the value of the space for min&max for length & width
        //print(constrainsts.minWidth);
        //print(constrainsts.maxWidth);
        //print(constrainsts.minHeight);
        //print(constrainsts.maxHeight);

        final width = constraints.maxWidth;

        //add padding with scholeable function
        //if want to take all the entire height for add details expenses
        //wrap singlechildscrollview with sizebox
        // inside the sizebox
        //add height: double.infinity,

        return SingleChildScrollView(
          child: Padding(
            //add keyboard space to adjust
            //also need to add schollable widget
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            //padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    //to make align with the title enter expenses
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // textfield allow user to enter enter
                      Expanded(
                        child: TextField(
                          //1.
                          //onChanged: _saveTitleInput,
                          //2.
                          controller: _titleController,
                          maxLength: 50,
                          //keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            label: Text('Ttile'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      //add enter money spend details
                      Expanded(
                        child: TextField(
                          //1.
                          //onChanged: _saveTitleInput,
                          //2.
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          //keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            //prefixText function is for after user press the input place $ will appear
                            prefixText: 'RM ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // textfield allow user to enter enter
                  TextField(
                    //1.
                    //onChanged: _saveTitleInput,
                    //2.
                    controller: _titleController,
                    maxLength: 50,
                    //keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Ttile'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        //display which category user choose at the box
                        value: _selectedCategory,
                        //make a drop dowm selection for enum category.
                        //need to use map because need to transport one type of value to other type of value
                        //because many selection of value
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  //change the value to string
                                  //name already string no need to make .to String
                                  // category.name.toString(),
                                  //.toUpperCase is for upper case all the word
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            //then make all the value string to list
                            .toList(),
                        onChanged: (value) {
                          //print which category we choose
                          //print(value);
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date Selected'
                                  // ! means it force flutter and mention is not null value
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          //1.
                          //onChanged: _saveTitleInput,
                          //2.
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          //keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            //prefixText function is for after user press the input place $ will appear
                            prefixText: 'RM ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date Selected'
                                  // ! means it force flutter and mention is not null value
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //1.
                          // print(_enteredTitle);
                          //2.
                          // print(_titleController.text);
                          // print(_amountController.text);
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        //display which category user choose at the box
                        value: _selectedCategory,
                        //make a drop dowm selection for enum category.
                        //need to use map because need to transport one type of value to other type of value
                        //because many selection of value
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  //change the value to string
                                  //name already string no need to make .to String
                                  // category.name.toString(),
                                  //.toUpperCase is for upper case all the word
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            //then make all the value string to list
                            .toList(),
                        onChanged: (value) {
                          //print which category we choose
                          //print(value);
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //1.
                          // print(_enteredTitle);
                          //2.
                          // print(_titleController.text);
                          // print(_amountController.text);
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
