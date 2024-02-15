import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main(List<String> args) {
  if (2 > 1) {
    initializeDateFormatting('pt_BR', null).then((_) {
      runApp(ExpensesApp());
    });
  } else {
    runApp(ExpensesApp());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Tenis',
      value: 328.56,
      date: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Tenis',
      value: 318.56,
      date: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'Tenis',
      value: 348.56,
      date: DateTime.now().subtract(
        const Duration(days: 1),
      ),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction({required String title, required double value}) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(submitNewTransaction: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Cointrack',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
            color: Colors.white,
            iconSize: 40,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Chart(recentTransactions: _recentTransactions),
          TransactionList(transactions: _transactions),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ExpensesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();
  ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.blue,
          secondary: Colors.white,
        ),
        textTheme: tema.textTheme.copyWith(
          labelLarge: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.blue,
          ),
          titleLarge: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          bodyLarge: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          bodySmall: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
