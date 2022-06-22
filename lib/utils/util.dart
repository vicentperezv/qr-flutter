import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

void launch( BuildContext context, ScanModel scan) async {
  final Uri _url = Uri.parse(scan.value);
  if( scan.type == 'http'){
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }else{
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
  
}