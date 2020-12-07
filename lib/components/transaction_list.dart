import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
  return 
    transactions.isEmpty ? LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Nenhuma Transação cadastrada',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset('assets/images/waiting.png', 
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      },
    ): ListView.builder( 
      // com esses dois itens abaixo, constroi a lista sob demanda, conforme necessario 
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tr = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 8,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('R\$${tr.value}')
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              DateFormat('dd MMM y').format(tr.date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => onRemove(tr.id),
            ),
          ),
        );
      },
    );
  }
}