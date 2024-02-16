import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:Cointrack/components/chart.dart';
import 'package:Cointrack/components/transaction_form.dart';
import 'package:Cointrack/components/transaction_list.dart';

import 'package:Cointrack/transaction.dart';
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
  List<Transaction> expenses = [];

  _MyHomePageState() {
    loadTransactions();
  }

  List<Transaction> get _recentTransactions {
    return expenses.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  Future<void> saveTransactions() async {
    final file = await _getLocalFile();
    final json = jsonEncode(
        expenses.map((transaction) => transaction.toJson()).toList());
    await file.writeAsString(json);
  }

  Future<void> loadTransactions() async {
    try {
      final file = await _getLocalFile();
      final json = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(json);
      setState(() {
        expenses = jsonData
            .map((item) => Transaction.fromJson(item))
            .toList()
            .cast<Transaction>();
      });
    } catch (e) {
      print("Erro ao carregar transações: $e");
    }
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/data.json');
  }

  void _addTransaction({
    required String title,
    required double value,
    required DateTime pickedDate,
  }) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: pickedDate);

    setState(() {
      expenses.add(newTransaction);
    });
    saveTransactions();
    Navigator.of(context).pop();
  }

  _deleteTransaction({required String id}) {
    setState(() {
      expenses.removeWhere((transaction) => transaction.id == id);
    });
    saveTransactions();
  }

  void _openTransactionFormModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(
            submitNewTransaction: _addTransaction,
          );
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
          TransactionList(
            transactions: expenses,
            deleteTransaction: _deleteTransaction,
          ),
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
          error: Colors.grey,
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
          headlineSmall: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
