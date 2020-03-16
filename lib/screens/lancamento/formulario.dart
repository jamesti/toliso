import 'package:flutter/material.dart';
import 'package:tolise/components/editor.dart';
import 'package:tolise/models/lancamento.dart';

class FormularioLancamento extends StatefulWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TextEditingController _controladorCampoCategoria =
  TextEditingController();

  @override
  _FormularioLancamentoState createState() => _FormularioLancamentoState();
}

class _FormularioLancamentoState extends State<FormularioLancamento> {
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
          Editor(
            controlador: widget._controladorCampoValor,
            rotulo: 'Valor',
            dica: '0.00',
            icone: Icons.monetization_on,
            tipoTeclado: TextInputType.number,
          ),
          Editor(
            controlador: widget._controladorCampoCategoria,
            rotulo: 'Categoria',
            dica: 'Por exemplo: Transporte',
          ),
          RaisedButton(
            child: Text("Inserir"),
            onPressed: () {
              CriarLancamento(context);
            },
          )
        ],
      ),
    );
  }

  void CriarLancamento(BuildContext context) {
    final double valor = double.tryParse(widget._controladorCampoValor.text);
    final String categoria = widget._controladorCampoCategoria.text;
    final Lancamento lancamento = new Lancamento(valor, categoria);
    if (valor != null || categoria.isNotEmpty) {
      debugPrint('Lançamento Inserido!');
      debugPrint('$lancamento');
      Navigator.pop(context, lancamento);
    } else {
      debugPrint('Falta preencher um dos campos!');
    }
  }
}