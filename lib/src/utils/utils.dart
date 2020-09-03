import 'package:flutter/cupertino.dart';
import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

abrirScan( BuildContext context, ScanModel scanModel ) async{
  if(scanModel.tipo == "http"){
    await launchURL(scanModel.valor);
  } else{
    print("GEO..: ${scanModel.valor}");
    Navigator.pushNamed(context, "mapa", arguments: scanModel);
  }
}