import 'package:trisakay/Pages/Component/Widgets/Neomorphic/neomorphic_selection.dart';
import 'package:trisakay/packages.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);

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
                      flex: 2,
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
                      flex: 5,
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
                                      height: Get.height * 0.4,
                                      child: Column(
                                        children: [
                                          NeoMorphicSelection(
                                            w: Get.width,
                                            h: 50,
                                            r: 6,
                                            title: 'Account Type',
                                            list: controller.userRole,
                                            onChange: ((value) {
                                              controller.userRoleSelected
                                                  .value = value;
                                              controller.userRoleSelected
                                                  .refresh();
                                            }),
                                          ),
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
                                          const SizedBox(height: 25),
                                          NeoMorphicForm(
                                              controller:
                                                  controller.confirmPassword,
                                              title: 'Confirm password',
                                              iconData: Icons.lock)
                                        ],
                                      )),
                                  const SizedBox(height: 25),
                                  Obx(
                                    () => NeomorphicButton(
                                        onPressed: () async {
                                          if (submitStatus.isFalse) {
                                            submitStatus.value = true;
                                            await controller.signup();
                                            Get.toNamed('userinfo');
                                            submitStatus.value = false;
                                          }
                                        },
                                        title: submitStatus.isTrue
                                            ? 'Submiting..'
                                            : 'Submit',
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
                                      Get.back();
                                    },
                                    title: "Signin",
                                    color: Colors.deepOrange,
                                    rounded: 100,
                                    showChild: false,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                      )),
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
