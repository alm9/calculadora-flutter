import 'package:flutter/material.dart';
import 'button.dart';

class ButtonRow extends StatelessWidget {
  final List<Button> buttons;//recebe uma lista de botões
  ButtonRow(this.buttons);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,//esticar os elementos
            children: buttons.fold(<Widget>[], (list, b) {//.fold equivale ao reduce do javascript. No primeiro parâmetro passei uma lista vazia como valor inicial. Depois, para cada elemento da lista de botões buttons é executada a função, que significa: se lista vazia, add botão, senão add SizedBox
              list.isEmpty ? list.add(b) : list.addAll([SizedBox(width:1), b]);
              return list;
            }),
        
      ),
    );
  }
}