import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit); // aqui to recebendo uma funcao como parametro no construtor

  _submitForm() {
    // nesse caso, o componente pai (transaction_user) passou para o componente filho (transaction_form) uma funcao
    // que é essa funcao onSubmit, atraves do construtor
    // assim que ele pressionar, ele vai passar os dados para o pai transaction_user, 
    // que atualizara a lista atraves do metodo setState()
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) {
      return;
    }

    onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return 
      Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                controller: valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text('Nova Transação'),
                    onPressed: () {
                      _submitForm();   
                    },
                    textColor: Colors.purple,
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}