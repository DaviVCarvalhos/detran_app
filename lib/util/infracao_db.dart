import 'package:detranapp/models/Infracao.dart';
import 'package:detranapp/util/db_util.dart';
import 'package:sqflite/sqflite.dart' as sql;

class InfracaoDb {
  static Future<sql.Database> openDatabaseConnection() async {
    return await DbUtil.iniciarDatabase();
  }

  Future<void> adicionarInfracao(Infracao infracao) async {
    final db = await InfracaoDb.openDatabaseConnection();
    try {
      await db.insert(
        'infracoes',
        infracao.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error adding infraction: $e');
      rethrow;
    }
  }

  Future<List<Infracao>> recuperarInfracoes(String userId) async {
    final db = await InfracaoDb.openDatabaseConnection();
    try {
      final List<Map<String, dynamic>> infracoesMaps = await db.query(
        'infracoes',
        where: 'userId = ?',
        whereArgs: [userId],
      );
      print("Infrações: ${infracoesMaps}");
      return List.generate(
        infracoesMaps.length,
        (i) => Infracao.fromJson(
          infracoesMaps[i]['id'],
          infracoesMaps[i],
        ),
      );
    } catch (e) {
      print('Error retrieving infractions: $e');
      rethrow;
    }
  }

  Future<void> excluirInfracao(String infracaoId) async {
    final db = await InfracaoDb.openDatabaseConnection();
    try {
      await db.delete('infracoes');
    } catch (e) {
      print('Error deleting infraction: $e');
      rethrow;
    }
  }
}
