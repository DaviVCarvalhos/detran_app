import 'package:detranapp/models/Agendamento.dart';
import 'package:detranapp/util/db_util.dart';
import 'package:sqflite/sqflite.dart' as sql;

class AgendamentoDb {
  static Future<sql.Database> openDatabaseConnection() async {
    return await DbUtil.iniciarDatabase();
  }

  Future<void> adicionarAgendamento(Agendamento agendamento) async {
    final db = await AgendamentoDb.openDatabaseConnection();
    await db.insert(
      'agendamentos',
      agendamento.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Agendamento>> recuperarAgendamentos(String userId) async {
    final db = await AgendamentoDb.openDatabaseConnection();
    final List<Map<String, dynamic>> agendamentosMaps = await db.query(
      'agendamentos',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    print("Agendamentos: ${agendamentosMaps}");
    return List.generate(
      agendamentosMaps.length,
      (i) => Agendamento.fromJson(
        agendamentosMaps[i]['id'],
        agendamentosMaps[i],
      ),
    );
  }

  Future<void> excluirAgendamento(String agendamentoId) async {
    final db = await AgendamentoDb.openDatabaseConnection();
    await db.delete(
      'agendamentos',
      where: 'id = ?',
      whereArgs: [agendamentoId],
    );
  }
}
