import 'package:trisakay/packages.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateRider extends GetView<AuthController> {
  const RateRider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Booking myBooking = Get.arguments;
    RxDouble rate = 1.0.obs;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Positioned.fill(
                    top: 50,
                    child: SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            CustomText.widget(
                                title: 'RATE RIDER', fontSize: 16),
                            const SizedBox(height: 10),
                            Obx(
                              () => RatingBar.builder(
                                initialRating: rate.value,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  rate.value = rating;
                                },
                              ),
                            ),
                            const SizedBox(height: 60),
                            NeomorphicTextField(
                              w: Get.width * 0.8,
                              h: 200,
                              r: 10,
                              title: "Message (Optional)",
                              maxLine: 20,
                              controller: controller.controllerHandlerClass!
                                  .bookingController!.rateRiderMessage,
                            ),
                          ],
                        ))),
                Positioned(
                    top: 0,
                    child: Container(
                        width: Get.width,
                        height: 50,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              IconButton(
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back_rounded,
                                      color: Colors.deepPurple))
                            ],
                          ),
                        ))),
                Positioned(
                    bottom: 40,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeomorphicButton(
                              w: 140,
                              h: 35,
                              showChild: false,
                              title: 'Cancel',
                              color: Colors.grey,
                              onPressed: () {
                                Get.back();
                              }),
                          const SizedBox(width: 10),
                          NeomorphicButton(
                              w: 140,
                              h: 35,
                              showChild: false,
                              title: 'Submit',
                              onPressed: () {
                                controller
                                    .controllerHandlerClass!.bookingController!
                                    .submitRate(rate.value);
                              }),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
