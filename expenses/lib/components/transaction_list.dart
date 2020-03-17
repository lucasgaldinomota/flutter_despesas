import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> _transactions;
  final void Function(String) onRemove;
  final void Function(int, Transaction) undoRemove;

  const TransactionList(this._transactions, this.onRemove, this.undoRemove);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget._transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(height: 40),
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
            padding: const EdgeInsets.only(bottom: 75),
            itemCount: widget._transactions.length,
            itemBuilder: (ctx, index) {
              final tr = widget._transactions[index];
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.red[900],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: const Icon(
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
                        "${tr.title} removida(a)!",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontSize: 15,
                        ),
                      ),
                      action: SnackBarAction(
                        label: "DESFAZER",
                        textColor: Colors.greenAccent,
                        onPressed: () {
                          widget.undoRemove(index, item);
                        },
                      ),
                    ),
                  );
                },
                child: TransactionItem(
                  tr: tr,
                  onRemove: widget.onRemove,
                  undoRemove: widget.undoRemove,
                ),
              );
            },
          );
  }
}
