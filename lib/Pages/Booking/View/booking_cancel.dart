import 'package:trisakay/packages.dart';

class BookingCancel extends GetView<AuthController> {
  const BookingCancel({Key? key}) : super(key: key);

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
                top: 60,
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: Row(
                            children: [
                              CustomText.widget(
                                  title: 'Book ID: ',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              const SizedBox(width: 5),
                              Container(
                                width: 200,
                                height: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText.widget(
                                title: 'WARNING :',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText.widget(
                                title:
                                    'Multiple cancelation of booking without valid reason may result of block of account.',
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        NeomorphicTextField(
                          controller: controller.controllerHandlerClass!
                              .bookingController!.cancelReason,
                          title: 'Reason for cancel',
                          w: Get.width,
                          h: 200,
                          r: 10,
                          maxLine: 10,
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
                child: SizedBox(
              width: Get.width,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.deepPurple,
                        )),
                    const SizedBox(width: 20),
                    CustomText.widget(
                        title: 'Cancel Booking',
                        fontSize: 16,
                        fontWeight: FontWeight.w600)
                  ],
                ),
              ),
            )),
            Positioned(
                bottom: 20,
                child: SizedBox(
                  width: Get.width,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Obx(
                      () => NeomorphicButton(
                        showChild: controller.controllerHandlerClass!
                            .bookingController!.onBookCancelSubmit.value,
                        onPressed: (() {
                          controller.controllerHandlerClass!.bookingController!
                              .submitCancel();
                        }),
                        title: controller.controllerHandlerClass!
                                .bookingController!.onBookCancelSubmit.isTrue
                            ? 'Submiting'
                            : 'Submit',
                        color: controller.controllerHandlerClass!
                                .bookingController!.onBookCancelSubmit.isTrue
                            ? const Color.fromARGB(255, 147, 113, 205)
                            : Colors.deepPurple,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
