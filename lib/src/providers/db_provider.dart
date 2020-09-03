
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async{
    if(_database == null){
      _database = await initDB();
    }
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path , 'ScansDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){ },
      onCreate: (Database db, int version) async{
        await db.execute(
          'CREATE TABLE Scans ('
              ' id INTEGER PRIMARY KEY,'
              ' tipo TEXT,'
              ' valor TEXT'
          ')'
        );
      }
    );
  }

  // CREAR Registros
  nuevoScanRaw(ScanModel scanModel) async{
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES ( ${scanModel.id}, '${scanModel.tipo}', '${scanModel.valor}')"
    );
    return res;
  }

  nuevoScan(ScanModel scanModel) async{
    final db = await database;
    return await db.insert("Scans", scanModel.toJson());
  }

  //Actualizar registros
  Future<int> updateScan(ScanModel scanModel) async{
    final db = await database;
    final res = await db.update("Scans", scanModel.toJson(), where: "id = ?", whereArgs: [scanModel.id]);
    return res;
  }

  //SELECT - Obtener informacion
  Future<ScanModel> getScanId( int id ) async{
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async{
    final db = await database;
    final res = await db.query("Scans");
    List<ScanModel> list = res.isNotEmpty ? res.map(
            (element) => ScanModel.fromJson(element)
    ).toList() : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo( String tipo ) async{
    final db = await database;
    //final res = await db.query("Scans", where: "tipo = ?", whereArgs: [tipo]);
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo = '$tipo'");
    List<ScanModel> list = res.isNotEmpty ? res.map(
            (element) => ScanModel.fromJson(element)
    ).toList() : [];
    return list;
  }

  //Eliminar registros
  Future<int> deleteScan(int id) async{
    final db = await database;
    return db.delete("Scans", where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async{
    final db = await database;
    return db.rawDelete("DELETE FROM Scans");
  }
}