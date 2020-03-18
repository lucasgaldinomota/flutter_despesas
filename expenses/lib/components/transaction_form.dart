import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';
import 'adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit);

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1, -2),
              end: Alignment(0, 1),
              colors: [Colors.pink[600], Colors.deepPurple],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AdaptativeTextField(
                  label: 'Título da despesa',
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.73,
                      child: AdaptativeTextField(
                        label: 'Valor (R\$)',
                        controller: _valueController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onSubmitted: (_) => _submitForm(),
                      ),
                    ),
                    Container(
                      width: width * 0.2,
                      child: AdaptativeDatePicker(
                        selectedDate: _selectedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            _selectedDate = newDate;
                          });
                        },
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
                        : 'Data Selecionada: ${DateFormat("dd 'de' MMMM 'de' y", 'pt_BR').format(_selectedDate)}',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: width * 0.035,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdaptativeButton(
                      label: 'Nova Transação',
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
