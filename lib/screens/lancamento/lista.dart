import 'package:flutter/material.dart';
import 'package:tolise/database/dao/lancamento.dart';
import 'package:tolise/models/lancamento.dart';
import 'package:tolise/screens/lancamento/formulario.dart';

const _tituloAppBar = 'Minhas Economias';

class ListaLancamento extends StatelessWidget {
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
              final List<Lancamento> lancamentos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Lancamento lancamento = lancamentos[index];
                  return ItemLancamento(lancamento);
                },
                itemCount: lancamentos.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      /*ListView.builder(
        itemCount: widget._listaLancamentos.length,
      itemBuilder: (context, index) {
        final lancamento = widget._listaLancamentos[index];
        return ItemLancamento(lancamento);
      },
    ),*/
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
    if (lancamento != null) {
      /*setState(() {
        widget._listaLancamentos.add(lancamento);
      });
       */
    }
  }
}

class ItemLancamento extends StatelessWidget {
  final Lancamento _lancamento;

  ItemLancamento(this._lancamento);

  @override
  Widget build(BuildContext context) {
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
