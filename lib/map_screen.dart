import 'package:flutter/material.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> myMarker = [];
  BitmapDescriptor customIcon;
  Set<Marker> markers;

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/car_icon.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

//in init state
// var locationData = await Location().getLocation(); 
// currentLocation = LatLng(locationData.latitude, locationData.longitude); 
// print(locationData.longitude); print(locationData.latitude);}

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            // Gangnam station: 37.498165, 127.027052
            // Banpo station:   37.507977, 127.010294
            CameraPosition(target: LatLng(37.507977, 127.010294), zoom: 18.0),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {},
        // markers: Set.from(myMarker),
        // onTap: _handleTap,
        markers: markers,
        onTap: (pos) {
          print(pos);
          Marker m =
              Marker(markerId: MarkerId('1'), icon: customIcon, position: pos);
          setState(() {
            markers.add(m);
          });
        },
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);

    setState(() {
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          // infoWindow: InfoWindow.noText,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
    });
  }
}
