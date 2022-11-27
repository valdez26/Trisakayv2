import 'package:trisakay/packages.dart';

class MenuView extends GetView<AuthController> {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool openBottomSheet = false.obs;
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
      width: Get.width,
      height: Get.height,
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
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        color: Colors.deepPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 200,
                                height: 120,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Obx(
                                        () => Center(
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: CircleAvatar(
                                                maxRadius: 120,
                                                backgroundColor: Colors.white,
                                                foregroundImage: NetworkImage(
                                                    controller.user.userProfile!
                                                        .value),
                                                child: controller
                                                            .user
                                                            .userProfile
                                                            ?.value ==
                                                        'NONE'
                                                    ? CustomText.widget(
                                                        title: controller.user
                                                            .userFirstName![0],
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Colors.deepPurple)
                                                    : Container(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: IconButton(
                                            splashColor: Colors.transparent,
                                            onPressed: () {
                                              openBottomSheet.toggle();
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_rounded,
                                              color: Colors.white30,
                                            )))
                                  ],
                                )),
                            const SizedBox(height: 10),
                            CustomText.widget(
                                title:
                                    "${controller.user.userFirstName} ${controller.user.userLastName}",
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            CustomText.widget(
                                title: controller.user.userAddress!,
                                fontSize: 14,
                                color: Colors.white),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 5,
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              title: CustomText.widget(
                                  title: 'Account', fontSize: 18),
                              onTap: () {
                                Get.toNamed('/account');
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.history_rounded,
                                color: Colors.grey,
                              ),
                              title: CustomText.widget(
                                  title: 'History', fontSize: 18),
                              onTap: () {
                                Get.toNamed('/history');
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.info_outlined,
                                color: Colors.grey,
                              ),
                              title: CustomText.widget(
                                  title: 'About', fontSize: 18),
                              onTap: () {
                                Get.toNamed('/about');
                              },
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: SizedBox(
                width: Get.width,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MaterialButton(
                      color: Colors.deepPurple,
                      onPressed: () {
                        controller.signout();
                      },
                      child: CustomText.widget(
                          title: 'LOGOUT',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white)),
                ),
              )),
          Positioned(
              top: 5,
              left: 5,
              child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.deepOrange,
                  ))),
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
                                        controller.updateProfileGalery();
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
                                        controller.updateProfileCamera();
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
    )));
  }
}
