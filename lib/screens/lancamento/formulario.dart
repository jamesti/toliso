import 'package:flutter/material.dart';
import 'package:tolise/components/editor.dart';
import 'package:tolise/components/seletor.dart';
import 'package:tolise/database/dao/lancamento.dart';
import 'package:tolise/models/lancamento.dart';
import 'package:tolise/screens/lancamento/validacoes.dart';

const _tituloAppBar = 'Novo Lançamento';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoCategoria = 'Categoria';
const List<String> _listaCategorias = ['Aluguel', 'Alimentação', 'Transporte'];
const _dicaCampoCategoria = 'Selecione uma Categoria';

const _rotuloBotaoInserir = 'Salvar';

class FormularioLancamento extends StatefulWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();

  final Seletor _seletorListaCategoria = Seletor(
    lista: _listaCategorias,
    dica: _dicaCampoCategoria,
    rotulo: _rotuloCampoCategoria,
    validador: ValidaLancamento.categoria,
  );

  final Lancamento _lancamento;

  FormularioLancamento([this._lancamento]){
    if (_lancamento != null){
      _controladorCampoValor.text = _lancamento.valor.toString();
      _seletorListaCategoria.valorSelecionado = _lancamento.categoria;
    }
  }

  @override
  _FormularioLancamentoState createState() => _FormularioLancamentoState();
}

class _FormularioLancamentoState extends State<FormularioLancamento> {
  final _formKey = GlobalKey<FormState>();
  final LancamentoDao _dao = new LancamentoDao();

  bool _autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
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
                widget._seletorListaCategoria,
                RaisedButton(
                  child: Text(_rotuloBotaoInserir),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _criarLancamento(context);
                    } else {
                      setState(() {
                        _autovalidate = true;
                      });
                    }
                  },
                )
              ],
            ),
          )),
    );
  }

  void _criarLancamento(BuildContext context) {
    final double valor = double.tryParse(widget._controladorCampoValor.text);
    final String categoria = widget._seletorListaCategoria.valorSelecionado;
    final DateTime data_cadastro = DateTime.now();
    final Lancamento lancamento = Lancamento(valor, categoria, data_cadastro);

    if (lancamento != null) {
      _dao.save(lancamento).then((id) => Navigator.pop(context, lancamento));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Erro Inesperado!')));
    }
  }
}
