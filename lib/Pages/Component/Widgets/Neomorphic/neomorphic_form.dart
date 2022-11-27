import 'package:trisakay/packages.dart';

class NeoMorphicForm extends StatelessWidget {
  const NeoMorphicForm(
      {Key? key,
      this.controller,
      this.title,
      this.w,
      this.h,
      this.r,
      this.iconData})
      : super(key: key);

  final TextEditingController? controller;
  final String? title;
  final double? w;
  final double? h;
  final double? r;
  final IconData? iconData;

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
                  offset: Offset(-1, -2),
                  spreadRadius: 0.5,
                  blurRadius: 5)
            ],
            borderRadius: BorderRadius.all(Radius.circular(r ?? 10))),
        child: CustomTextForm.widget(
            controller: controller,
            label: title ?? "Placeholder",
            icon: iconData),
      ),
    );
  }
}
