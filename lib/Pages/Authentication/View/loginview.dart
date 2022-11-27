import 'package:trisakay/packages.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool submitStatus = false.obs;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.94,
        child: Stack(
          children: [
            Positioned.fill(
                child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                children: [
                  Flexible(
                      flex: 4,
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: Colors.deepOrange,
                                  size: 50,
                                ),
                                CustomText.widget(
                                    title: 'Tri',
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepOrange),
                                CustomText.widget(
                                    title: 'Sakay',
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.deepPurple),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 8,
                      child: SizedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Form(
                                  child: Column(
                                children: [
                                  SizedBox(
                                      width: Get.width,
                                      height: controller.onLogin.isTrue
                                          ? Get.height * 0.23
                                          : Get.height * 0.45,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 25),
                                          NeoMorphicForm(
                                            controller: controller.email,
                                            title: "Email",
                                            iconData: Icons.email,
                                          ),
                                          const SizedBox(height: 25),
                                          NeoMorphicForm(
                                              controller: controller.password,
                                              title: 'Password',
                                              iconData: Icons.lock),
                                        ],
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Get.toNamed('/forgot');
                                      },
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                  const SizedBox(height: 20),
                                  Obx(
                                    () => NeomorphicButton(
                                        onPressed: () {
                                          if (submitStatus.isFalse) {
                                            submitStatus.value = true;
                                            controller.signin();
                                            submitStatus.value = false;
                                            return;
                                          }
                                        },
                                        title: submitStatus.isTrue
                                            ? 'Signing in'
                                            : 'Login',
                                        color: submitStatus.isTrue
                                            ? const Color.fromARGB(
                                                255, 147, 113, 205)
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
                                  const SizedBox(height: 15),
                                  NeomorphicButton(
                                    onPressed: () {
                                      Get.toNamed('/register');
                                    },
                                    title: 'Sign up',
                                    color: Colors.deepOrange,
                                    rounded: 100,
                                    showChild: false,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )),
            Obx(
              () => Positioned(
                  top: 0,
                  child: controller.authException.value == ''
                      ? Container()
                      : Container(
                          width: Get.width,
                          height: 40,
                          color: Colors.red,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: Get.width * 0.8,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.error_outline_rounded,
                                            color: Colors.white),
                                        const SizedBox(width: 5),
                                        Obx(() => CustomText.widget(
                                            title: controller
                                                        .authException.value !=
                                                    ''
                                                ? controller.authException.value
                                                : '',
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500)),
                                      ],
                                    )),
                                IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () =>
                                        controller.closeErrorContainer(),
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                        )),
            )
          ],
        ),
      ),
    )));
  }
}
