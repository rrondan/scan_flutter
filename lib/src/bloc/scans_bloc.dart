
import 'dart:async';

import 'package:sqcanner_qr_flutter/src/bloc/validator.dart';
import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';
import 'package:sqcanner_qr_flutter/src/providers/db_provider.dart';

class ScansBloc with Validator{

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() => _singleton;

  ScansBloc._internal(){
    // Obtener Scans desde la base de datos
    obtenerScans();
  }

  final StreamController<List<ScanModel>> _scansStreamController =
                                StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamGeo => _scansStreamController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansStreamController.stream.transform(validarHttp);

  dispose() {
    _scansStreamController?.close();
  }

  obtenerScans() async{
    _scansStreamController.sink.add( await DBProvider.db.getTodosScans() );
  }

  borrarScan(int id) async{
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarTodosScans() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

  agregarScan(ScanModel scanModel) async{
    await DBProvider.db.nuevoScan(scanModel);
    obtenerScans();
  }

}