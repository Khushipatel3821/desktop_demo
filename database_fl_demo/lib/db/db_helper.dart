import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Singleton
  DbHelper._(); // private constructor

  static final DbHelper getInstance = DbHelper._();

  // table note
  static final String TABLE_NOTE = "note";
  static final String COLUMN_SR_NO = "sr_no";
  static final String COLUMN_TITLE = "title";
  static final String COLUMN_DESCRIPTION = "description";

  Database? myDb;

  Future<Database> getDb() async {
    myDb ??= await openDb();
    return myDb!;
  }

  Future<Database> openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, "noteDb.db");
    return await openDatabase(dbPath, onCreate: (db, version) {
      // create all table
      db.execute(
          "create table $TABLE_NOTE ($COLUMN_SR_NO integer primary Key autoincrement, $COLUMN_TITLE text, $COLUMN_DESCRIPTION text)");
    }, version: 1);
  }

// Db Open() (Path -> if exits then open else create db)

// all queries

// Insertion
  Future<bool> addNote(
      {required String mTitle, required String mDescription}) async {
    var db = await getDb();
    int affectedRows = await db.insert(
        TABLE_NOTE, {COLUMN_TITLE: mTitle, COLUMN_DESCRIPTION: mDescription});
    return affectedRows > 0;
  }

  // Read All Data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDb();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }

  Future<bool> updateNote({required String mTitle, required String mDescription, required int idNo}) async {
   var db = await getDb();
   int affectedRows = await db.update(TABLE_NOTE, {
     COLUMN_TITLE : mTitle,
     COLUMN_DESCRIPTION : mDescription,
   }, where: "$COLUMN_SR_NO == $idNo ");
   return affectedRows > 0;
  }

  Future<bool> deleteNote({required int idNo}) async {
    var db = await getDb();
    // when we have to add multiple args with where condition at that time we have to pass query by this way.
    int affectedRows = await db.delete(TABLE_NOTE, where: "$COLUMN_SR_NO = ? ", whereArgs: ["$idNo"]);
    return affectedRows > 0;
  }
}
