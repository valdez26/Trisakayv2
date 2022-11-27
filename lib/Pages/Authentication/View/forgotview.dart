import 'package:trisakay/packages.dart';

class ForgotView extends GetView<AuthController> {
  const ForgotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool submitStatus = false.obs;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: SvgPicture.asset('./assets/splash.svg'),
              ),
              const SizedBox(height: 25),
              NeoMorphicForm(
                controller: controller.email,
                title: "Email",
                iconData: Icons.email,
              ),
              const SizedBox(height: 35),
              Obx(
                () => NeomorphicButton(
                    onPressed: () {
                      controller.requestEmailVerification();
                    },
                    title: submitStatus.isTrue
                        ? 'Sending recovery link'
                        : 'Submit',
                    color: submitStatus.isTrue
                        ? const Color.fromARGB(255, 147, 113, 205)
                        : Colors.deepPurple,
                    rounded: 100,
                    showChild: submitStatus.value,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
