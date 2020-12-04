import 'package:expenses/components/transaction_form.dart';

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';

import 'components/chart.dart';

main() => runApp(ExpensesApp());

// componente principal
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      // nesse componente principal que se define o tema
      theme: ThemeData(
        // esse primarySwatch define um conjunto de cor de uma mesma tonalizada
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction>_transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      // aqui eu estou pegando a data de hoje e subtraindo 7 dias 
      // e se esse resultado for depois de 7 dias atras, significa que essa transacao precisa estar na lista 
      // agora se for um data mais antiga que isso, vai dar falso e nao vai ser adicionada nas transacoes recentes
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(), title, value, date
    );

    // componente Stateful: muda quando alguem externo mudou o parametro (ex.: que vc recebeu como parametro) 
    // ou o estado do componente mudou e vc consegue renderizar a aplicacao 
    // componente Stateless: muda quando muda algo externo, que recebe o valor via parametro por exemplo
    setState(() {
      _transactions.add(newTransaction);
    });

    // fecha a modal 
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        // se o id passado por parametro for igual ao id da transacão, ele é removido
        return element.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          // essa forma de dar o tamanho para o texto é bem importante para aplicações responsivas 
          fontSize: 15 * MediaQuery.of(context).textScaleFactor,
        ),
        // uma forma de colocar a fonte em um determinado local:
        // style: TextStyle(
        //   fontFamily: 'OpenSans',
        // ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add), 
          onPressed: () => _openTransactionFormModal(context)),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height - 
        appBar.preferredSize.height - 
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // eixo da coluna (principal) - esse é o valor default
          crossAxisAlignment: CrossAxisAlignment.stretch, // eixo da linha - ocupa a area inteira da coluna (width)
          children: [
            Container(
              height: availableHeight * 0.3,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: availableHeight * 0.7,
              child: TransactionList(_transactions, _removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      // centraliza o floatingButton no meio da tela canto inferior (por padrao vem do lado direito)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, 
    );
  }
}