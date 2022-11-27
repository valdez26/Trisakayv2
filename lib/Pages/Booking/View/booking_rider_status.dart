import 'package:trisakay/packages.dart';

class BookingRirderStatus extends GetView<AuthController> {
  const BookingRirderStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => status(controller.controllerHandlerClass!
                .bookingController!.myBooking!.value!.bookStatus.value ==
            'Pending'
        ? 'Waiting for Rider'
        : controller.controllerHandlerClass!.bookingController!.myBooking!
                    .value!.bookStatus.value ==
                'Active'
            ? 'Rider on its way'
            : controller.controllerHandlerClass!.bookingController!.myBooking!
                        .value!.bookStatus.value ==
                    'Arrived'
                ? 'Rider is Waiting'
                : controller.controllerHandlerClass!.bookingController!
                            .myBooking!.value!.bookStatus.value ==
                        'OnProgress'
                    ? 'To Destination'
                    : controller.controllerHandlerClass!.bookingController!
                                .myBooking!.value!.bookStatus.value ==
                            'Complete'
                        ? 'Arrived at Destination'
                        : 'Please Wait'));
  }

  Widget status(String title) {
    return CustomText.widget(title: title, color: Colors.white, fontSize: 11);
  }
}
