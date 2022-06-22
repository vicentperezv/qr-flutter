import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/util.dart';

class ScanTile extends StatelessWidget {
  final IconData icon;
  const ScanTile({
    Key? key,
    required this.icon,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
  
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_ , i) => Dismissible(
        key: Key( scans[i].id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(color: Colors.red),
        onDismissed: (DismissDirection direction){
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon( icon ),
          title: Text(scans[i].value),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon( Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: ()=>launch(context, scans[i]),
        ),
      ));
  }
}