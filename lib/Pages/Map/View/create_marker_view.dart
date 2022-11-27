import 'package:trisakay/packages.dart';

class CreateMarkerView extends GetView<AuthController> {
  const CreateMarkerView({Key? key}) : super(key: key);

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
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: GoogleMap(
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: controller.controllerHandlerClass!
                        .mapController!.initialGooglePlex,
                    onCameraMove: ((position) => {
                          controller.controllerHandlerClass!.mapController!
                              .initLocation(position)
                        }),
                  ),
                ),
              ),
              Positioned(
                  child: SizedBox(
                width: Get.width,
                height: Get.height - 50,
                child: const Center(
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              )),
              Positioned(
                  child: Container(
                width: Get.width,
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded)),
                    Obx(
                      () => CustomText.widget(
                          title: controller.controllerHandlerClass!
                                  .mapController!.isDestination.isTrue
                              ? "Choose destination"
                              : "Choose start location",
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.controllerHandlerClass!.mapController!
                              .initMarker();
                        },
                        child: CustomText.widget(
                          title: 'OK',
                          fontSize: 20,
                        ))
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
