import 'package:trisakay/packages.dart';

class NeomorphicButton extends StatelessWidget {
  const NeomorphicButton(
      {Key? key,
      this.title,
      this.color,
      this.rounded,
      required this.showChild,
      this.child,
      this.columnGap,
      this.w,
      this.h,
      required this.onPressed})
      : super(key: key);

  final String? title;
  final Color? color;
  final double? rounded;
  final bool? showChild;
  final Widget? child;
  final double? columnGap;
  final double? w;
  final double? h;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(rounded ?? 5),
      onTap: onPressed,
      child: Container(
          width: w ?? Get.width,
          height: h ?? 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(rounded ?? 100)),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(29, 0, 0, 0),
                    blurStyle: BlurStyle.inner,
                    offset: Offset(3, 2),
                    spreadRadius: 2,
                    blurRadius: 5),
              ]),
          child: Container(
            width: w ?? Get.width,
            height: h ?? 50,
            decoration: BoxDecoration(
                color: color ?? Colors.deepPurple,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurStyle: BlurStyle.outer,
                      offset: Offset(-1, -2),
                      spreadRadius: 0.5,
                      blurRadius: 5)
                ],
                borderRadius:
                    BorderRadius.all(Radius.circular(rounded ?? 100))),
            child: Center(
                child: showChild!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          child!,
                          SizedBox(width: columnGap ?? 5),
                          CustomText.widget(
                              title: title ?? "NOT DEFINED",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)
                        ],
                      )
                    : CustomText.widget(
                        title: title ?? "NOT DEFINED",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
          )),
    );
  }
}
