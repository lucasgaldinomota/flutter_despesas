import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';
import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);
  final ThemeData mainTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      debugShowCheckedModeBanner: false,
      title: 'Despesas',
      theme: mainTheme.copyWith(
        colorScheme: mainTheme.colorScheme.copyWith(
          primary: Colors.purple[800],
          secondary: Colors.pink[700],
        ),
        iconTheme: mainTheme.iconTheme.copyWith(
          color: Colors.white,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Conta de Água',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Internet',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Internet 2',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Internet 3',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Internet 4',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Internet 5',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Internet 6',
      value: 150.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't9',
      title: 'Internet 7',
      value: 150.00,
      date: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _undoRemove(index, item) {
    setState(() {
      _transactions.insert(index, item);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Despesas',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: mediaQuery.height * 0.18,
                child: Chart(_recentTransactions),
              ),
              Container(
                height: mediaQuery.height * 0.8,
                child: TransactionList(
                  _transactions,
                  _removeTransaction,
                  _undoRemove,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
          size: 35,
        ),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
