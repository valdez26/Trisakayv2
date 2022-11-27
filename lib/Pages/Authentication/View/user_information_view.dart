import 'package:trisakay/packages.dart';

class UserInformation extends GetView<AuthController> {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool submitStatus = false.obs;
    RxBool openBottomSheet = false.obs;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        height: Get.height * 0.956,
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
                        child: Center(
                          child: SizedBox(
                            width: 220,
                            height: 140,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                    child: Obx(() => CircleAvatar(
                                        minRadius: 60,
                                        foregroundImage: controller
                                                    .photoFile?.value ==
                                                null
                                            ? null
                                            : FileImage(
                                                controller.photoFile!.value!),
                                        child:
                                            controller.photoFile?.value == null
                                                ? CustomText.widget(
                                                    title: 'T',
                                                    color: Colors.white,
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w600)
                                                : Container()))),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                        splashColor: Colors.transparent,
                                        onPressed: () async {
                                          openBottomSheet.toggle();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.black26,
                                          size: 30,
                                        )))
                              ],
                            ),
                          ),
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
                                  const SizedBox(height: 20),
                                  Obx(
                                    () => SizedBox(
                                        width: Get.width,
                                        height:
                                            controller.userRoleSelected.value ==
                                                    'Passenger'
                                                ? Get.height * 0.4
                                                : Get.height * 0.45,
                                        child: Column(
                                          children: [
                                            NeoMorphicForm(
                                              controller: controller.firstname,
                                              title: "First name",
                                              iconData: Icons.person,
                                            ),
                                            const SizedBox(height: 25),
                                            NeoMorphicForm(
                                              controller: controller.lastname,
                                              title: "Last name",
                                              iconData: Icons.person,
                                            ),
                                            const SizedBox(height: 25),
                                            NeoMorphicForm(
                                                controller: controller.contact,
                                                title: 'Contact',
                                                iconData: Icons
                                                    .phone_android_rounded),
                                            const SizedBox(height: 25),
                                            NeoMorphicForm(
                                                controller: controller.address,
                                                title: 'Address',
                                                iconData: Icons.location_city),
                                            Obx(
                                              () => controller.userRoleSelected
                                                          .value ==
                                                      'Passenger'
                                                  ? Container()
                                                  : const SizedBox(height: 25),
                                            ),
                                            Obx(
                                              () => controller.userRoleSelected
                                                          .value ==
                                                      'Passenger'
                                                  ? Container()
                                                  : NeoMorphicForm(
                                                      controller: controller
                                                          .plateNumber,
                                                      title: 'Plate number',
                                                      iconData: Icons.numbers),
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(height: 35),
                                  Obx(
                                    () => NeomorphicButton(
                                        onPressed: () async {
                                          if (submitStatus.isFalse) {
                                            submitStatus.value = true;
                                            await controller.postUserData();
                                            submitStatus.value = false;
                                          }
                                        },
                                        title: submitStatus.isTrue
                                            ? 'Please wait..'
                                            : 'Next',
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
            ),
            Positioned(
              bottom: 0,
              child: Obx(
                () => openBottomSheet.isTrue
                    ? Container(
                        width: Get.width,
                        height: 60,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ]),
                        child: Container(
                            width: Get.width,
                            height: 60,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(children: [
                              Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      width: Get.width,
                                      height: 50,
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.initializeGalery();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.photo,
                                              color: Colors.black45,
                                            ),
                                            const SizedBox(width: 5),
                                            CustomText.widget(title: 'Galery')
                                          ],
                                        ),
                                      ))),
                              Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      width: Get.width,
                                      height: 50,
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.initializePhoto();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: Colors.black45,
                                            ),
                                            const SizedBox(width: 5),
                                            CustomText.widget(title: 'Camera')
                                          ],
                                        ),
                                      )))
                            ])))
                    : Container(),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
