import 'package:trisakay/Pages/About/Model/aboutmodel.dart';
import 'package:trisakay/packages.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AboutModel aboutModel = AboutModel();
    return Scaffold(
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText.widget(
                              title: 'Tri',
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                          CustomText.widget(
                              title: 'Sakay',
                              color: Colors.deepPurple,
                              fontSize: 30,
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: Get.width * 0.8,
                          child: CustomText.widget(
                              title: aboutModel.description,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textAlgin: TextAlign.center)),
                    ],
                  ),
                )),
            Positioned(
                child: HeaderWidget(
              onPressed: () {
                Get.back();
              },
              pageTitle: 'About',
            )),
            Positioned(
                bottom: 30,
                child: SizedBox(
                    width: Get.width,
                    height: 40,
                    child: Center(
                      child: CustomText.widget(
                          title: aboutModel.credits.toUpperCase(),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ))),
            Positioned(
                bottom: 10,
                child: SizedBox(
                    width: Get.width,
                    height: 40,
                    child: Center(
                      child: CustomText.widget(
                          title: 'CREDITS',
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ))),
          ],
        ),
      )),
    );
  }
}
