import 'package:trisakay/main.dart';
import 'package:trisakay/packages.dart';

class AccountView extends GetView<AuthController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.initializedTextControllers();
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned.fill(
              top: 40,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height * 0.85,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: Get.width,
                            height: Get.height * 0.79,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email_rounded,
                                      color: Colors.deepPurple,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomText.widget(
                                        title: auth.currentUser!.email!,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                const SizedBox(height: 25),
                                CustomTextForm.widget(
                                    controller: controller.firstname,
                                    textInputType: TextInputType.text,
                                    icon: Icons.person,
                                    isHint: false,
                                    hasBorder: true,
                                    label: 'First Name'),
                                const SizedBox(height: 20),
                                CustomTextForm.widget(
                                    controller: controller.lastname,
                                    textInputType: TextInputType.text,
                                    icon: Icons.person,
                                    isHint: false,
                                    hasBorder: true,
                                    label: 'Last Name'),
                                const SizedBox(height: 20),
                                CustomTextForm.widget(
                                    controller: controller.contact,
                                    textInputType: TextInputType.text,
                                    icon: Icons.phone_android_rounded,
                                    isHint: false,
                                    hasBorder: true,
                                    label: 'Contact'),
                                const SizedBox(height: 15),
                                CustomTextForm.widget(
                                    controller: controller.address,
                                    textInputType: TextInputType.text,
                                    icon: Icons.location_city,
                                    isHint: false,
                                    hasBorder: true,
                                    label: 'Address'),
                                const SizedBox(height: 15),
                                MaterialButton(
                                  minWidth: Get.width,
                                  color: Colors.deepPurple,
                                  onPressed: () async {
                                    controller.updateAccountStatus.value =
                                        await controller.putUserData();
                                  },
                                  child: CustomText.widget(
                                      title: 'Update Account',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 30),
                                CustomTextForm.widget(
                                    controller: controller.password,
                                    textInputType: TextInputType.text,
                                    icon: Icons.lock,
                                    isHint: false,
                                    hasBorder: true,
                                    label: 'New password'),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: MaterialButton(
                                        minWidth: Get.width * 0.4,
                                        color: Colors.deepOrange,
                                        onPressed: () async {
                                          controller.updateAccountStatus.value =
                                              await controller
                                                  .sendEmailVerifaction();
                                        },
                                        child: CustomText.widget(
                                            title: 'Send to Email',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: MaterialButton(
                                          minWidth: Get.width * 0.45,
                                          color: Colors.deepPurple,
                                          onPressed: () async {
                                            controller
                                                    .updateAccountStatus.value =
                                                await controller.putUserData();
                                          },
                                          child: CustomText.widget(
                                              title: 'Update Password',
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: HeaderWidget(
                  onPressed: (() {
                    Get.back();
                    controller.updateAccountStatus.value = false;
                  }),
                  pageTitle: 'Account',
                )),
            Positioned(
                top: 50,
                child: Obx(
                  () => controller.updateAccountStatus.isTrue
                      ? Container(
                          width: Get.width,
                          height: 40,
                          decoration: const BoxDecoration(color: Colors.green),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline_rounded,
                                  color: Colors.white),
                              const SizedBox(width: 10),
                              CustomText.widget(
                                  title: controller
                                      .updateAccountStatusMessage.value,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)
                            ],
                          ),
                        )
                      : Container(),
                ))
          ],
        ),
      )),
    );
  }
}
