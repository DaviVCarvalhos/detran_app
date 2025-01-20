import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/util/db_util.dart';
import 'package:sqflite/sqflite.dart' as sql;

class VeiculoDb {
  static Future<sql.Database> openDatabaseConnection() async {
    return await DbUtil.iniciarDatabase();
  }

  Future<void> adicionarVeiculo(Veiculo veiculo, String userId) async {
    final db = await VeiculoDb.openDatabaseConnection();
    await db.insert(
      'veiculos',
      veiculo.toJson()..['userId'] = userId,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<List<Veiculo>> recuperarVeiculos(String userId) async {
    final db = await VeiculoDb.openDatabaseConnection();
    final List<Map<String, dynamic>> veiculosMaps = await db.query(
      'veiculos',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    print("veiculos: ${veiculosMaps}");
    return List.generate(
      veiculosMaps.length,
      (i) => Veiculo.fromJson(
        veiculosMaps[i]['id'],
        veiculosMaps[i],
      ),
    );
  }

  Future<void> excluirVeiculo(String veiculoId) async {
    final db = await VeiculoDb.openDatabaseConnection();
    await db.delete(
      'veiculos',
      where: 'id = ?',
      whereArgs: [veiculoId],
    );
  }
}
