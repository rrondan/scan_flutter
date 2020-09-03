import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }){
    if(this.valor.contains("http")) {
      this.tipo = "http";
    }
    else {
      this.tipo = "geo";
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };

  LatLng getLatLng(){
    //geo:-12.0900002,-76.9994732
    final List<String> lanlong = valor.substring(4).split(",");
    final double lat = double.parse( lanlong[0] );
    final double lng = double.parse( lanlong[1] );

    return LatLng(lat, lng);
  }
}