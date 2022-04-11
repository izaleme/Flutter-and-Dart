import 'package:flutter/material.dart';

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
        title: Text('Calculo do Volume de Água de uma Piscina'),
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
  final _largura = TextEditingController();
  final _altura = TextEditingController();
  final _profundidade = TextEditingController();
  var txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _largura,
            decoration: const InputDecoration(
              hintText: 'Largura da Piscina',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _altura,
            decoration: const InputDecoration(
              hintText: 'Altura da Piscina',
            ),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _profundidade,
            decoration: const InputDecoration(
              hintText: 'Profundidade da Piscina',
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

  double _calculate() {
    double largura = double.parse(_largura.text);
    double altura = double.parse(_altura.text);
    double profundidade = double.parse(_profundidade.text);
    double valorGeral = largura * altura * profundidade;
    return valorGeral;
  }
}

class Result extends StatelessWidget {
  final double result;

  Result({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: Text(result.toString()),
      ),
    );
  }
}
