import 'package:calculadora/models/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../componentes/display.dart';
import '../componentes/keyboard.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final Memory memory = Memory();
  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
    //print(command);
  }

  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp //nao girar horizontalmente
  ]);

    return MaterialApp(
        home: Column(
      children: <Widget>[
        Display(memory.value), 
        Keyboard(_onPressed)
        ],
    ));
  }
}
