import 'package:trisakay/packages.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, this.pageTitle, this.onPressed})
      : super(key: key);

  final String? pageTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)
      ]),
      child: Container(
        width: Get.width,
        height: 50,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              InkWell(
                  onTap: onPressed,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.deepPurple,
                  )),
              const SizedBox(width: 20),
              CustomText.widget(
                  title: pageTitle?.toUpperCase() ?? 'Unknown',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87)
            ],
          ),
        ),
      ),
    );
  }
}
