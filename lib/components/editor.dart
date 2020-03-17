import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;
  final TextInputType tipoTeclado;
  final Function validador;

  Editor(
      {this.controlador,
      this.rotulo,
      this.dica,
      this.icone,
      this.tipoTeclado,
      this.validador});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      style: TextStyle(fontSize: 24.0),
      decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica),
      keyboardType: tipoTeclado ?? TextInputType.text,
      validator: validador,
    );
  }
}
