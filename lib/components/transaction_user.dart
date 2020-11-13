import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {

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
  }

  @override
  Widget build(BuildContext context) {
    // se a lista _transactions for alterada, automaticamente esse metodo Build vai rodar e passar uma nova lista para TransactionList()
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}