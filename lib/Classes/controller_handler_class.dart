import 'package:trisakay/packages.dart';

class ControllerHandlerClass {
  /*
    * [mapController] handle any maps functions, variables and state.
    * [bookingController] handle booking functions, variables and state.
    * [historyController] handle history transaction functions, variable and state.
    * [exception] store error message in exception value and AuthController can view what error it has
  */
  MapControllers? mapController;
  BookingController? bookingController;
  HistoryController? historyController;
  RateController? rateController;
  RxString exception = ''.obs;

  ControllerHandlerClass(bool isLogin) {
    /**
     * [ControllerHandlerClass] handles controller initialization and disposing
     * [initializeControllers] will be called when user login
     * [destroyControllers] will be called when user logout
     */

    if (isLogin) {
      initializeControllers();
    }
  }

  void initializeControllers() {
    try {
      Duration duration = const Duration(milliseconds: 2000);
      bookingController = Get.put(BookingController());
      mapController = Get.put(MapControllers());
      rateController = Get.put(RateController());
      historyController = Get.put(HistoryController());

      /**
       * Delay process to loader will be avaible to render
       * Preventing improper rendering of page.
      */
      Future.delayed(duration, () => navigateToHome());
    } catch (e) {
      /**
       *  [e] Error related to initialization of controllers
       */
      exception.value = e.toString();
    }
  }

  void navigateToHome() => Get.toNamed('/home');

  bool destroyControllers() {
    try {
      if (mapController != null) {
        mapController!.dispose();
      }
      if (bookingController != null) {
        bookingController!.dispose();
      }
      if (historyController != null) {
        historyController!.dispose();
      }
      return true;
    } catch (e) {
      /**
       *  [e] Error related to disposing controllers
       */
      exception.value = e.toString();
    }
    return false;
  }
}
