import 'package:trisakay/packages.dart';

class RateModel {
  double? baseRate;
  double? rate;

  RateModel();

  RateModel.getDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    baseRate = double.parse(documentSnapshot.get('base_rate').toString());
    rate = double.parse(documentSnapshot.get('add_rate').toString());
  }
}
