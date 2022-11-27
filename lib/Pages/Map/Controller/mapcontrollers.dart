import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';
import 'dart:async';
import 'package:location/location.dart' as loc;

class MapControllers extends GetxController {
  GoogleMapController? googleMapController;
  final Completer<GoogleMapController> controller = Completer();
  final TextEditingController destination = TextEditingController();
  final TextEditingController pickup = TextEditingController();
  final Rxn<Set<Marker>> markers = Rxn<Set<Marker>>({}).obs();
  final Rxn<Set<Polyline>> polylines = Rxn<Set<Polyline>>({}).obs();
  final isDestination = true.obs;
  loc.Location location = loc.Location();
  Rxn<NewBooking> initialBooking = Rxn<NewBooking>(NewBooking()).obs();

  int role = Get.find<AuthController>().user.userRole!;

  //dio Direction Class polyline data
  Rxn<Directions?> dio = Rxn<Directions>(null).obs();

  RxString exception = ''.obs;

  final LatLng defaultLocation = const LatLng(6.933128, 122.052439);
  LatLng? myLocation;

  LatLng? pickupLocation;
  LatLng? destinationLocation;

  Rxn<BitmapDescriptor>? pickupMarker = Rxn<BitmapDescriptor>(null).obs();
  Polyline? routePolyline;

  CameraPosition initialGooglePlex = const CameraPosition(
    target: LatLng(6.933128, 122.052439),
    zoom: 16.4746,
  );

  @override
  void onInit() async {
    super.onInit();
    if (role == 1) {
      pickupMarker!.value = await createIcon();
      currentLocation();
    }
    dio.listen((p0) {
      if (p0 == null) {
        return;
      }
      attachPolyline();
    });
  }

  void currentLocation() async {
    try {
      loc.LocationData locationData = await location.getLocation();

      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16.4746,
      );

      initialBooking.value!.bookMyLocation = latLng;
      String placeName = await retrieveName(latLng);
      initialBooking.value!.bookMyLocationName.value = placeName;

      moveCameraCurrentPosition(cameraPosition);
    } catch (e) {
      exception.value = ' currentLocation module';
    }
  }

  void moveCameraCurrentPosition(CameraPosition position) {
    controller.future.then((gcontroller) =>
        gcontroller.animateCamera(CameraUpdate.newCameraPosition(
          position,
        )));
    initialGooglePlex = position;
  }

  void initLocation(CameraPosition position) async {
    try {
      initialBooking.value?.initializeLocation(position, isDestination.value);
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void initMarker() {
    try {
      LatLng? destination = initialBooking.value?.bookDestinationLocation;

      if (destination != null) {
        if (initialBooking.value!.bookDestinationMarker != null) {
          LatLng loc = initialBooking.value!.bookDestinationMarker!.position;
          if (destination != loc) {
            initialBooking.value!.bookDestinationMarker = createMarker(
                destination, 'My Destination', BitmapDescriptor.defaultMarker);
          }
        } else {
          initialBooking.value!.bookDestinationMarker = createMarker(
              destination, 'My Destination', BitmapDescriptor.defaultMarker);
        }
      }

      LatLng? pickup = initialBooking.value?.bookPickLocation;

      if (pickup != null) {
        //If has pickup location
        initialBooking.value!.bookPickupMarker = createMarker(
            pickup,
            'Pick Me Here',
            pickupMarker?.value ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet));
      }

      initializedLocationsName();
      attachMarker();

      if (destination != null) {
        buildPolyline(
            pickup ?? initialBooking.value!.bookMyLocation!, destination);
        initialBooking.value!.bookDistance = dio.value!.totalDistance!;
        initialBooking.value!.bookDuration = dio.value!.totalDuration!;
      }

      if (markers.value!.isNotEmpty) {
        markers.refresh();
      }
      Get.back();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void initializedLocationsName() async {
    try {
      if (initialBooking.value!.bookDestinationLocation != null) {
        String name =
            await retrieveName(initialBooking.value!.bookDestinationLocation!);
        initialBooking.value!.bookDestinationName.value = name;
        destination.text = name;
      }

      if (initialBooking.value!.bookPickLocation != null) {
        String name =
            await retrieveName(initialBooking.value!.bookPickLocation!);

        initialBooking.value!.bookPickupName.value = name;
        pickup.text = name;
        return;
      }

      initialBooking.value!.bookMyLocationName.value ==
          await retrieveName(initialBooking.value!.bookMyLocation!);
    } catch (e) {
      exception.value = e.toString();
    }
  }

  //build polyline for controller default polyline rx variable
  void buildPolyline(LatLng origin, LatLng destination) async =>
      dio.value = await createPolyline(origin, destination);

  void attachMarker() {
    try {
      markers.value!.clear();

      LatLng? destination = initialBooking.value?.bookDestinationLocation;
      LatLng? pickup = initialBooking.value?.bookPickLocation;

      if (pickup != null &&
          pickup != initialBooking.value?.bookMyLocation &&
          isDestination.isFalse) {
        markers.value!.add(initialBooking.value!.bookPickupMarker!);
      }

      if (destination != null && isDestination.isTrue) {
        markers.value!.add(initialBooking.value!.bookDestinationMarker!);
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void attachPolyline() {
    try {
      if (polylines.value != null) {
        polylines.value!.clear();
      }

      if (dio.value == null) {
        return;
      }

      polylines.value!.add(Polyline(
        polylineId: const PolylineId('overview_polyline'),
        color: Colors.deepPurple,
        width: 5,
        points: dio.value!.polylinePoints!
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList(),
      ));
      polylines.refresh();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  /// [convertLatLng] converting a LatLng type to Geopoint
  void submitBooking() async {
    if (initialBooking.value?.bookDestinationLocation == null) {
      return;
    }
    if (initialBooking.value?.bookMyLocation == null &&
        initialBooking.value?.bookPickLocation == null) {
      return;
    }

    try {
      LatLng dLocation = initialBooking.value!.bookDestinationLocation!;

      /// if pickup location is null then passenger current location will retrieve
      GeoPoint pickupPoint = convertLatLng(
          initialBooking.value?.bookPickLocation ??
              initialBooking.value!.bookMyLocation!);

      GeoPoint destinationPoint = convertLatLng(dLocation);

      firestore.collection(bookingCollection).add({
        "booking_pickup": pickupPoint,
        "booking_destination": destinationPoint,
        "booking_passengerID": auth.currentUser!.uid,
        "booking_distance": initialBooking.value!.bookDistance,
        "booking_duration": initialBooking.value!.bookDuration,
        "booking_total": initialBooking.value!.retrieveFair().toString(),
        "booking_riderID": "",
        "booking_status": 'Pending',
        "booking_date": DateTime.now(),
        "booking_rider_ratings": 4,
        "booking_rider_message": '',
      }).then((value) => Get.back());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void removeMarkerAndBooking() {
    try {
      dio.value = null;
      initialBooking.value!.bookPickupMarker = null;
      initialBooking.value!.bookDestinationMarker = null;
      markers.value!.clear();
      polylines.value!.clear();
      initialBooking.value = NewBooking();
      polylines.refresh();
      markers.refresh();
      currentLocation();
      destination.text = '';
      pickup.text = '';
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
