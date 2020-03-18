import 'package:flutter/material.dart';

class Seletor extends StatefulWidget {
  final List<String> lista;
  final String rotulo;
  final String dica;
  final Function validador;
  String controlador;

  Seletor(
      {this.controlador,
      this.lista,
      this.rotulo,
      this.dica,
      this.validador});

  @override
  _SeletorState createState() => _SeletorState();
}

class _SeletorState extends State<Seletor> {
  //String valorSelecionado = null;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.controlador,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      decoration:
          InputDecoration(hintText: widget.dica, labelText: widget.rotulo),
      validator: widget.validador,
      onChanged: (value) {
        widget.controlador = value;
      },
      items: widget.lista.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
