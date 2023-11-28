import 'package:medicine_app/database/database_service.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:sqflite/sqflite.dart';

class ChatsDB {
  final tableName = 'chats';

  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS $tableName'
        '(id INTEGER NOT NULL,'
        'interlocutor TEXT NOT NULL,'
        'lastText TEXT NOT NULL,'
        'lastDate TEXT NOT NULL,'
        'PRIMARY KEY(id AUTOINCREMENT)'
        ')');
  }

  Future<int> create(
      {required String interlocutor,
      required String lastText,
      required String lastDate}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
        'INSERT INTO $tableName (interlocutor, lastText, lastDate) VALUES (?,?,?,?)',
        [interlocutor, lastText, lastDate]);
  }

  Future<List<Chat>> fetchAll() async {
    final database = await DatabaseService().database;

    final chats = await database.rawQuery('SELECT * from $tableName');
    return chats.map((chat) => Chat.fromSqfliteDatabase(chat)).toList();
  }

  Future<Chat> fetchById(int id) async {
    final database = await DatabaseService().database;
    final chat =
        await database.rawQuery('SELECT * from $tableName WHERE id = ?', [id]);
    return Chat.fromSqfliteDatabase(chat.first);
  }

  // Future<int> update({required int id, String? title}) async {
  //   final database = await DatabaseService().database;
  //   return await database.update(
  //       tableName,
  //       {
  //         if (title != null) 'title': title,
  //         'update_at': DateTime.now().microsecondsSinceEpoch,
  //       },
  //       where: 'id = ?',
  //       conflictAlgorithm: ConflictAlgorithm.rollback,
  //       whereArgs: [id]);
  // }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('DELETE from $tableName WHERE id = ?', [id]);
  }
}
