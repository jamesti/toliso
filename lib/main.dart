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
          TextField(
            style: TextStyle(
              fontSize: 32.0
            ),
            decoration: InputDecoration(
              labelText: "Valor",
              hintText: "0.00"
            ),
            keyboardType: TextInputType.numberWithOptions(),
          ),
          TextField(),
          RaisedButton()
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

  Lancamento(this.valor, this.categoria);
}
