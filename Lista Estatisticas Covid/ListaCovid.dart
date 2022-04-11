// TRABALHO 2 - 26/07/2020
// ESTATÍSTICAS ESTADUAIS EM RELAÇÃO AO COVID-19
// POR Izabela Leme

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  final List<String> _estados = [
    "Estado do Acre",
    "Estado do Amazonas",
    "Estado de Goiás",
    "Estado de Minas Gerais",
    "Estado do Paraná",
    "Estado do Rio de Janeiro",
    "Estado do Rio Grande do Sul",
    "Estado de São Paulo",
    "Estado de Sergipe",
    "Estado do Tocantins"]; //10 Estados
  
  final List<String> _estatisticas = [
    "Casos Confirmados: 18.745\nMortes Confirmadas: 486",
    "Casos Confirmados: 96.463\nMortes Confirmadas: 3.217",
    "Casos Confirmados: 55.914\nMortes Confirmadas: 1.392",
    "Casos Confirmados: 112.571\nMortes Confirmadas: 2.429",
    "Casos Confirmados: 67.220\nMortes Confirmadas: 1.671",
    "Casos Confirmados: 156.325\nMortes Confirmadas: 12.835",
    "Casos Confirmados: 59.779\nMortes Confirmadas: 1.571",
    "Casos Confirmados: 483.982\nMortes Confirmadas: 21.606",
    "Casos Confirmados: 52.603\nMortes Confirmadas: 1.314",
    "Casos Confirmados: 21.767\nMortes Confirmadas: 346"
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospitais de SP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Estatísticas estaduais sobre o Covid-19'),
        ),
        body: ListView.builder( //Monta a lista automaticamente
        
        itemCount: _estados.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${_estados[index]}'),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Estatisticas(estatistica: _estatisticas[index])),
                    //builder: (context) => Dados(dados: _dados[index])),
                );
              },
            );
          }
        ),
      ),
    );
  }
}

class Estatisticas extends StatelessWidget{
  final String estatistica;
  Estatisticas({Key key, @required this.estatistica}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dados atualizados até o momento"),
      ),
      body: Center(
        child: Text(estatistica),
      ),
    );
  }
}