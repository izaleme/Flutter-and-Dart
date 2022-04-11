import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Aplicativo simples que lista hospitais, mostra mais informações ao abrir outra tela e salva novos dados em uma tabela.
//Por Izabela Leme

void main() {
  runApp(MyAppHome());
}

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hospitais de SP',
      home: _Lista(),
    );
  }
}

class _Lista extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class MyApp extends StatelessWidget {
  final List<Hospital> _hospitais = [
    new Hospital('Hospital da Unimed', 'Avenida Paulista', 'https://www.unimedfoz.com.br/downloads/UnimedFozOperadora.png', 'Geral', 30), 
    new Hospital('Quality Center', 'R. José', 'https://dentalis.com.br/wp-content/uploads/2019/05/clinica_odontologica-1024x683.png','Odontologia', 15),
    new Hospital('Hospital Estadual', 'Avenida Ranieri', 'https://lh3.googleusercontent.com/proxy/JGZdCMW7lUkslKMTW9SAH7WGnL-LjzAzFDVLcGxXlG1W-2FC3Cx3ySS7JlcqS4g5m1-zyQN2mlx5KY2CrreVNbK7CMi9Xh12KocRgwpztJOIu73qzXJhH9aF', 'Cirurgia Plástica', 5),
    new Hospital('Hospital Libanês', 'Praça do Líbano','https://saudebusiness.com/wp-content/uploads/2018/02/Hospital-S%C3%ADrio-Liban%C3%AAs-promove-Encontro-Nacional-de-M%C3%A9dicos-do-Futuro.jpg', 'Medicina Oriental', 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hospitais'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () async {
                await Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => Cadastro()));
                setState(() {});
              },
            )
          ],
        ),
        body: Container(
          child: FutureBuilder(
              future: DataBase.listar(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${snapshot.data[index].foto}'),
                          ),
                          title: Text('${snapshot.data[index].nome}'),
                          subtitle:
                              Text('${snapshot.data[index].especialidade}'),
                          trailing: Icon(Icons.keyboard_arrow_right)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>
                                        Endereco(hospital: _hospitais[index])));
                          };
                    });
              }),
        ));
  }
}

class Endereco extends StatelessWidget{
  final Hospital hospital;
  Endereco({Key key, @required this.hospital}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Hospital"),
      ),
      body: Container( //Container serve para adequar vários elementos
        color: Colors.grey,
        child: new Column( //child guarda somente um elemento
          children: [ //children guarda vários elementos (array)
            new Container( //Imagem
              width: 500, //tamanho
              padding: new EdgeInsets.all(10.0), //margem
              child: Center(
                child: Image.network(
                  hospital.foto,
                ),
              ),
            ),
            new Container( //Nome
              padding: new EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  hospital.nome,
                  style: TextStyle(color: Colors.white, fontSize: 25) //cor e fonte da letra
                ),
              ),
            ),
            new Container( //Endereço
             padding: new EdgeInsets.all(10.0),
              child: Center(
                child: Text(hospital.endereco),
              ),
            ),
            new Container( //Especialidade
             padding: new EdgeInsets.all(10.0),
              child: Center(
                child: Text('\nEspecialidade: ' + hospital.especialidade),
              ),
            ),
            new Container( //Número de Leitos
             padding: new EdgeInsets.all(10.0),
              child: Center(
                child: Text('Número de leitos disponíveis: ' + hospital.numeroLeitos),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Cadastro extends StatelessWidget {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEndereco = TextEditingController();
  final TextEditingController _controladorEspecialidade =
      TextEditingController();
  final TextEditingController _controladorNumeroLeitos =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Hospital"),
        ),
        body: new Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controladorNome,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _controladorEndereco,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              TextField(
                controller: _controladorEspecialidade,
                decoration: InputDecoration(labelText: 'Especialidade'),
              ),
              TextField(
                controller: _controladorNumeroLeitos,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade de Leitos'),
              ),
              RaisedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  final String nome = _controladorNome.text;
                  final String endereco = _controladorEndereco.text;
                  final String especialidade = _controladorEspecialidade.text;
                  final int numeroLeitos =
                      int.tryParse(_controladorNumeroLeitos.text);

                  final Hospital hospitalNovo =
                      Hospital(nome, endereco, especialidade, numeroLeitos);
                  print(hospitalNovo);
                  //Hospitais.hospitais.add(hospitalNovo);
                  DataBase.salva(hospitalNovo);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
  }
}

class Hospital {
  final String nome;
  final String endereco;
  final String foto = 'http://abre.ai/bmg7';
  final String especialidade;
  final int numeroLeitos;

  Hospital(this.nome, this.endereco, this.especialidade, this.numeroLeitos);

  @override
  String toString() {
    return 'Hospital{nome: $nome, endereco: $endereco, especialidade: $especialidade, leitos: $numeroLeitos}';
  }
}

// Singleton
class Hospitais {
  static final Hospitais _singleton = new Hospitais._internal();
  static final List<Hospital> _hospitais = [
    new Hospital('Sírio Libanes', 'Avenida Paulista', 'Oncologia', 10),
    new Hospital(
        'Beneficiencia Portuguesa', 'Avenida Paulista', 'Pediatria', 10)
  ];

  factory Hospitais() {
    return _singleton;
  }

  static List<Hospital> get hospitais => _hospitais;
  Hospitais._internal();
}

/* Classe database */
class DataBase {
  static final DataBase _singleton = new DataBase._internal();

  factory DataBase() {
    return _singleton;
  }

  static _recuperandoBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "hospitais.db");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE HOSPITAIS (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, endereco VARCHAR, foto VARCHAR, especialidade VARCHAR, numeroleitos INTEGER)";

      db.execute(sql);
    });
    return bd;
  }

  static salva(Hospital hospital) async {
    Database bd = await _recuperandoBancoDados();
    Map<String, dynamic> dadosHospital = {
      "nome": hospital.nome,
      "endereco": hospital.endereco,
      "foto": hospital.foto,
      "especialidade": hospital.especialidade,
      "numeroleitos": hospital.numeroLeitos
    };

    int id = await bd.insert("HOSPITAIS", dadosHospital);
    print("Salvo:  $id");
  }

  static Future listar() async {
    Database bd = await _recuperandoBancoDados();
    List listaHospitais = await bd.rawQuery("SELECT * FROM HOSPITAIS");
    var _hospitais = new List();
    for (var item in listaHospitais) {
      Hospital hospital = new Hospital(item['nome'], item['endereco'],
          item['especialidade'], item['numeroLeitos']);
      _hospitais.add(hospital);
    }
    return _hospitais;
  }

  DataBase._internal();
}
