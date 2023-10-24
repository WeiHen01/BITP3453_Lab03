import 'package:flutter/material.dart';

void main(){
  runApp(DailyExpensesApp());
}

class Expense{
  final String description;
  final String amount;

  Expense(this.description, this.amount);
}

class DailyExpensesApp extends StatelessWidget {
  const DailyExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseList(),
    );
  }
}

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
 final List<Expense> expenses = [];
 final TextEditingController descriptionController = TextEditingController();
 final TextEditingController amountController = TextEditingController();
 final TextEditingController totalController = TextEditingController();

 double total = 0.0;

 void _addExpense(){
   String description = descriptionController.text.trim();
   String amount = amountController.text.trim();
   double cost = double.parse(amount);


   if(description.isNotEmpty && amount.isNotEmpty){
     setState(() {

       expenses.add(Expense(description, amount));

       /**
        * Iteration
        */
       for(Expense index in expenses)
         {
           total = total + double.parse(index.amount);
         }
       descriptionController.clear();
       amountController.clear();

       // display the output in text field
       totalController.text = total.toStringAsFixed(1);

     });
   }
 }

 void _removeExpense(int index){
   setState(() {

     /**
      *   double.tryParse(expenses[index].amount):
      *   ------------------------------------------------------------------------
      *   - This line attempts to parse the amount stored in the expenses list
      *     at the specified index into a double.
      *   - If the parsing is successful, parsedAmount will be assigned the parsed
      *     double value.
      *   - If the parsing fails (e.g., if the amount is not a valid number),
      *     parsedAmount will be set to null.
      *
      *   parsedAmount!:
      *   ----------------------------------------------------------------------
      *   - The ! operator is used to assert that you are sure that parsedAmount
      *     is not null.
      *   - This is done because parsedAmount is defined as a nullable double,
      *     and you want to use it as a non-nullable double in the subsequent operations.
      *
      *   total -= parsedAmount!;:
      *   ----------------------------------------------------------------------
      *   - If the parsing was successful, this line subtracts the parsed amount
      *     (non-nullable double) from the total variable.
      *
      * */

     double ? parsedAmount = double.tryParse(expenses[index].amount);
     total -= parsedAmount!;
     totalController.text = total.toString();
     expenses.removeAt(index);

   });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Expenses'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount (RM)',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: totalController,
              decoration: InputDecoration(
                labelText: 'Total Spend(RM)',
              ),
            ),
          ),

          ElevatedButton(
            onPressed: _addExpense,
              child: Text('Add Expense')
          ),

          Container(
            child: _buildListView(),
          ),
        ],
      )
    );
  }

 Widget _buildListView() {
   return Expanded(
     child: ListView.builder(
         itemCount: expenses.length,
         itemBuilder: (context, index) {
           return Card(
             child: ListTile(
               title: Text(expenses[index].description),
               subtitle: Text('Amount: ${expenses[index].amount}'),
               trailing: IconButton(
                 icon: Icon(Icons.delete),
                 onPressed: () => _removeExpense(index),
               ),
             ),
           );
         }
     ),
   );
 }
}



