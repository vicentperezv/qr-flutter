import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/widgets.dart';


class DireccionesScreen extends StatelessWidget {
   
  const DireccionesScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return ScanTile(icon: Icons.home_outlined);
  }
}