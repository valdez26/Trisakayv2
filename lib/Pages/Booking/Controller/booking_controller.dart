import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';
import 'dart:async';
import 'package:location/location.dart' as loc;

class BookingController extends GetxController {
  /// [Collection] is equal to meaning of SQL Table
  /// [Document] is equal meaning of SQL Table Row
  /// [Fileds] is equal meaning of SQL Row Column Data
  /// [Booking Collection] is initialization at [main] package.
  /// [role] present as user role, Data and UI will be display base on roles
  /// [roles type] [passenger] and [driver]

  int role = Get.find<AuthController>().user.userRole!;

  final TextEditingController rateRiderMessage = TextEditingController();

  final TextEditingController cancelReason = TextEditingController();
  RxBool onBookCancelSubmit = false.obs;

  //Booking variables
  RxList<Booking> bookingList = RxList<Booking>().obs();
  Rxn<Booking>? myBooking = Rxn<Booking>(null).obs();
  RxBool isComplete = RxBool(false).obs();

  //Rider variables
  RxList<VehicleModel> vehicleList = RxList<VehicleModel>().obs();
  Rxn<VehicleModel>? vehicle = Rxn<VehicleModel>(null).obs();

  RxString exception = ''.obs;

  // Home map controller
  GoogleMapController? googleMapController;
  loc.Location location = loc.Location();
  final Rxn<Set<Marker>> markersAvailableBooking = Rxn<Set<Marker>>({}).obs();
  final Rxn<Set<Marker>> markers = Rxn<Set<Marker>>({}).obs();
  final Rxn<Set<Polyline>> polylines = Rxn<Set<Polyline>>({}).obs();

  final Completer<GoogleMapController> controller = Completer();

  Rxn<BitmapDescriptor>? pickupMarkerIcon = Rxn<BitmapDescriptor>(null).obs();
  BitmapDescriptor riderMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

  Marker? pickupMarker;
  Marker? riderMarker;
  Marker? destinationMarker;

  //Stream location of user
  Stream<loc.LocationData> onChange = loc.Location().onLocationChanged;

  //dio Direction Class polyline data
  Rxn<Directions?> dio = Rxn<Directions>(null).obs();

  CameraPosition initialGooglePlex = const CameraPosition(
    target: LatLng(6.933128, 122.052439),
    zoom: 16.4746,
  );

  Rxn<Booking?> widgetBookingView = Rxn<Booking>(null).obs();

  @override
  void onInit() async {
    super.onInit();
    pickupMarkerIcon!.value = await createIcon();
    bookingList.bindStream(bookingListStream());
    onChange.listen((loc) => {
          if (role == 2)
            {
              Timer(const Duration(milliseconds: 1000),
                  () => updateRiderLocation(loc))
            },
          if (myBooking?.value != null)
            {
              if (role == 1)
                {
                  if (myBooking?.value!.bookStatus.value == 'OnProgress')
                    {
                      Timer(const Duration(seconds: 8),
                          () => updatePolylines(loc))
                    }
                }
              else if (role == 2)
                {
                  if (myBooking!.value != null)
                    {
                      if (myBooking!.value!.bookStatus.value == 'Active')
                        {
                          buildPolyline(LatLng(loc.latitude!, loc.longitude!),
                              myBooking!.value!.bookPickLocation!)
                        }
                      else if (myBooking!.value!.bookStatus.value ==
                          'OnProgress')
                        {
                          attachMarkersOfBooking(),
                          buildPolyline(LatLng(loc.latitude!, loc.longitude!),
                              myBooking!.value!.bookDestinationLocation!)
                        }
                    }
                }
            }
        });
    try {
      myBooking?.listen((data) {
        if (role == 1) {
          if (data == null) {
            return;
          }
          if (data.bookRider.value == '') {
            riderMarker = null;
          }
          if (data.bookStatus.value == 'Active') {
            //start rider stream
            vehicleList.bindStream(streamRiderModel());
          }
          if (data.bookStatus.value == 'Arrived') {
            //remove rider stream and marker
            vehicleList.close();
            riderMarker = null;
          }
        }
        if (role == 2) {}
      });
    } catch (e) {
      exception.value = e.toString();
    }
    if (role == 1) {
      try {
        vehicle?.listen((data) {
          if (data == null) {
            return;
          }
          riderMarker = createMarker(data.riderLocation.value!, "Your Rider",
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
        });
      } catch (e) {
        exception.value = e.toString();
      }
    }
    if (role == 1) {
      currentLocation();
    }
    dio.listen((p0) {
      if (dio.value == null) {
        return;
      }
      attachPassengerBookingMarkers();
      mountPolyline();
    });
  }

  void updateRiderLocation(loc.LocationData loc) {
    try {
      firestore
          .collection(vehicleCollection)
          .doc(auth.currentUser!.uid)
          .update({
        'vehicle_location': convertLatLng(LatLng(loc.latitude!, loc.longitude!))
      });
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void attachBookListMarker() {
    try {
      markersAvailableBooking.value!.clear();
      for (Booking book in bookingList) {
        if (book.destination != null) {
          markersAvailableBooking.value!.add(book.destination!);
        }
      }
      Future.delayed(const Duration(milliseconds: 500),
          () => markersAvailableBooking.refresh());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void currentLocation() async {
    try {
      loc.LocationData locationData = await location.getLocation();

      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

      CameraPosition cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16.4746,
      );

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

  Stream<List<Booking>> bookingListStream() {
    //Fetch List of booking in Booking Collection
    List<Booking> bookingList = [];

    Stream<QuerySnapshot> response =
        firestore.collection(bookingCollection).snapshots();

    response.listen((data) {
      if (data.docs.isNotEmpty) {
        bookingList.clear();
      }
    });

    return response.map((data) {
      for (QueryDocumentSnapshot document in data.docs) {
        if (role == 2) {
          if (document.get('booking_status') != 'Complete' &&
              document.get('booking_status') != 'Cancelled' &&
              (document.get('booking_riderID').toString() == '' ||
                  document.get('booking_riderID').toString() ==
                      auth.currentUser!.uid)) {
            if (myBooking?.value == null) {
              Booking newBooking = Booking.getQueryDocumentSnapshot(document);
              newBooking.pickup = createMarker2(
                  newBooking.bookPickLocation!,
                  'Pickup Location',
                  pickupMarkerIcon!.value ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet),
                  newBooking);
              newBooking.destination = createMarker2(
                  newBooking.bookDestinationLocation!,
                  'Destination: ${newBooking.bookDestinationName}',
                  BitmapDescriptor.defaultMarker,
                  newBooking);

              bookingList.add(newBooking);
              if (newBooking.bookRider.value == auth.currentUser!.uid) {
                myBooking!.value = newBooking;
                myBooking!.refresh();
                attachMarkersOfBooking();
              }
              continue;
            }

            if (myBooking!.value!.bookUID == document.get('booking_riderID')) {
              myBooking!.value!.bookStatus.value =
                  document.get('booking_status');

              if (myBooking!.value!.bookStatus.value == 'Arrived') {
                attachMarkersOfBooking();
              }
            }
          }
        }
        if (role == 1) {
          if (document.get('booking_passengerID') == auth.currentUser!.uid) {
            if (document.get('booking_status') != 'Complete' &&
                document.get('booking_status') != 'Cancelled') {
              if (myBooking?.value == null) {
                //Stream to monitor changes of booking or new booking.
                myBooking!.value = Booking.getQueryDocumentSnapshot(document);
                Future.delayed(const Duration(milliseconds: 1000));
                createPassengerBookingMarkers();
                attachPassengerBookingMarkers();
                markers.refresh();
                break;
              }

              myBooking!.value!.bookRider.value =
                  document.get('booking_riderID');
              myBooking!.value!.bookStatus.value =
                  document.get('booking_status');

              if (myBooking!.value!.bookStatus.value == 'Active') {
                myBooking!.value!.pickup = createMarker(
                    myBooking!.value!.bookPickLocation!,
                    'Pick up location',
                    pickupMarkerIcon!.value!);
              }

              if (document.get('booking_riderID') == '') {
                riderMarker = null;
              }

              attachPassengerBookingMarkers();

              break;
            }
            if (myBooking!.value != null) {
              if (myBooking!.value!.bookUID == document.id &&
                  document.get('booking_status') == 'Complete') {
                isComplete.value = true;
                // requestComplete();
              }
            }
          }
        }
      }
      return bookingList.toList();
    });
  }

  void navigateToRateRider() {
    Booking myBook = myBooking!.value!;
    Get.toNamed('/rate', arguments: myBook);
  }

  void completeBooking() => myBooking!.value = null;

  void requestComplete() {
    try {
      firestore.collection(transactionCollection).add({
        'booking_ID': myBooking!.value!.bookUID,
        'booking_distance': myBooking!.value!.bookDistance!,
        'transaction_totalFair': myBooking!.value!.bookTotal,
        'transaction_date': DateTime.now(),
      });
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void createPassengerBookingMarkers() {
    try {
      myBooking!.value!.pickup = createMarker(
          myBooking!.value!.bookPickLocation!,
          'Pick up',
          pickupMarkerIcon!.value!);

      myBooking!.value!.destination = createMarker(
          myBooking!.value!.bookDestinationLocation!,
          myBooking!.value!.bookDestinationName.value,
          BitmapDescriptor.defaultMarker);
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void attachPassengerBookingMarkers() {
    try {
      markers.value!.clear();
      if (myBooking!.value!.destination != null) {
        markers.value!.add(myBooking!.value!.destination!);
      }
      if (myBooking!.value!.bookStatus.value == 'Active' &&
          myBooking!.value!.pickup != null) {
        markers.value!.add(myBooking!.value!.pickup!);
        markers.value!.add(riderMarker!);
      }
      if (myBooking!.value!.bookStatus.value == 'Pickup') {
        markers.value!.add(riderMarker!);
      }
      markers.refresh();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void attachMarkersOfBooking() {
    try {
      if (markers.value!.isNotEmpty) {
        markers.value!.clear();
        markers.refresh();
      }
      markers.value!.add(myBooking!.value!.destination!);

      if (myBooking!.value!.bookStatus.value == 'Active' ||
          myBooking!.value!.bookStatus.value == 'Pending') {
        markers.value!.add(myBooking!.value!.pickup!);
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  Marker createMarker2(
      LatLng position, String title, BitmapDescriptor icon, Booking data) {
    return Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: title),
        icon: icon,
        onTap: () => updateBookingView(data));
  }

  void updateBookingView(Booking data) => widgetBookingView.value = data;

  void acceptBooking() => requestUpdateBooking();

  void requestUpdateBooking() {
    try {
      firestore
          .collection(bookingCollection)
          .doc(widgetBookingView.value!.bookUID)
          .update({
        "booking_riderID": auth.currentUser!.uid,
        "booking_status": "Active"
      }).then((value) => Get.back());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void processes() {
    if (myBooking!.value!.bookStatus.value == 'Active') {
      vehicleList.bindStream(streamRiderModel());
    }
    myBooking!.refresh();
  }

  //Monitor location of Rider
  Stream<List<VehicleModel>> streamRiderModel() {
    List<VehicleModel> list = [];

    Stream<QuerySnapshot> res =
        firestore.collection(vehicleCollection).snapshots();

    res.listen((p0) {
      if (p0.docs.isNotEmpty) {
        list.clear();
      }
    });

    return res.map((datas) {
      for (var document in datas.docs) {
        if (document.id == myBooking!.value!.bookRider.value) {
          if (vehicle?.value == null) {
            VehicleModel model =
                VehicleModel.getQueryDocumentSnapshot(document);
            vehicle!.value = model;
            riderMarker = createMarker(
                vehicle!.value!.riderLocation.value!,
                'My rider',
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen));
            markers.value!.add(riderMarker!);

            LatLng target = convertGeopoint(document.get('vehicle_location'));
            vehicle!.value!.riderLocation.value = target;
            buildPolyline(target, myBooking!.value!.bookPickLocation!);
            markers.refresh();
            goToPlace(myBooking!.value!.bookPickLocation!,
                dio.value!.bounds!.northeast, dio.value!.bounds!.southwest);
            break;
          }

          LatLng target = convertGeopoint(document.get('vehicle_location'));
          vehicle!.value!.riderLocation.value = target;
          riderMarker = createMarker(target, 'My rider',
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
          buildPolyline(target, myBooking!.value!.bookPickLocation!);
          break;
        }
      }

      return list.toList();
    });
  }

  //Rider module
  //initialize markers, polyline and mount
  void riderToPickupMarker() async {
    try {
      if (!(pickupMarker != null)) {
        pickupMarker = createMarker(myBooking!.value!.bookPickLocation!,
            'Pick up location', pickupMarkerIcon!.value!);
      }

      if (!(destinationMarker != null)) {
        destinationMarker = createMarker(
            myBooking!.value!.bookDestinationLocation!,
            myBooking!.value!.bookDestinationName.value,
            BitmapDescriptor.defaultMarker);
      }

      if (riderMarker != null) {
        riderMarker = null;
      }

      riderMarker = createMarker(vehicle!.value!.riderLocation.value!,
          'Rider Location', riderMarkerIcon);

      markers.value!.clear();
      markers.value!.add(destinationMarker!);
      markers.value!.add(pickupMarker!);
      markers.value!.add(riderMarker!);
      dio.value =
          await createPolyline(riderMarker!.position, pickupMarker!.position);
      mountPolyline();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  //update polylines on passenger location change
  //use after rider pickup the passenger
  void updatePolylines(loc.LocationData loc) async {
    try {
      if (myBooking?.value != null) {
        if (myBooking?.value?.bookDestinationLocation == null) {
          return;
        }

        buildPolyline(LatLng(loc.latitude!, loc.longitude!),
            myBooking!.value!.bookDestinationLocation!);

        if (dio.value == null) {
          return;
        }

        if (polylines.value != null) {
          polylines.value!.clear();
        }

        mountPolyline();
      }
    } catch (e) {
      exception.value = e.toString();
    }
  }

  //build polyline for controller default polyline rx variable
  void buildPolyline(LatLng origin, LatLng destination) async =>
      dio.value = await createPolyline(origin, destination);

  void mountPolyline() {
    polylines.value!.add(Polyline(
      polylineId: const PolylineId('overview_polyline'),
      color: Colors.deepPurple,
      width: 5,
      points: dio.value!.polylinePoints!
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
    ));
    polylines.refresh();
  }

  void moveCameraCurrentPositions(LatLngBounds bounds) {
    controller.future.then((gcontroller) =>
        gcontroller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 3)));
  }

  void goToPlace(LatLng location, LatLng boundsNe, LatLng boundsSw) async {
    final GoogleMapController con = await controller.future;
    con.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(southwest: boundsSw, northeast: boundsNe), 25),
    );
  }

  void removeMarkerAndBooking() {
    try {
      dio.value = null;
      destinationMarker = null;
      markers.value!.clear();
      polylines.value!.clear();
      myBooking!.value = null;
      polylines.refresh();
      markers.refresh();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void bookUpdateStatus() {
    if (myBooking!.value!.bookStatus.value == 'Pending') {
      myBooking!.value!.bookStatus.value = 'Active';
      requestBookingUpdate('Active');
      return;
    }
    if (myBooking!.value!.bookStatus.value == 'Active') {
      myBooking!.value!.bookStatus.value = 'Arrived';
      requestBookingUpdate('Arrived');
      return;
    }
    if (myBooking!.value!.bookStatus.value == 'Arrived') {
      myBooking!.value!.bookStatus.value = 'OnProgress';
      requestBookingUpdate('OnProgress');
      return;
    }
    if (myBooking!.value!.bookStatus.value == 'OnProgress') {
      myBooking!.value!.bookStatus.value = 'Complete';
      requestBookingUpdate('Complete');
      removeMarkerAndBooking();
      completeBooking();
      requestComplete();
      return;
    }

    myBooking!.value!.bookStatus.refresh();
  }

  void requestBookingUpdate(String status) {
    try {
      firestore
          .collection(bookingCollection)
          .doc(myBooking!.value!.bookUID)
          .update({'booking_status': status});
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void submitCancel() {
    onSubmitBooking();
    try {
      firestore.collection('Canceled_Booking').add({
        'message': 'Pending',
        'userID': auth.currentUser!.uid,
        'booking_ID': myBooking!.value!.bookUID,
      }).then((value) => {
            if (role == 1)
              {
                cancelPassenger(),
                removeMarkerAndBooking(),
                completeBooking(),
              }
            else
              {
                removeMarkerAndBooking(),
                cancelRider(),
              },
            onSubmitBooking(),
            Get.back()
          });
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void cancelRider() {
    onSubmitBooking();
    try {
      firestore
          .collection(bookingCollection)
          .doc(myBooking!.value!.bookUID)
          .update({
        'booking_status': 'Pending',
        'booking_riderID': '',
      }).then((value) => Get.back());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void cancelPassenger() {
    onSubmitBooking();
    try {
      firestore
          .collection(bookingCollection)
          .doc(myBooking!.value!.bookUID)
          .update({
        'booking_status': 'Canceled',
      }).then((value) => Get.back());
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void onSubmitBooking() => onBookCancelSubmit.toggle();

  void submitRate(double score) {
    try {
      firestore
          .collection(bookingCollection)
          .doc(myBooking!.value!.bookUID)
          .update({
        'booking_rider_message':
            rateRiderMessage.text == '' ? 'NONE' : rateRiderMessage.text,
        'booking_rider_ratings': score,
      }).then((_) {
        myBooking!.value = null;
        Get.back();
      });
    } catch (e) {
      exception.value = e.toString();
    }
  }
}
