import 'package:trisakay/packages.dart';

class HistoryModel {
  String? historyID;
  DateTime? historyDate;
  String? historyDistance;
  LatLng? historyDestination;
  LatLng? historyPickup;
  String? historyDestinationName;
  String? historyPickupName;
  double? historyTotal;
  RxString exception = ''.obs;

  HistoryModel();

  HistoryModel.getDocumentSnapshot(DocumentSnapshot document) {
    try {
      historyID = document.id;
      historyDate = getDate(document.get('booking_date'));
      historyDistance = document.get('booking_distance');
      historyTotal = double.parse(document.get('booking_total'));
      historyDestination = convertGeopoint(document.get('booking_destination'));
      historyPickup = convertGeopoint(document.get('booking_pickup'));
      initializeLocation();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  HistoryModel.getQueryDocumentSnapshot(QueryDocumentSnapshot document) {
    try {
      historyID = document.id;
      historyDate = getDate(document.get('booking_date'));
      historyDistance = document.get('booking_distance');
      historyTotal = double.parse(document.get('booking_total'));
      historyDestination = convertGeopoint(document.get('booking_destination'));
      historyPickup = convertGeopoint(document.get('booking_pickup'));
      initializeLocation();
    } catch (e) {
      exception.value = e.toString();
    }
  }

  void initializeLocation() async {
    historyDestinationName = await retrieveName(historyDestination!);
    historyPickupName = await retrieveName(historyPickup!);
  }

  DateTime getDate(Timestamp ts) => ts.toDate();

  String get date =>
      DateFormatClass.getDateTime(historyDate!).getDateWithFormat();
  String get fair => PriceClass().priceFormat(historyTotal!);
}
