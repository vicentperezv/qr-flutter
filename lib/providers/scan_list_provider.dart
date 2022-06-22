
import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String type = 'http';

  newScan( String value ) async { 
    
    final newScan = new ScanModel( value:  value );
    final id =  await DBProvider.db.newScan(newScan);
    newScan.id = id;

    if( this.type == newScan.type){
      this.scans.add(newScan);
      notifyListeners();
    }
  }

  loadScan() async {
    final scans = await DBProvider.db.getAllScan();
    this.scans = [...scans!];
    notifyListeners();
  }

  loadScanByType( String type ) async {
    final scans = await DBProvider.db.getScanByType(type);
    this.type = type;
    this.scans = [...scans!];
    notifyListeners();
  }

  deleteAllScans() async{
    await DBProvider.db.delateAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById( int id ) async{
    scans.removeWhere((scan) => scan.id == id);
    await DBProvider.db.delateScan(id);
    
  }
}