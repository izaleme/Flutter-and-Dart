// EXERCICIO 20/07/2020
// LISTA DE HOSPITAIS COM LINK PARA ENDEREÇO
// POR Izabela Leme

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  final List<String> _hospitais = [
    "Autarquia Hospitalar Municipal Regional do Campo Limpo",
    "Autarquia Hospitalar Municipal Regional Central",
    "Autarquia Hospitalar Municipal Regional Central – Campos Elíseos",
    "Autarquia Hospitalar Municipal Regional do Campo Limpo",
    "Autarquia Hospitalar Municipal Regional de Ermelino Matarazzo",
    "Autarquia Hospitalar Municipal Regional de Ermelino Matarazzo – Cidade",
    "Autarquia Hospitalar Municipal Regional de Ermelino Matarazzo – Itaque",
    "Autarquia Hospitalar Municipal Regional Central – Vila Antônio",
    "Autarquia Hospitalar Municipal Regional Central – Jardim Cidade Piritu",
    "Autarquia Hospitalar Municipal Regional Central"];
  
  final List<String> _localizacao = ["Avenida 1", "Avenida 2", "Avenida 3", "Avenida 4", "Avenida 5", "Avenida 6", "Avenida 7", "Avenida 8", "Avenida 9", "Avenida 10"];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospitais de SP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hospitais com atendimento para o Covid-19 em SP'),
        ),
        body: ListView.builder( //Monta a lista automaticamente
          itemCount: _hospitais.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${_hospitais[index]}'),
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Endereco(localizacao: _localizacao[index])),
                );
              },
            );
          }
        ),
      ),
    );
  }
}

class Endereco extends StatelessWidget{
  final String localizacao;
  Endereco({Key key, @required this.localizacao}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Hospital"),
      ),
      body: Center(
        child: Text(localizacao),
      ),
    );
  }
}