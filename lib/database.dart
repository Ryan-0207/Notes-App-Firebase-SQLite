import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database db;

Future open() async {
  db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
      version: 1, onCreate: (Database db, int version) async {
    db.execute(
      "CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT)",
    );
  });
}

class Dog {
  final String title;
  final String descripton;

  Dog({this.title, this.descripton});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': descripton,
    };
  }
}

//inserting entries
Future<void> insertDog(Dog dog) async {
  if (db == null) {
    await open();
  }
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<Map<String, dynamic>>> getdogs() async {
  if (db == null) {
    await open();
  }

  final List<Map<String, dynamic>> maps = await db.query('dogs');
  return maps;
}

Future<void> deleteDog(int id) async {
  await db.delete(
    'dogs',
    where: "id = ?",
    whereArgs: [id],
  );
}

Future<void> deleteAll() async {
  if (db == null) {
    await open();
  }
  db.delete('dogs');
}
