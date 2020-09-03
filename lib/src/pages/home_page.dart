import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:sqcanner_qr_flutter/src/bloc/scans_bloc.dart';
import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';
import 'package:sqcanner_qr_flutter/src/pages/direcciones_page.dart';
import 'package:sqcanner_qr_flutter/src/pages/mapas_page.dart';
import 'package:sqcanner_qr_flutter/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final _scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              _scansBloc.borrarTodosScans();
            },
          )
        ],
      ),
      body: _callPage(_currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _scanQR(BuildContext context) async{
    String futureString;
    try{
      var result = await BarcodeScanner.scan(options: ScanOptions(
        //autoEnableFlash: true,
        strings: {
          "cancel": "Cerrar",
          "flash_on": "Activar",
          "flash_off": "Apagar"
        }
      ));
      futureString = result.rawContent;
      if(futureString != null){
        print("Contenido del Scan: $futureString");
        final scan = ScanModel(valor: futureString);
        _scansBloc.agregarScan(scan);
        utils.abrirScan(context, scan);
      }
    }catch (e){
      futureString = e.toString();
    }
  }

  Widget _callPage( int paginaActual ){
    switch(paginaActual){
      case 0 : return MapasPage();
      case 1 : return DireccionesPage();
      default: return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index){
        setState(() {
          _currentIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("Mapas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Direcciones"),
        )
      ],
    );
  }
}
