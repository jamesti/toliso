import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tolise/database/dao/lancamento.dart';

final String database = "toliso.db";

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), database);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(LancamentoDao.tableSql);
    },
    version: 1,
  );
}
