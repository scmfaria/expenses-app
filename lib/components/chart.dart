import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // pega o dia da semana que estamos 
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for(var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        // ele soma a transacao se estiver no mesmo dia, mes e ano
        // logo apos ele joga o valor total dessa soma em totalSum
        if(sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value; 
        }
      }

      return { 
        'day': DateFormat.E().format(weekDay)[0], // pega a primeira letra do nome do dia, exemplo: T de Tuesday
        'value': totalSum, 
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((tr) {
          return Text(
            '${tr['day']}: ${tr['value']}'
          );
        }).toList(),
      ),
    );
  }
}