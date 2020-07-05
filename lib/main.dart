import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  //variavel que recebe o calculo do imc
  double _imc = 0;
  String _info = "Informe Altura e o Peso";

//resetar as configurações
  void _resetFild() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _imc = 0;
      _info = "Informe Altura e o Peso";
    });
  }

//calculo do IMC
  calculoImc(double peso, double altura) {
    setState(() {
      _imc = peso / (altura * altura);

      if (_imc < 18.6) {
        _info = "Abaixo do Peso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 18.6 && _imc < 24.9) {
        _info = "Peso Ideal (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 24.9 && _imc < 29.9) {
        _info = "Levemente Acima do Peso (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 29.9 && _imc < 34.9) {
        _info = "Obesidade Grau I (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 34.9 && _imc < 39.9) {
        _info = "Obesidade Grau II (${_imc.toStringAsPrecision(3)})";
      } else if (_imc >= 40) {
        _info = "Obesidade Grau III (${_imc.toStringAsPrecision(3)})";
      }
      return _imc.toStringAsPrecision(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //um container
        appBar: AppBar(
          //cria uma barra no top do aplicativo
          title: Text("CALCULADORA IMC"),
          centerTitle: true, //centraliza o texto
          backgroundColor: Colors.black, //mua a cor do background da barra
          actions: <Widget>[
            //cria uma actions
            IconButton(
              //cria um botão com icone
              icon: Icon(
                  Icons.refresh), //adiciona o icone de refresh que é atualizar
              onPressed: () {
                _resetFild();
              },
            )
          ],
        ),
        backgroundColor: Colors.white, //background do stateffol fica branco
        //body é o corpo do aplicativo
        body:
            //scroll faz com que possa mover a tela
            SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              10, 0, 10, 0), //padding para todos os componentes
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, //'centraliza' na vertical tenta ocupar toda largura
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.red),
              Text(
                "$_info",
                style: TextStyle(fontSize: 25, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              TextField(
                keyboardType: TextInputType
                    .number, // tipo do teclado só aparecera numeros
                decoration: InputDecoration(
                  labelText: "Peso Em (KG)", // coloca um texto
                  labelStyle:
                      TextStyle(color: Colors.black), //coloca o estilo da label
                ),
                textAlign:
                    TextAlign.center, //alinha a entrada de dado ao centro
                style: TextStyle(color: Colors.red, fontSize: 25),
                controller: pesoController, //muda a cor de entrada do input
              ), //fala que o tipo de entrada ser  apenas Numeros
              TextField(
                keyboardType: TextInputType
                    .number, // tipo do teclado só aparecera numeros
                decoration: InputDecoration(
                  labelText: "Altura (cm)", // coloca um texto
                  labelStyle:
                      TextStyle(color: Colors.black), //coloca o estilo da label
                ),
                textAlign:
                    TextAlign.center, //alinha a entrada de dado ao centro
                style: TextStyle(color: Colors.red, fontSize: 25),
                controller: alturaController, //muda a cor de entrada do input
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  height: 50, //definindo a altura onde esta o botão
                  child: RaisedButton(
                    // botão com background
                    onPressed: () {
                      calculoImc(double.parse(pesoController.text),
                          double.parse(alturaController.text));
                    },
                    child: Text("CALCULAR"),
                    color: Colors.black,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
