import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Function({required String title, required double value})
      submitNewTransaction;

  const TransactionForm({required this.submitNewTransaction, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.00;

    if (title.isEmpty || value <= 0) return;

    widget.submitNewTransaction(title: title, value: value);
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
              controller: titleController,
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
              controller: valueController,
            ),
            FittedBox(
              child: Row(
                children: [
                  const Text('Nenhuma data selecionada!'),
                  TextButton(
                    onPressed: () {},
                    child: FittedBox(
                        child: Text(
                      'Selecionar Data',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                  ),
                ],
              ),
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
