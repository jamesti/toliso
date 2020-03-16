import 'package:flutter/material.dart';
import 'package:tolise/screens/lancamento/lista.dart';

void main() => runApp(ToLisoApp());

class ToLisoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: ListaLancamento());
  }
}
