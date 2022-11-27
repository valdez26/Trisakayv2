import 'package:trisakay/packages.dart';

class HistoryView extends GetView<AuthController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              height: 50,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.deepPurple,
                      )),
                  const SizedBox(width: 15),
                  CustomText.widget(
                      title: 'History',
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.85,
                child: ListView.builder(
                    itemCount: controller.controllerHandlerClass!
                        .historyController!.historyRecord.length,
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: Get.width,
                            height: 100,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    width: Get.width,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText.widget(
                                              title: controller
                                                  .controllerHandlerClass!
                                                  .historyController!
                                                  .historyRecord[index]
                                                  .date,
                                              color: Colors.white,
                                              fontSize: 18),
                                          CustomText.widget(
                                              title:
                                                  'Distance ${controller.controllerHandlerClass!.historyController!.historyRecord[index].historyDistance}',
                                              color: Colors.white,
                                              fontSize: 12),
                                          CustomText.widget(
                                              title:
                                                  'Total ${controller.controllerHandlerClass!.historyController!.historyRecord[index].fair}',
                                              color: Colors.white,
                                              fontSize: 12),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: Opacity(
                                      opacity: 0.6,
                                      child: Container(
                                        width: 200,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            color: Colors.deepPurpleAccent,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                                bottomLeft:
                                                    Radius.circular(100))),
                                      ),
                                    )),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 180,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  './assets/historybg.png')),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomRight: Radius.circular(5),
                                              bottomLeft:
                                                  Radius.circular(100))),
                                    )),
                              ],
                            ),
                          ),
                        ))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
