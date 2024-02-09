import 'package:expenses/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({required this.transactions, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: transactions.isEmpty
          ? Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    'Nenhuma transação cadastrada',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Opacity(
                      opacity: 0.5,
                      child: Container(
                        margin: const EdgeInsets.all(50),
                        height: 350,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      )),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        'R\$ ${transaction.value.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            DateFormat.yMMMMd('pt_BR').format(transaction.date),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ]),
                  ]),
                );
              },
            ),
    );
  }
}
