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
              margin: const EdgeInsets.only(top: 10),
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
                        height: 200,
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
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: FittedBox(
                          child: Text(
                            'R\$${transaction.value}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd('pt_BR').format(transaction.date),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                );
              },
            ),
    );
  }
}
