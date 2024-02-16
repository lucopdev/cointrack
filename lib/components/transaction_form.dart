import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function({
    required String title,
    required double value,
    required DateTime pickedDate,
  }) submitNewTransaction;

  const TransactionForm({
    required this.submitNewTransaction,
    super.key,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.00;

    if (title.isEmpty || value <= 0) return;

    widget.submitNewTransaction(
      title: title,
      value: value,
      pickedDate: _selectedDate,
    );
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onSubmitted: (value) => _submitForm(),
              controller: _titleController,
            ),
            TextField(
              style: Theme.of(context).textTheme.titleLarge,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (value) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
                labelStyle: Theme.of(context).textTheme.labelLarge,
              ),
              controller: _valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data selecionada: ${DateFormat('dd / MM / y').format(_selectedDate)}',
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: FittedBox(
                      child: Text(
                    'Selecionar Data',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Adicionar',
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
