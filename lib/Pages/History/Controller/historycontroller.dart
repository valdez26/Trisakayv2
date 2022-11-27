import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';

class HistoryController extends GetxController {
  RxList<HistoryModel> historyRecord = RxList<HistoryModel>().obs();
  AuthController? controller;

  @override
  void onInit() {
    super.onInit();
    controller = Get.find<AuthController>();
  }

  @override
  void onReady() {
    super.onReady();
    bindStream();
  }

  void bindStream() {
    historyRecord.bindStream(stream(controller!.user.userRole == 1
        ? 'booking_passengerID'
        : 'booking_riderID'));
  }

  Stream<List<HistoryModel>> stream(String condition) {
    List<HistoryModel> list = [];

    Stream<QuerySnapshot> datas = firestore
        .collection(bookingCollection)
        .where(condition, isEqualTo: auth.currentUser!.uid)
        .where('booking_status', isEqualTo: "Complete")
        .snapshots();

    datas.listen((event) {
      if (event.docs.isNotEmpty) {
        list.clear();
      }
    });

    return datas.map((event) {
      for (var element in event.docs) {
        list.add(HistoryModel.getQueryDocumentSnapshot(element));
      }
      return list.toList();
    });
  }
}
