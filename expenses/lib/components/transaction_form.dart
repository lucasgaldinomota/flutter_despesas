import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Título'),
              style: TextStyle(fontFamily: 'Quicksand'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 330,
                  child: TextField(
                    controller: _valueController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submitForm(),
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.pink[600],
                    mini: true,
                    child: Icon(
                      Icons.date_range,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: _showDatePicker,
                  ),
                ),
              ],
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: Text(
                _selectedDate == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data Selecionada: ${DateFormat('dd / MMMM / y', 'pt_BR').format(_selectedDate)}',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.pink[600],
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
