import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
          child: FittedBox(
              child: Text(
            value.toStringAsFixed(2),
            style: Theme.of(context).textTheme.bodySmall,
          )),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          width: 10,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.0,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(3)),
            ),
            FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(3)),
                ))
          ]),
        ),
        const SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
