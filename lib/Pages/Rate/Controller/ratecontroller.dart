import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';

class RateController extends GetxController {
  Rxn<RateModel?> rate = Rxn<RateModel>(null).obs();

  @override
  void onInit() {
    super.onInit();
    initializedRate();
  }

  void initializedRate() async {
    rate.value = RateModel.getDocumentSnapshot(await requestRate());
  }

  Future<DocumentSnapshot> requestRate() async {
    return await firestore
        .collection('Rate_Collection')
        .doc('T2D4mdZNRlDIKR075QWJ')
        .get();
  }
}
