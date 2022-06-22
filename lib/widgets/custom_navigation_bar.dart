import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context); 

    final currentIndex = uiProvider.selectedMenuOption;
    
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOption = i,
      currentIndex: currentIndex,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.map_outlined),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.explore_outlined),
          label: 'Direcciones'
        ),
      ]);
  }
}