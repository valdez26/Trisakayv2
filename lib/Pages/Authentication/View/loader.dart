import 'package:trisakay/packages.dart';
import 'package:trisakay/main.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.2,
                      child: Column(
                        children: [
                          CustomText.widget(
                            title: 'Hi please wait application initializing',
                            fontSize: 14,
                          ),
                          const SizedBox(height: 20),
                          const CircularProgressIndicator(
                            color: Colors.deepPurple,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
