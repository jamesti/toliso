import 'package:flutter/material.dart';

void main() => runApp(ToLisoApp());

class ToLisoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: ListaLancamento());
  }
}

class FormularioLancamento extends StatelessWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TextEditingController _controladorCampoCategoria =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Lançamento"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorCampoValor,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: "Valor",
                  hintText: "0.00"),
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
                controller: _controladorCampoCategoria,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: "Categoria",
                    hintText: "Por exemplo: Transporte")),
          ),
          RaisedButton(
            child: Text("Inserir"),
            onPressed: () {
              final double valor = double.parse(_controladorCampoValor.text);
              final String categoria = _controladorCampoCategoria.text;
              final Lancamento lancamento = new Lancamento(valor, categoria);
              debugPrint("Lançamento Inserido!");
              debugPrint("$lancamento");
            },
          )
        ],
      ),
    );
  }
}

class ListaLancamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Economias"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ItemLancamento(new Lancamento(-100, 'Restaurante')),
          ItemLancamento(new Lancamento(200, 'Transferência')),
          ItemLancamento(new Lancamento(-30, 'Transporte')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormularioLancamento()),
          );
        },
      ),
    );
  }
}

class ItemLancamento extends StatelessWidget {
  final Lancamento _lancamento;

  ItemLancamento(this._lancamento);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          _lancamento.valor.toString(),
          style: _lancamento.valor < 0
              ? TextStyle(color: Colors.red)
              : TextStyle(color: Colors.green),
        ),
        subtitle: Text(_lancamento.categoria),
      ),
    );
  }
}

class Lancamento {
  final double valor;
  final String categoria;

  @override
  String toString() {
    return 'Lançamento {valor: $valor, categoria: $categoria}';
  }

  Lancamento(this.valor, this.categoria);
}
