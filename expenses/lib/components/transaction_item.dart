import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final void Function(String) onRemove;
  final void Function(int, Transaction) undoRemove;

  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
    @required this.undoRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          tr.title,
          style: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: width * 0.044),
        ),
        subtitle: Text(
          DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(tr.date),
          style: TextStyle(
            fontSize: width * 0.032,
            color: Colors.grey[300],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- R\$ ${tr.value.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: width * 0.042,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 22,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
