import 'package:expenses/components/transaction_form.dart';

import 'dart:math';
import 'package:flutter/material.dart';

import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';

main() => runApp(ExpensesApp());

// componente principal
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _transactions = [
    Transaction(
      't1', 
      'Curso', 
      250.25, 
      DateTime.now()
    ),
    Transaction(
      't2', 
      'Melissa', 
      150.00, 
      DateTime.now()
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(), title, value, DateTime.now()
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _openTransactionFormModal(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // eixo da coluna (principal) - esse é o valor default
          crossAxisAlignment: CrossAxisAlignment.stretch, // eixo da linha - ocupa a area inteira da coluna (width)
          children: [
            Container(
              child: Card(
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions),
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