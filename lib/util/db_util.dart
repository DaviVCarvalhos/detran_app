import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> iniciarDatabase() async {
    final databasePath = await sql.getDatabasesPath();
    final pathToDatabase = path.join(databasePath, 'detran.db');

    return sql.openDatabase(
      pathToDatabase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE veiculos (
            id TEXT PRIMARY KEY,
            placa TEXT NOT NULL,
            renavam TEXT NOT NULL,
            modelo TEXT NOT NULL,
            anoFabricacao TEXT NOT NULL,
            nomeProprietario TEXT NOT NULL,
            proprietarioAnterior TEXT,
            userId TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE agendamentos (
            id TEXT PRIMARY KEY,
            categoria TEXT NOT NULL,
            data TEXT NOT NULL,
            horario TEXT NOT NULL,
            servico TEXT NOT NULL,
            userId TEXT NOT NULL,
            local TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE infracoes (
            id TEXT PRIMARY KEY,
            descricao TEXT NOT NULL,
            placa TEXT NOT NULL,
            valor REAL NOT NULL,
            quitada INTEGER NOT NULL,
            userId TEXT NOT NULL
          )
        ''');
      },
    );
  }
}
