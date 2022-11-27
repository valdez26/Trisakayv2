import 'package:trisakay/packages.dart';

/// [convertGeopoint] converting firestore location data type [GeoPoint] to
/// a [LatLng] object.
LatLng convertGeopoint(GeoPoint point) {
  return LatLng(point.latitude, point.longitude);
}

/// [createIcon] a custom marker icon to build custom pickup marker icon and default destination marker
Future<BitmapDescriptor> createIcon() async {
  return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
          size: Size(2, 2), platform: TargetPlatform.android),
      'assets/pickupIcon3.png',
      mipmaps: false);
}

/// [createMarker] generate marker recieving a position of pickup location or destination
/// title is for InfoWindow
/// [icon] recieve a BitmapDescriptor or Map Marker Icon
Marker createMarker(LatLng position, String title, BitmapDescriptor icon) {
  return Marker(
    markerId: MarkerId(position.toString()),
    position: position,
    infoWindow: InfoWindow(title: title),
    icon: icon,
  );
}

/// [createPolyline] create polyline using google direction api
/// pickup location and destination must not be null else error will throw
Future<Directions?> createPolyline(LatLng origin, LatLng destination) async {
  return await DirectionsRepository()
      .getDirections(origin: origin, destination: destination);
}

GeoPoint convertLatLng(LatLng location) {
  return GeoPoint(location.latitude, location.longitude);
}
