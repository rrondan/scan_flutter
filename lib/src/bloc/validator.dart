import 'dart:async';

import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';

mixin Validator{
   //                                  Tipo de entrada    Tipo de salida
  final validarGeo = StreamTransformer<List<ScanModel> , List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ){
      List<ScanModel> geoScans = scans.where((s) => s.tipo == "geo").toList();
      sink.add(geoScans);
    }
  );

  final validarHttp = StreamTransformer<List<ScanModel> , List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ){
      List<ScanModel> httpScans = scans.where((s) => s.tipo == "http").toList();
      sink.add(httpScans);
    }
  );

}