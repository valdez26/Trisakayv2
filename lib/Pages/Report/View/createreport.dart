import 'package:trisakay/packages.dart';

class CreateReport extends StatelessWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [CustomText.widget(title: 'Report')],
        ),
      )),
    );
  }
}
