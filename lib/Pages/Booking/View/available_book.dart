import 'package:trisakay/packages.dart';

class AvailableBook extends GetView<AuthController> {
  const AvailableBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: GoogleMap(
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    markers: controller.controllerHandlerClass!
                        .bookingController!.markersAvailableBooking.value!,
                    initialCameraPosition: controller.controllerHandlerClass!
                        .bookingController!.initialGooglePlex,
                    onCameraMove: ((position) => {
                          controller.controllerHandlerClass!.mapController!
                              .initLocation(position)
                        }),
                  ),
                ),
              ),
              Positioned(
                  child: Container(
                width: Get.width,
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.deepPurple,
                        )),
                    const SizedBox(width: 15),
                    CustomText.widget(
                        title: 'Available Booking',
                        fontSize: 17,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w700),
                  ],
                ),
              )),
              Positioned(
                  bottom: 0,
                  child: Obx(() => controller.controllerHandlerClass!
                              .bookingController!.widgetBookingView.value !=
                          null
                      ? SizedBox(
                          width: Get.width,
                          height: 140,
                          child: NeoMorphicContainer(
                            w: Get.width,
                            h: 140,
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Flexible(
                                        flex: 2,
                                        child: SizedBox(
                                            width: Get.width,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: Get.width * 0.5,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                            Icons.location_pin,
                                                            color: Colors.red,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          CustomText.widget(
                                                              title: controller
                                                                      .controllerHandlerClass!
                                                                      .bookingController
                                                                      ?.widgetBookingView
                                                                      .value
                                                                      ?.bookDestinationName
                                                                      .value ??
                                                                  'Destination',
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 12),
                                                        ]),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: Get.width * 0.5,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                            Icons.location_pin,
                                                            color: Colors
                                                                .deepPurple,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          CustomText.widget(
                                                              title: controller
                                                                      .controllerHandlerClass!
                                                                      .bookingController
                                                                      ?.widgetBookingView
                                                                      .value
                                                                      ?.bookPickupName
                                                                      .value ??
                                                                  'Pickup',
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 12),
                                                        ]),
                                                  ),
                                                ),
                                              ],
                                            ))),
                                    const Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText.widget(
                                              title:
                                                  'DISTANCE : ${controller.controllerHandlerClass!.bookingController?.widgetBookingView.value?.bookDistance ?? 0} ',
                                              color: Colors.grey.shade700,
                                              fontSize: 11),
                                          CustomText.widget(
                                              title: 'Initial : P20.00',
                                              color: Colors.grey.shade700,
                                              fontSize: 11),
                                          CustomText.widget(
                                              title: 'Rate/km : P8.00',
                                              color: Colors.grey.shade700,
                                              fontSize: 11),
                                        ]),
                                    const SizedBox(height: 25),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText.widget(
                                                title:
                                                    'TOTAL FAIR : ${controller.controllerHandlerClass!.bookingController?.widgetBookingView.value?.estimatedFair ?? 0}',
                                                fontSize: 14,
                                                color: Colors.grey.shade800,
                                                fontWeight: FontWeight.w500),
                                            Container(
                                              width: 130,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: MaterialButton(
                                                  onPressed: () {
                                                    controller
                                                        .controllerHandlerClass!
                                                        .bookingController!
                                                        .acceptBooking();
                                                  },
                                                  child: CustomText.widget(
                                                      title: 'ACCEPT BOOK',
                                                      color:
                                                          Colors.grey.shade200,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ]),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      : Container()))
            ],
          ),
        ),
      ),
    );
  }
}
