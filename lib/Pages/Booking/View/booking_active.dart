import 'package:trisakay/packages.dart';

class BookingActive extends GetView<AuthController> {
  const BookingActive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.controllerHandlerClass?.bookingController?.myBooking
                  ?.value !=
              null
          ? SizedBox(
              width: Get.width,
              height: 160,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeoMorphicContainer(
                    w: Get.width,
                    h: 160,
                    rounded: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: SizedBox(
                                  width: Get.width * 0.7,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      Obx(
                                        () => CustomText.widget(
                                            title: controller
                                                        .controllerHandlerClass!
                                                        .bookingController!
                                                        .myBooking!
                                                        .value!
                                                        .bookDestinationName
                                                        .value
                                                        .length >
                                                    13
                                                ? "${controller.controllerHandlerClass!.bookingController!.myBooking!.value?.bookDestinationName.value.substring(0, 10)} .."
                                                : controller
                                                    .controllerHandlerClass!
                                                    .bookingController!
                                                    .myBooking!
                                                    .value!
                                                    .bookDestinationName
                                                    .value,
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 2,
                                  child: Obx(
                                    () => CustomText.widget(
                                        title:
                                            'FAIR : ${controller.controllerHandlerClass!.bookingController?.myBooking!.value?.estimatedFair ?? 'P 0.00'}',
                                        fontSize: 15,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
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
                                    title:
                                        'Initial : ${PriceClass().priceFormat(controller.controllerHandlerClass!.rateController!.rate.value!.baseRate!)}',
                                    color: Colors.grey.shade700,
                                    fontSize: 11),
                                CustomText.widget(
                                    title:
                                        'Rate/km : ${PriceClass().priceFormat(controller.controllerHandlerClass!.rateController!.rate.value!.rate!)}',
                                    color: Colors.grey.shade700,
                                    fontSize: 11),
                              ]),
                          const SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 120,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
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
                                Container(
                                  width: 150,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: MaterialButton(
                                      onPressed: () {
                                        controller.controllerHandlerClass!
                                            .bookingController!
                                            .bookUpdateStatus();
                                      },
                                      child: Obx(
                                        () => CustomText.widget(
                                            title: controller
                                                        .controllerHandlerClass!
                                                        .bookingController!
                                                        .myBooking!
                                                        .value!
                                                        .bookStatus
                                                        .value ==
                                                    'Pending'
                                                ? "ACCEPT BOOK"
                                                : controller
                                                            .controllerHandlerClass!
                                                            .bookingController!
                                                            .myBooking!
                                                            .value!
                                                            .bookStatus
                                                            .value ==
                                                        'Active'
                                                    ? 'NOTIFY PASSENGER'
                                                    : controller
                                                                .controllerHandlerClass!
                                                                .bookingController!
                                                                .myBooking!
                                                                .value!
                                                                .bookStatus
                                                                .value ==
                                                            'Arrived'
                                                        ? "Pickup"
                                                        : controller
                                                                    .controllerHandlerClass!
                                                                    .bookingController!
                                                                    .myBooking!
                                                                    .value!
                                                                    .bookStatus
                                                                    .value ==
                                                                'OnProgress'
                                                            ? 'Drop passenger'
                                                            : 'Complete',
                                            color: Colors.grey.shade200,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  )))
          : SizedBox(
              width: Get.width,
              height: 120,
              child: NeoMorphicContainer(
                  w: Get.width,
                  h: 120,
                  color: Colors.white,
                  rounded: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey),
                            CustomText.widget(
                                title: 'No Booking',
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)
                          ],
                        ),
                        const SizedBox(height: 20),
                        NeomorphicButton(
                          w: Get.width * 0.75,
                          h: 40,
                          showChild: false,
                          onPressed: () {
                            controller
                                .controllerHandlerClass!.bookingController!
                                .attachBookListMarker();
                            Get.toNamed('/searchbook');
                          },
                          title: 'View booking',
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
