import 'package:flutter/material.dart';
import 'package:myapp/data/expense_data.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Add New Expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseNameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextField(
                controller: newExpenseAmountController,
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
              ),
            ],
          ),
          actions: [
            // save button
            MaterialButton(onPressed: save, child: const Text('Save')),
            // cancel button
            MaterialButton(onPressed: cancel, child: const Text('Cancel'))
          ]),
    );
  }

  // save
  save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );

    // add new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
  }

  // canel
  cancel() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: ListView.builder(
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ListTile(
              title: Text(value.getAllExpenseList()[index].name),
              subtitle:
                  Text(value.getAllExpenseList()[index].dateTime.toString()),
              trailing: IconButton(
                onPressed: () {
                  value.deleteExpense(value.getAllExpenseList()[index]);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          )),
    );
  }

  // Scaffold MyScaffold(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       // TRY THIS: Try changing the color here to a specific color (to
  //       // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
  //       // change color while the other colors stay the same.
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       // Here we take the value from the MyHomePage object that was created by
  //       // the App.build method, and use it to set our appbar title.
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       // Center is a layout widget. It takes a single child and positions it
  //       // in the middle of the parent.
  //       child: Column(
  //         // Column is also a layout widget. It takes a list of children and
  //         // arranges them vertically. By default, it sizes itself to fit its
  //         // children horizontally, and tries to be as tall as its parent.
  //         //
  //         // Column has various properties to control how it sizes itself and
  //         // how it positions its children. Here we use mainAxisAlignment to
  //         // center the children vertically; the main axis here is the vertical
  //         // axis because Columns are vertical (the cross axis would be
  //         // horizontal).
  //         //
  //         // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
  //         // action in the IDE, or press "p" in the console), to see the
  //         // wireframe for each widget.
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const Text(
  //             'You have pushed the button this many times:',
  //           ),
  //           Text(
  //             '$_counter',
  //             style: Theme.of(context).textTheme.headlineMedium,
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: addNewExpense,
  //       tooltip: 'Increment',
  //       child: const Icon(Icons.add),
  //     ), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
  // }
}
