// EXERCICIO 20/07/2020
// LISTA DE HOSPITAIS 
// BY IZABELA LEME

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
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospitais de SP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hospitais para atendimento ao Covid-19 em SP'),
        ),
        body: ListView.builder( //Monta a lista automaticamente
          itemCount: _hospitais.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${_hospitais[index]}'),
            );
          }
        ),
      ),
    );
  }
}