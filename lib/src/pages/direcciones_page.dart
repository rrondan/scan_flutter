import 'package:flutter/material.dart';
import 'package:sqcanner_qr_flutter/src/bloc/scans_bloc.dart';
import 'package:sqcanner_qr_flutter/src/models/scan_model.dart';
import 'package:sqcanner_qr_flutter/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {

  final _scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    _scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: _scansBloc.scansStreamHttp,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        final scans = snapshot.data;
        if(scans.isEmpty){
          return Center(child: Text("No hay información"));
        }
        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              //onDismissed: (direction) => DBProvider.db.deleteScan(scans[index].id),
              onDismissed: (direction) => _scansBloc.borrarScan(scans[index].id),
              child: ListTile(
                leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
                title: Text(scans[index].valor),
                subtitle: Text("ID: ${scans[index].id}"),
                trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor),
                onTap: () => utils.abrirScan(context, scans[index]),
              ),
            )
        );
      },
    );
  }
}
