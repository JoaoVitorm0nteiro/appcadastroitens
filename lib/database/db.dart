import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  // Construtor com acesso privado
  DB._();
  // Criar uma instancia do DB
  static final DB instance = DB._();
  // Instancia do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), ''),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_objects);
  }

  String get _objects => '''
CREATE TABLE objects (
  id INTEGET NOT NULL PRIMARY KEY AUTOINCREMENT,
  nome_objeto TEXT,
  tipo_objeto TEXT CHECK ( tipo_objeto IN ('eletronico','vestuario','livro','outros')) NOT NULL DEFAULT 'outros',
  prestamista TEXT NOT NULL DEFAULT 'Não especificado',
  data_devol TEXT NOT NULL,
  OBS_ITEM TEXT,
);
''';
}

/*
TABELA EXEMPLO MySql

CREATE TABLE objects (
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nome_objeto VARCHAR(30) NOT NULL,
  tipo_objeto ENUM ('eletronico', 'vestuario', 'livro', 'diversos') NOT NULL,
  Prestamista VARCHAR(30) NOT NULL,
  DATA_DEVOLUÇÃO VARCHAR(10) NOT NULL,
  OBS_ITEM VARCHAR(30) NOT NULL
);

*/
