import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';
import 'dart:io';
import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF303030),
    ));
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('pt', 'BR')
        ],
        debugShowCheckedModeBanner: false,
        title: 'Despesas Pessoais',
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.white,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.dark().textTheme.copyWith(
                title: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.dark().textTheme.copyWith(
                  title: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 27,
                  ),
                ),
          ),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
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
      title: 'Lanche',
      value: 15.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Almoço',
      value: 24.90,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'Jantar',
      value: 70.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't7',
      title: 'Nintendo Switch',
      value: 2000.00,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 't8',
      title: 'PS4 Pro',
      value: 1800.00,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't9',
      title: 'Faculdade',
      value: 1000.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't10',
      title: 'ESSA É A ÚLTIMA',
      value: 150.00,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

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

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            backgroundColor: Color(0x1FFFFFF),
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: const Text('Despesas Pessoais'),
            ),
            centerTitle: true,
            actions: actions,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1, -5),
                  end: Alignment(1, 2),
                  colors: [Colors.pink[600], Colors.deepPurple],
                ),
              ),
            ),
          );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.75 : 0.2),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.8),
                child: TransactionList(
                    _transactions, _removeTransaction, _undoRemove),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add, color: Colors.white, size: 35),
                    onPressed: () => _openTransactionFormModal(context),
                    backgroundColor: Colors.pink[600],
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
