import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  // quando coloca {} é porque os parametros serao nomeados
  ChartBar({
    this.label, 
    this.value, 
    this.percentage
  });



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // toStringAsFixed -> é para ter no caso 2 numeros depois da virgula
        Container(
          height: 20, // tamanho fixo
          child: FittedBox(
            child: Text('${value.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          // widget da barrinha que tem a quantidade pintada
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5), // para ficar com as bordas redondidas
                ),
              ),
              // mesma coisa que SizedBox, so que esse é fracionado 
              FractionallySizedBox(
                heightFactor: percentage, // o fator que ele vai usar para pintar o componente é a porcentagem 
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, // vai pintar da cor primaria
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}