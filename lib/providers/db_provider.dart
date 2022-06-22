import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if( _database != null) return _database!;
      _database = await initDB();
      return _database!;
  }
  Future<Database> initDB() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate:  ( Database db, int version) async{
        await db.execute("""
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
          
        """);
      }
    );
  }

  Future<int> newScanRaw( ScanModel newScan ) async{
    
    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;

    final res = await db.rawInsert("""
      INSERT INTO Scans ( id, type, value )
      VALUES( $id, '$type', '$value')    
    """);

    return res;
  }

  Future<int?> newScan( ScanModel newScan ) async{
    
    final db = await database;

    final res = await db.insert('Scans', newScan.toMap());

    return res;
  }

  Future<ScanModel?> getScanById( int id ) async{
    final db = await database;
    final res = await db.query('Scans', where: 'id = ? ', whereArgs: [id]);

    return res.isNotEmpty
           ? ScanModel.fromMap( res.first )
           : null;
  }

  Future<List<ScanModel>?> getAllScan() async{
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
           ? res.map((s) => ScanModel.fromMap(s)).toList()
           : [];
  }
  
  Future<List<ScanModel>?> getScanByType( String type ) async{
    final db = await database;
    final res = await db.query('Scans',  where: 'type = ? ', whereArgs: [type]);

    return res.isNotEmpty
           ? res.map((s) => ScanModel.fromMap(s)).toList()
           : [];
  }

  Future<int> updateScan( ScanModel newScan) async{
    final db = await database;
    final res = await db.update('Scans', newScan.toMap(), where: 'id = ? ', whereArgs:[ newScan.id]);
    return res;
  }

  Future<int> delateScan( int id ) async{
    final db = await database;
    final res = await db.delete('Scans',where: 'id = ? ', whereArgs:[ id]);
    return res;
  }

  Future<int> delateAllScans() async{
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }  
}