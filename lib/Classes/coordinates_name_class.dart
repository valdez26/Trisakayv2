import 'package:geocoding/geocoding.dart';
import 'package:trisakay/packages.dart';
import 'package:location/location.dart' as loc;

Future<String> retrieveName(LatLng coordinates) async {
  List<Placemark> placemarks = [];

  try {
    placemarks = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
  } catch (e) {
    if (e.toString().contains('IO_ERROR')) {
      /**
       * [IO_ERROR] happen when there is no internet connection or geocoding server is down
       */
      return 'Geocoding limit has been reached.';
    }
  }

  return convertPlaceMarkToName(placemarks.first);
}

String convertPlaceMarkToName(Placemark placemark) {
  RxString placeName = ''.obs;

  if (placemark.street != '') {
    placeName.value = placemark.street!;
  }

  if (placeName.value == '' && placemark.name != '') {
    placeName.value = placemark.name!;
  }

  if (placeName.value == '' && placemark.thoroughfare != '') {
    placeName.value = placemark.thoroughfare!;
  }

  return placeName.value;
}

Future<LatLng?> currentLocation() async {
  try {
    loc.Location location = loc.Location();
    loc.LocationData locationData = await location.getLocation();

    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

    return latLng;
  } catch (e) {
    return null;
  }
}
