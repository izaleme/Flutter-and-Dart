import 'package:flutter/material.dart';

// TRABALHO 1 - CALCULO DE COMBUSTIVEL
// Por Izabela Leme

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Calculate(),
  ));
}

class Calculate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo de Combustível'),
      ),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _gasolina = TextEditingController();
  final _alcool = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _gasolina,
            decoration: const InputDecoration(
              hintText: 'Gasolina',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _alcool,
            decoration: const InputDecoration(
              hintText: 'Alccol',
            ),
            keyboardType: TextInputType.number,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Result(
                            result: _calculate(),
                          )),
                );
              },
              child: Text('Calcular'),
            ),
          )
        ],
      ),
    );
  }

  String _calculate() {
    double gasolina = double.parse(_gasolina.text);
    double alcool = double.parse(_alcool.text);
    double valorGeral = gasolina * alcool;
    return "Resultado: " + valorGeral.toString();
  }  
}

class Result extends StatelessWidget {
  final String result;

  Result({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Text(result),
      ),
    );
  }
}
