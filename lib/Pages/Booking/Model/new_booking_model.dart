import 'package:trisakay/packages.dart';

class NewBooking {
  RxString bookPickupName = ''.obs;
  RxString bookDestinationName = ''.obs;
  RxString bookMyLocationName = 'My location'.obs;

  LatLng? bookPickLocation;
  LatLng? bookDestinationLocation;
  LatLng? bookMyLocation;
  String? bookRider;
  String? bookDate;
  String? bookStatus;
  String? bookDistance;
  String? bookDuration;
  String? bookTotal;
  Marker? bookPickupMarker;
  Marker? bookDestinationMarker;
  Rxn<Directions>? bookPolyline = Rxn<Directions>(null).obs();
  BitmapDescriptor? pickupMarker;
  RxString exception = ''.obs;

  NewBooking() {
    initializeBitMarker();
  }

  void initializeBitMarker() async => pickupMarker = await createIcon();

  void initializeLocation(CameraPosition position, bool destination) async {
    try {
      if (destination) {
        bookDestinationLocation =
            LatLng(position.target.latitude, position.target.longitude);
        return;
      }

      bookPickLocation =
          LatLng(position.target.latitude, position.target.longitude);
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void initializePolyline() async {
    /**
     * default polyline will use origin of user location
     * if origin specified polyline will use the pickup location
     */
    try {
      if (bookPickLocation != null) {
        bookPolyline!.value =
            await createPolyline(bookPickLocation!, bookDestinationLocation!);
        bookPolyline!.refresh();
        return;
      }
      bookPolyline!.value =
          await createPolyline(bookMyLocation!, bookDestinationLocation!);
      bookPolyline!.refresh();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  double retrieveFair() {
    AuthController user = Get.find<AuthController>();
    RateModel rate = user.controllerHandlerClass!.rateController!.rate.value!;
    double distance = double.parse(bookDistance!.split(' ')[0]);
    return distance * rate.rate! + rate.baseRate!;
  }

  String get retrieveTotal =>
      PriceClass().priceFormat(double.parse(bookTotal!));
}
