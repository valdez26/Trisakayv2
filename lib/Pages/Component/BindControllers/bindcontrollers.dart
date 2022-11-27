import 'package:trisakay/Pages/Home/Controller/homecontroller.dart';
import 'package:trisakay/packages.dart';

class BindControllers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<BookingController>(() => BookingController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MapControllers>(() => MapControllers());
    Get.lazyPut<RateController>(() => RateController());
  }
}
