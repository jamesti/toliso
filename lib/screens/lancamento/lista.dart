import 'package:flutter/material.dart';
import 'package:tolise/database/dao/lancamento.dart';
import 'package:tolise/models/lancamento.dart';
import 'package:tolise/screens/lancamento/formulario.dart';

const _tituloAppBar = 'Minhas Economias';

class ListaLancamento extends StatefulWidget {
  List<Lancamento> _listaLancamentos = List();

  @override
  _ListaLancamentoState createState() => _ListaLancamentoState();
}

class _ListaLancamentoState extends State<ListaLancamento> {
  final LancamentoDao _dao = new LancamentoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Lancamento>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              widget._listaLancamentos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final lancamento = widget._listaLancamentos[index];
                  return ItemLancamento(lancamento, () {
                    setState(() {});
                  });
                },
                itemCount: widget._listaLancamentos.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioLancamento();
          })).then((lancamento) => _atualiza(lancamento));
        },
      ),
    );
  }

  void _atualiza(lancamento) {
    setState(() {});
  }
}

typedef StateCallback = void Function();

class ItemLancamento extends StatelessWidget {
  final Lancamento _lancamento;
  final StateCallback _setState;

  ItemLancamento(this._lancamento, [this._setState]);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormularioLancamento(_lancamento);
            })).then((value) => _setState());
          },
          child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(
                _lancamento.valor.toString(),
                style: _lancamento.valor < 0
                    ? TextStyle(color: Colors.red)
                    : TextStyle(color: Colors.green),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _excluirLancamento(context);
                },
              ),
              subtitle: Text(_lancamento.categoria))),
    );
  }

  Future<void> _excluirLancamento(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir Lançamento'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Excluir'),
              onPressed: () {
                new LancamentoDao().delete(_lancamento);
                _setState();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
