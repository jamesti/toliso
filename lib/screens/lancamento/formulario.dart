import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tolise/components/editor.dart';
import 'package:tolise/components/seletor.dart';
import 'package:tolise/database/dao/lancamento.dart';
import 'package:tolise/models/lancamento.dart';
import 'package:tolise/screens/lancamento/validacoes.dart';
import 'package:tolise/models/logradouro.dart';
import 'package:http/http.dart' as http;

const _tituloAppBar = 'Novo Lançamento';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoCep = 'CEP';
const _dicaCampoCep = '99999-99';

const _rotuloCampoLogradouro = 'Logradouro';
const _rotuloCampoCidade = 'Cidade/UF';

const _rotuloCampoCategoria = 'Categoria';
const List<String> _listaCategorias = ['Aluguel', 'Alimentação', 'Transporte'];
const _dicaCampoCategoria = 'Selecione uma Categoria';

const _rotuloBotaoInserir = 'Salvar';

Future<Logradouro> fetchViaCep(String cep) async {
  final response = await http.get('https://viacep.com.br/ws/$cep/json');

  if (response.statusCode == 200) {
    return Logradouro.fromJson(json.decode(response.body));
  } else {
    throw Exception('CEP Inválido!');
  }
}

class FormularioLancamento extends StatefulWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();
  final TextEditingController _controladorCampoCep = TextEditingController();
  final TextEditingController _controladorCampoLogradouro =
      TextEditingController();
  final TextEditingController _controladorCampoCidade = TextEditingController();

  final Seletor _seletorListaCategoria = Seletor(
    lista: _listaCategorias,
    dica: _dicaCampoCategoria,
    rotulo: _rotuloCampoCategoria,
    validador: ValidaLancamento.categoria,
  );

  final Lancamento _lancamento;

  FormularioLancamento([this._lancamento]) {
    if (_lancamento != null) {
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
                    controlador: widget._controladorCampoCep,
                    rotulo: _rotuloCampoCep,
                    dica: _dicaCampoCep,
                    icone: Icons.map),
                BuscarCep(
                    widget._controladorCampoCep,
                    widget._controladorCampoLogradouro,
                    widget._controladorCampoCidade),
                Editor(
                    controlador: widget._controladorCampoLogradouro,
                    rotulo: _rotuloCampoLogradouro,
                    icone: Icons.map),
                Editor(
                    controlador: widget._controladorCampoCidade,
                    rotulo: _rotuloCampoCidade,
                    icone: Icons.map),
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
    int id = 0;

    if (widget._lancamento != null) {
      id = widget._lancamento.id;
    }

    final Lancamento lancamento =
        Lancamento(valor, categoria, data_cadastro, id);

    if (lancamento != null && lancamento.id > 0) {
      _dao.update(lancamento).then((id) => Navigator.pop(context));
    } else if (lancamento != null) {
      _dao.save(lancamento).then((id) => Navigator.pop(context));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Erro Inesperado!')));
    }
  }
}

class BuscarCep extends StatelessWidget {
  final TextEditingController _controladorCampoCep;
  final TextEditingController _controladorCampoLogradouro;
  final TextEditingController _controladorCampoCidade;

  BuscarCep(this._controladorCampoCep, this._controladorCampoLogradouro,
      this._controladorCampoCidade);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Buscar'),
      onPressed: () async {
        try {
          var log = await fetchViaCep(_controladorCampoCep.text);
          _controladorCampoLogradouro.text =
              '${log.logradouro} ${log.complemento} / ${log.bairro}';
          _controladorCampoCidade.text = '${log.localidade} / ${log.uf}';
        } catch (ex) {
          final snackBar = SnackBar(
            content: Text(ex.toString()),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
