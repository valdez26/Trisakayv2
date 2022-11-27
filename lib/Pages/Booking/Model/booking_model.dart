import 'package:trisakay/packages.dart';

class Booking {
  String? bookUID;
  RxString bookPickupName = 'Fetching'.obs;
  RxString bookDestinationName = 'Fetching'.obs;
  LatLng? bookPickLocation;
  LatLng? bookDestinationLocation;
  DateTime? bookDate;
  String? bookDistance;
  String? bookDuration;
  double? bookTotal;
  RxString bookStatus = ''.obs;

  RxString bookRider = ''.obs;

  RxString exception = ''.obs;

  Marker? pickup;
  Marker? destination;

  //Cancelled
  //Pending
  //Active
  //Arrived
  //Pickup
  //OnProgress
  //Complete

  Booking();

  /// [Booking.getDocumentSnapshot] Custom constructor to recieve a future document
  /// from firestore
  Booking.getDocumentSnapshot(DocumentSnapshot document) {
    try {
      bookPickLocation = convertGeopoint(document.get('booking_pickup'));
      bookDestinationLocation =
          convertGeopoint(document.get('booking_destination'));
      initializeLocationName();
      bookUID = document.id;
      bookRider.value = document.get('booking_riderID');
      bookRider.refresh();
      bookDistance = document.get('booking_distance');
      bookDuration = document.get('booking_duration');
      bookTotal = document.get('booking_total');
      bookStatus.value = document.get('booking_status');
      bookDate = convertTS(document.get('booking_date'));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  /// [Booking.getQueryDocumentSnapshot] Custom constructor to recieve a stream of document
  /// [Stream] continious listening for update of document in firestore.
  Booking.getQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    try {
      bookPickLocation = convertGeopoint(document.get('booking_pickup'));
      bookDestinationLocation =
          convertGeopoint(document.get('booking_destination'));
      initializeLocationName();
      bookUID = document.id;
      bookRider.value = document.get('booking_riderID');
      bookRider.refresh();
      bookDistance = document.get('booking_distance');
      bookDuration = document.get('booking_duration');
      bookTotal = double.parse(document.get('booking_total'));
      bookStatus.value = document.get('booking_status');
      bookDate = convertTS(document.get('booking_date'));
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void initializeLocationName() async {
    bookDestinationName.value = await getLocationName(bookDestinationLocation!);
    bookPickupName.value = await getLocationName(bookPickLocation!);
  }

  DateTime convertTS(Timestamp ts) => ts.toDate();

  Future<String> getLocationName(LatLng location) async =>
      await retrieveName(location);

  String get estimatedFair => PriceClass().priceFormat(bookTotal ?? 0);
  String get dName => bookDestinationName.value.length > 13
      ? "${bookDestinationName.value.substring(0, 10)} .."
      : bookDestinationName.value;
}
