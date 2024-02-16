import 'package:Cointrack/components/chart_bar.dart';
import 'package:Cointrack/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({required this.recentTransactions, super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final DateTime _weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var transaction in recentTransactions) {
        bool sameDay = transaction.date.day == _weekDay.day;
        bool sameMonth = transaction.date.month == _weekDay.month;
        bool sameYear = transaction.date.year == _weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }

      return {
        'day': DateFormat.E().format(_weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekSumValue {
    return groupedTransactions.fold(0.0, (double acc, item) {
      var value = item['value'] as double;

      return acc + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: transaction['day'] as String,
                    value: transaction['value'] as double,
                    percentage: _weekSumValue != 0
                        ? (transaction['value'] as double) / _weekSumValue
                        : 0));
          }).toList(),
        ),
      ),
    );
  }
}
