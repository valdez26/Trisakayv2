import 'package:trisakay/packages.dart';

class NeomorphicTextField extends StatelessWidget {
  const NeomorphicTextField(
      {Key? key,
      required this.controller,
      this.title,
      this.w,
      this.h,
      this.r,
      this.maxLine})
      : super(key: key);

  final TextEditingController? controller;
  final String? title;
  final double? w;
  final double? h;
  final double? r;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w ?? Get.width,
      height: h ?? 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(r ?? 15)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                blurStyle: BlurStyle.inner,
                offset: Offset(3, 2),
                spreadRadius: 2,
                blurRadius: 5),
          ]),
      child: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(-1, 0),
                  spreadRadius: 0.5,
                  blurRadius: 5)
            ],
            borderRadius: BorderRadius.all(Radius.circular(r ?? 10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            maxLines: maxLine ?? 8,
            decoration: InputDecoration.collapsed(
                hintText: title ?? "Enter reason of cancelation"),
          ),
        ),
      ),
    );
  }
}
