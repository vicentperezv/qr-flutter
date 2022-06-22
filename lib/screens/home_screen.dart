import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/screens.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: (){
            Provider.of<ScanListProvider>(context, listen: false).deleteAllScans();
          },)
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context); 
    final currentIndex = uiProvider.selectedMenuOption;

    final scanListProvider = Provider.of<ScanListProvider>(context);

    final Map<int, Widget> homeScreenBody={};
    homeScreenBody[0] = const MapsScreen();
    homeScreenBody[1] = const DireccionesScreen();
    
    if ( currentIndex == 0 ) scanListProvider.loadScanByType('geo');
    if ( currentIndex == 1 ) scanListProvider.loadScanByType('http');
     
    return homeScreenBody[currentIndex]!;
  }
}