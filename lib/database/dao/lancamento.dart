import 'package:sqflite/sqflite.dart';
import 'package:tolise/models/lancamento.dart';

import '../app_database.dart';

class LancamentoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_valor REAL, '
      '$_categoria TEXT, '
      '$_data_cadastro TEXT)';
  static const String _tableName = 'finance';
  static const String _id = 'id';
  static const String _valor = 'valor';
  static const String _categoria = 'categoria';
  static const String _data_cadastro = 'data_cadastro';

  Future<int> save(Lancamento lance) async {
    final Database db = await getDatabase();
    Map<String, dynamic> lancamentoMap = _toMap(lance);
    return db.insert(_tableName, lancamentoMap);
  }

  Future<int> update(Lancamento lance) async {
    final Database db = await getDatabase();
    Map<String, dynamic> lancamentoMap = _toMap(lance);
    return db.update(_tableName, lancamentoMap,
        where: '$_id = ?', whereArgs: [lance.id]);
  }

  Future<int> delete(Lancamento lance) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [lance.id]);
  }

  Future<List<Lancamento>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Lancamento> lancamentos = _toList(result);
    return lancamentos;
  }

  Map<String, dynamic> _toMap(Lancamento lance) {
    final Map<String, dynamic> lancamentoMap = Map();
    lancamentoMap[_id] = lance.id == 0 ? null : lance.id;
    lancamentoMap[_valor] = lance.valor;
    lancamentoMap[_categoria] = lance.categoria;
    lancamentoMap[_data_cadastro] = lance.data_cadastro.toIso8601String();
    return lancamentoMap;
  }

  List<Lancamento> _toList(List<Map<String, dynamic>> result) {
    final List<Lancamento> lancamentos = List();
    for (Map<String, dynamic> row in result) {
      final Lancamento lance = Lancamento(row[_valor], row[_categoria],
          DateTime.parse(row[_data_cadastro]), row[_id]);
      lancamentos.add(lance);
    }
    return lancamentos;
  }
}
