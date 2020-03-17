import 'package:flutter/material.dart';

class Seletor extends StatefulWidget {
  String controlador;
  final List<String> lista;
  final String rotulo;
  final String dica;
  final Function validador;

  Seletor(
      {this.controlador, this.lista, this.rotulo, this.dica, this.validador});

  @override
  _SeletorState createState() => _SeletorState();
}

class _SeletorState extends State<Seletor> {
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
      onChanged: (String newValue) {
        setState(() {
          widget.controlador = newValue;
        });
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
