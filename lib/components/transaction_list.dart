import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
  return 
    Container(
      height:300,
      // com esse builder renderiza so os itens que estao aparecendo na tela 
      child: transactions.isEmpty ? Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Nenhuma Transação cadastrada',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png', 
              fit: BoxFit.cover,
            ),
          ),
        ],
      ): ListView.builder( 
        // com esses dois itens abaixo, constroi a lista sob demanda, conforme necessario 
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric( // margem para fora
                    horizontal: 15,
                    vertical: 10
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10), // margem dentro do elemento
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr.title,
                      // uma forma de adicionar o tema em um local especifico  
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      DateFormat('d MMM y').format(tr.date),
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                  ],
                ),
              ]
            ),
          );
        },
      )
    );
  }
}