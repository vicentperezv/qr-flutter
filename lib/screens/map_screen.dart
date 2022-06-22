import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/models.dart';


class MapScreen extends StatefulWidget {
   
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
   Completer<GoogleMapController> _controller = Completer();
   MapType mapType = MapType.normal;
  
    
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

     final CameraPosition puntoInicial = CameraPosition(
        target: scan.getLatLng(),
        zoom: 14.4746,
      );

      Set<Marker> markers = new Set<Marker>();
      markers.add(new Marker(
        markerId: MarkerId('geo-locarion'),
        position: scan.getLatLng()
      ));
    return  Scaffold(
      appBar: AppBar(
        title: Text('Mapa') ,
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 14.4746,
                  )                 
                )
              );
            }, 
            icon: Icon( Icons.location_pin))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.layers),
        onPressed: () {
          if(mapType == MapType.normal){
            mapType = MapType.satellite;
          }else{
            mapType = MapType.normal;
          }
          setState(() { });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat ,
    );
  }
}