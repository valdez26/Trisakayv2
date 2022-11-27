import 'package:trisakay/packages.dart';

class HomeView extends GetView<AuthController> {
  const HomeView({Key? key}) : super(key: key);

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
                          .bookingController!.initialGooglePlex,
                      markers: controller.controllerHandlerClass!
                          .bookingController!.markers.value!,
                      polylines: controller.controllerHandlerClass!
                          .bookingController!.polylines.value!,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      buildingsEnabled: false,
                      onMapCreated: (GoogleMapController gmapController) {
                        controller.controllerHandlerClass!.bookingController!
                            .controller
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
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 35,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: IconButton(
                                onPressed: () {
                                  Get.toNamed('/menu');
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.deepPurple,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            height: 40,
                            child: Row(
                              children: [
                                CustomText.widget(
                                    title: 'Tri',
                                    color: Colors.deepOrange,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                CustomText.widget(
                                    title: 'Sakay',
                                    color: Colors.deepPurple,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.deepPurple,
                                  size: 35,
                                )
                              ],
                            ),
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  )),
              // Obx(
              //   () => Positioned(
              //       top: 70,
              //       child: controller.controllerHandlerClass!.bookingController!
              //                   .rider?.value !=
              //               null
              //           ? SizedBox(
              //               width: Get.width,
              //               height: 50,
              //               child: Padding(
              //                 padding: const EdgeInsets.only(
              //                     left: 15.0, right: 15.0),
              //                 child: Container(
              //                   width: Get.width,
              //                   height: 40,
              //                   decoration: const BoxDecoration(
              //                       color: Colors.white,
              //                       boxShadow: [
              //                         BoxShadow(
              //                             color: Colors.black12,
              //                             blurRadius: 1,
              //                             spreadRadius: 1),
              //                       ],
              //                       borderRadius:
              //                           BorderRadius.all(Radius.circular(100))),
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(5.0),
              //                     child: Row(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         SizedBox(
              //                           width: 200,
              //                           child: Row(
              //                             children: [
              //                               CircleAvatar(
              //                                 child: CustomText.widget(
              //                                     title: controller
              //                                             .controllerHandlerClass!
              //                                             .bookingController!
              //                                             .rider
              //                                             ?.value
              //                                             ?.riderName?[0] ??
              //                                         ''),
              //                               ),
              //                               const SizedBox(width: 10),
              //                               SizedBox(
              //                                 width: 150,
              //                                 child: Column(
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.start,
              //                                   children: [
              //                                     CustomText.widget(
              //                                       title: controller
              //                                               .controllerHandlerClass!
              //                                               .bookingController!
              //                                               .rider
              //                                               ?.value
              //                                               ?.riderName ??
              //                                           'Unknown',
              //                                       fontSize: 14,
              //                                     ),
              //                                     CustomText.widget(
              //                                         title:
              //                                             'Contact: ${controller.controllerHandlerClass!.bookingController!.rider?.value!.riderContact! ?? 'Unknown'}'),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             )
              //           : Container()),
              // ),
              Positioned(
                  bottom: 0,
                  child: controller.user.userRole == 1
                      ? const BookingPassenger()
                      : const BookingActive())
            ],
          ),
        )));
  }
}
