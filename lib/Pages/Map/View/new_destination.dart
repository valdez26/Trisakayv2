import 'package:trisakay/packages.dart';

class NewDestination extends GetView<AuthController> {
  const NewDestination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: Obx(
                  () => GoogleMap(
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: controller.controllerHandlerClass!
                        .mapController!.initialGooglePlex,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    markers: controller
                        .controllerHandlerClass!.mapController!.markers.value!,
                    polylines: controller.controllerHandlerClass!.mapController!
                        .polylines.value!,
                    onMapCreated: (GoogleMapController gmapController) {
                      controller
                          .controllerHandlerClass!.mapController!.controller
                          .complete(gmapController);
                    },
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: SizedBox(
                  width: Get.width,
                  height: 90,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                          spreadRadius: 1)
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 15, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(95, 103, 58, 183),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.deepPurple,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 20,
                                  height: 18,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 3,
                                        height: 2,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1000)),
                                            color: Colors.grey),
                                      ),
                                      Container(
                                        width: 3,
                                        height: 2,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1000)),
                                            color: Colors.grey),
                                      ),
                                      Container(
                                        width: 3,
                                        height: 2,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1000)),
                                            color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.red,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: TextFormField(
                                      controller: controller
                                          .controllerHandlerClass!
                                          .mapController!
                                          .pickup,
                                      readOnly: true,
                                      onTap: () {
                                        controller
                                            .controllerHandlerClass!
                                            .mapController!
                                            .isDestination
                                            .value = false;
                                        controller.controllerHandlerClass!
                                            .mapController!.isDestination
                                            .refresh();
                                        Get.toNamed('/createmarker');
                                      },
                                      decoration: InputDecoration(
                                          hintText: controller
                                                      .controllerHandlerClass!
                                                      .mapController!
                                                      .initialBooking
                                                      .value!
                                                      .bookPickLocation ==
                                                  null
                                              ? 'My location'
                                              : controller
                                                  .controllerHandlerClass!
                                                  .mapController!
                                                  .initialBooking
                                                  .value!
                                                  .bookPickupName
                                                  .value,
                                          border: InputBorder.none),
                                    )),
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: TextFormField(
                                      controller: controller
                                          .controllerHandlerClass!
                                          .mapController!
                                          .destination,
                                      readOnly: true,
                                      onTap: () {
                                        controller
                                            .controllerHandlerClass!
                                            .mapController!
                                            .isDestination
                                            .value = true;
                                        controller.controllerHandlerClass!
                                            .mapController!.isDestination
                                            .refresh();
                                        Get.toNamed('/createmarker');
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.only(
                                                  bottom: 10),
                                          hintText: 'Destination',
                                          border: InputBorder.none),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Positioned(
                top: 120,
                child: Obx(() => controller
                            .controllerHandlerClass!.mapController!.dio.value !=
                        null
                    ? SizedBox(
                        width: Get.width,
                        height: 150,
                        child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: NeoMorphicContainer(
                                    w: Get.width,
                                    h: 150,
                                    rounded: 10,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText.widget(
                                              title:
                                                  'DESTINATION : ${controller.controllerHandlerClass!.mapController!.initialBooking.value!.bookDestinationName}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          CustomText.widget(
                                              title:
                                                  'PICKUP : ${controller.controllerHandlerClass!.mapController!.initialBooking.value!.bookPickupName.value != '' ? controller.controllerHandlerClass!.mapController!.initialBooking.value!.bookPickupName.value : controller.controllerHandlerClass!.mapController!.initialBooking.value!.bookMyLocationName.value}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          CustomText.widget(
                                              title:
                                                  'DISTANCE : ${controller.controllerHandlerClass!.mapController!.initialBooking.value!.bookDistance} ',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          CustomText.widget(
                                              title:
                                                  'TOTAL PAYMENT : ${controller.controllerHandlerClass!.mapController!.initialBooking.value!.retrieveFair()}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Container(
                                      width: 100,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepOrange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                      child: MaterialButton(
                                        color: Colors.deepOrange,
                                        onPressed: () {
                                          controller.controllerHandlerClass!
                                              .mapController!
                                              .removeMarkerAndBooking();
                                        },
                                        child: CustomText.widget(
                                            title: 'RESET',
                                            color: Colors.white),
                                      ),
                                    )),
                              ],
                            )),
                      )
                    : Container())),
            Positioned(
                bottom: 10,
                child: SizedBox(
                    width: Get.width,
                    height: 50,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              color: Colors.grey,
                              onPressed: () {
                                controller
                                    .controllerHandlerClass!.mapController!
                                    .removeMarkerAndBooking();
                                Get.back();
                              },
                              child: CustomText.widget(
                                  title: 'Cancel',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            MaterialButton(
                              color: Colors.deepPurple,
                              onPressed: () {
                                controller
                                    .controllerHandlerClass!.mapController!
                                    .submitBooking();
                              },
                              child: CustomText.widget(
                                  title: 'Submit Booking',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ))))
          ],
        ),
      )),
    );
  }
}
