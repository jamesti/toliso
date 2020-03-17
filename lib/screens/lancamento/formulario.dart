import 'package:flutter/material.dart';
import 'package:tolise/components/editor.dart';
import 'package:tolise/models/lancamento.dart';
import 'package:tolise/screens/lancamento/validacoes.dart';

const _tituloAppBar = 'Novo Lançamento';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoCategoria = 'Categoria';
const _dicaCampoCategoria = 'Exemplo: Transporte';

const _rotuloBotaoInserir = 'Salvar';

class FormularioLancamento extends StatefulWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TextEditingController _controladorCampoCategoria =
      TextEditingController();

  @override
  _FormularioLancamentoState createState() => _FormularioLancamentoState();
}

class _FormularioLancamentoState extends State<FormularioLancamento> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Editor(
              controlador: widget._controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
              tipoTeclado: TextInputType.number,
              validador: ValidaLancamento.valor,
            ),
            Editor(
              controlador: widget._controladorCampoCategoria,
              rotulo: _rotuloCampoCategoria,
              dica: _dicaCampoCategoria,
              validador: ValidaLancamento.categoria,
            ),
            RaisedButton(
              child: Text(_rotuloBotaoInserir),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _criarLancamento(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _criarLancamento(BuildContext context) {
    final double valor = double.tryParse(widget._controladorCampoValor.text);
    final String categoria = widget._controladorCampoCategoria.text;
    final Lancamento lancamento = Lancamento(valor, categoria);
    if (lancamento != null) {
      Navigator.pop(context, lancamento);
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Erro Inesperado!')));
    }
  }
}
