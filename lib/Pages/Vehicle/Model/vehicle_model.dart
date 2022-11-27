import 'package:trisakay/packages.dart';
import 'package:location/location.dart';
import 'package:trisakay/main.dart';

class VehicleModel {
  String? vehicleID;
  String? vehiclePlateNumber;
  // String? vehicleORCRurl;
  // String? vehicleRiderLicenceurl;
  Rxn<LatLng>? vehicleLocation = Rxn<LatLng>(null).obs();
  RxString exception = ''.obs;

  VehicleModel();

  VehicleModel.getDocumentSnapshot(DocumentSnapshot document) {
    try {
      vehicleID = document.id;
      vehiclePlateNumber = document.get('vehicle_plateNo');
      // vehicleORCRurl = document.get('vehicle_orcrURL');
      // vehicleRiderLicenceurl = document.get('vehicle_riderLicenceURL');
      vehicleLocation?.value =
          convertGeopoint(document.get('vehicle_location'));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  VehicleModel.getQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    try {
      vehicleID = document.id;
      vehiclePlateNumber = document.get('vehicle_plateNo');
      // vehicleORCRurl = document.get('vehicle_orcrURL');
      // vehicleRiderLicenceurl = document.get('vehicle_riderLicenceURL');
      vehicleLocation?.value =
          convertGeopoint(document.get('vehicle_location'));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void onLocationUpdate(LatLng location) => vehicleLocation?.value = location;

  //onLocation Change Update Data
  void onLocationChange(LocationData loc) =>
      updateLocation(LatLng(loc.latitude!, loc.longitude!));

  //Update location on datase
  void updateLocation(LatLng location) {
    try {
      firestore
          .collection(vehicleCollection)
          .doc(auth.currentUser!.uid)
          .update({'vehicle_location': location});
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
