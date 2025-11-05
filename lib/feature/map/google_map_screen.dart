import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


final Uri _url = Uri.parse('https://www.google.com/maps?q=$,<LNG>');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
class GoogleMapScreen extends StatelessWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.9885700, 35.8757693),
    zoom: 20,
  );


  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Map')),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: 400,
            child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                mapType:MapType.satellite,


            ),
          ),
          ElevatedButton(onPressed: _launchUrl, child: Text("go to"))
        ],
      ),
    );
  }
}
