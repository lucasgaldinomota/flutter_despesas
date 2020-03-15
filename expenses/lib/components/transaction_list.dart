import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> _transactions;
  final void Function(String) onRemove;
  final void Function(int, Transaction) undoRemove;

  TransactionList(this._transactions, this.onRemove, this.undoRemove);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget._transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            );
          })
        : ListView.builder(
            padding: EdgeInsets.only(bottom: 75),
            itemCount: widget._transactions.length,
            itemBuilder: (ctx, index) {
              final tr = widget._transactions[index];
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.red[900],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.delete_outline,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                key: Key(tr.id),
                onDismissed: (direction) {
                  var item = widget._transactions.elementAt(index);
                  widget.onRemove(tr.id);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey[700],
                      content: Text(
                        "Despesa removida!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontSize: 15,
                        ),
                      ),
                      action: SnackBarAction(
                        label: "DESFAZER",
                        textColor: Colors.white,
                        onPressed: () {
                          widget.undoRemove(index, item);
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
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
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(tr.date),
                      style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '- R\$ ${tr.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 22,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
