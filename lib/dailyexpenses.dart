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

   if(description.isNotEmpty && amount.isNotEmpty){
     setState(() {
       total = double.parse(amount) + total;
       expenses.add(Expense(description, amount));
       // display the output in text field
       totalController.text = total.toStringAsFixed(1);

       descriptionController.clear();
       amountController.clear();



     });
   }
 }

 void _removeExpense(int index){
   setState(() {

     double cost = double.parse(expenses[index].amount);
     total = total - cost;
     totalController.text = total.toString();
     expenses.removeAt(index);

     if(expenses.length == 0){
       totalController.text = '0.0';
     }

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



