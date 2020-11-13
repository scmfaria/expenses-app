import 'package:expenses/components/transaction_user.dart';

import 'package:flutter/material.dart';

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
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
            TransactionUser(),
          ],
        ),
      )
    );
  }
}