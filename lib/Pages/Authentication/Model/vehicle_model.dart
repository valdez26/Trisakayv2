import 'package:trisakay/packages.dart';

class VehicleModel {
  String? vehicleID;
  String? vehiclePlateNumber;
  Rxn<LatLng?> riderLocation = Rxn<LatLng>(null).obs();

  RxString exception = ''.obs;

  VehicleModel();

  VehicleModel.getDocumentSnapshot(DocumentSnapshot document) {
    try {
      vehicleID = document.id;
      riderLocation.value = convertGeopoint(document.get('vehicle_location'));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  VehicleModel.getQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    try {
      vehicleID = document.id;
      riderLocation.value = convertGeopoint(document.get('vehicle_location'));
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
