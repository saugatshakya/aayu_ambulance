import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  late GoogleMapController _mapController;
  LatLng? currentPosition;
  Set<Marker> markers = {};
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      //currentPosition = LatLng(position.latitude, position.longitude);
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _setMapStyle() async {
    String style =
        await DefaultAssetBundle.of(context).loadString('assets/mapstyle.json');
    _mapController.setMapStyle(style);
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _setMapStyle();
    // QuerySnapshot snapshot =
    //     await Firestore.instance.collection('hospital').getDocuments();
    // for (int i = 0; i < snapshot.documents.length; i++) {
    //   var hospitaldata = snapshot.documents[i].data;
    //   String name = hospitaldata['name'];
    //   var addresses = await Geocoder.local.findAddressesFromQuery(name);
    //   var location = addresses.first.coordinates;
    markers.add(Marker(
        markerId: MarkerId("01"),
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        infoWindow: InfoWindow(title: "Patient", snippet: "Emergency")));
    // }
    setState(() {});
  }

  //final AuthService _auth = AuthService();
  //initialize the pressed with false to show the ambulance page
  String searchAddr = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    //find the current user
    //final user = Provider.of<User>(context);
    return currentPosition != null
        ? Container(
            height: 450,
            width: MediaQuery.of(context).size.width * 0.9,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: currentPosition!, zoom: 15),
              markers: markers,
              myLocationEnabled: true,
            ),
          )
        : SizedBox.shrink();
  }
}
