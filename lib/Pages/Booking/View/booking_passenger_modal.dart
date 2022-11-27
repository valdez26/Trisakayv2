import 'package:trisakay/Pages/Booking/View/booking_rider_status.dart';
import 'package:trisakay/packages.dart';

class BookingPassenger extends GetView<AuthController> {
  const BookingPassenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.controllerHandlerClass!.bookingController?.myBooking
                  ?.value ==
              null
          ? Container(
              width: Get.width,
              height: 80,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.8,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          Get.toNamed('/newdestination');
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Destination',
                            prefixIcon: Icon(
                              Icons.location_pin,
                              color: Colors.grey,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )
          : controller
                  .controllerHandlerClass!.bookingController!.isComplete.isTrue
              ? completeStatus()
              : riderStatus(),
    );
  }

  Widget completeStatus() {
    return SizedBox(
      width: Get.width,
      height: 220,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: NeoMorphicContainer(
          w: Get.width,
          h: 200,
          rounded: 10,
          color: Colors.white,
          child: Column(
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 70,
              ),
              CustomText.widget(
                  title: 'Arrived at Destination',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              const Divider(endIndent: 10, indent: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomText.widget(
                      title: 'TOTAL :',
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                  const SizedBox(width: 10),
                  CustomText.widget(
                      title: controller.controllerHandlerClass!
                          .bookingController!.myBooking!.value!.estimatedFair,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ]),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeomorphicButton(
                        w: 150,
                        h: 35,
                        showChild: false,
                        onPressed: () {
                          controller.controllerHandlerClass!.bookingController!
                              .navigateToRateRider();
                        },
                        color: Colors.deepOrange,
                        title: 'Rate Rider'),
                    NeomorphicButton(
                        w: 150,
                        h: 35,
                        showChild: false,
                        onPressed: () {
                          controller.controllerHandlerClass!.bookingController!
                              .completeBooking();
                        },
                        title: 'Close'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget riderStatus() {
    return SizedBox(
      width: Get.width,
      height: 160,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoMorphicContainer(
            w: Get.width,
            h: 100,
            rounded: 10,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 2,
                            child: SizedBox(
                              width: Get.width,
                              height: 30,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 5),
                                    CustomText.widget(
                                        title: controller
                                                .controllerHandlerClass!
                                                .bookingController
                                                ?.myBooking!
                                                .value
                                                ?.dName ??
                                            'Unknown',
                                        color: Colors.grey.shade700,
                                        fontSize: 12),
                                  ]),
                            )),
                        Flexible(
                            flex: 3,
                            child: Container(
                              width: Get.width,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const BookingRirderStatus(),
                                      const SizedBox(width: 10),
                                      Obx(
                                        () => controller
                                                    .controllerHandlerClass!
                                                    .bookingController
                                                    ?.myBooking!
                                                    .value
                                                    ?.bookRider
                                                    .value !=
                                                ''
                                            ? const Icon(
                                                Icons.directions_bike_rounded,
                                                color: Colors.white,
                                              )
                                            : SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.grey.shade400,
                                                    strokeWidth: 1,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ]),
                              ),
                            )),
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText.widget(
                            title:
                                'DISTANCE : ${controller.controllerHandlerClass!.bookingController?.myBooking!.value?.bookDistance ?? 0} ',
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          height: 28,
                          decoration: const BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: MaterialButton(
                            onPressed: () {
                              Get.toNamed('/cancel');
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.grey.shade200,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                CustomText.widget(
                                    title: 'CANCEL',
                                    color: Colors.grey.shade200,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => CustomText.widget(
                              title:
                                  'TOTAL FAIR : ${controller.controllerHandlerClass!.bookingController?.myBooking!.value?.estimatedFair ?? 0}',
                              fontSize: 14,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                ],
              ),
            ),
          )),
    );
  }
}
