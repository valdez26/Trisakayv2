import 'package:trisakay/packages.dart';

class NeoMorphicContainer extends StatelessWidget {
  const NeoMorphicContainer(
      {Key? key, this.w, this.h, this.rounded, this.color, this.child})
      : super(key: key);

  final double? w;
  final double? h;
  final double? rounded;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(rounded ?? 5)),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(80, 0, 0, 0),
                  blurStyle: BlurStyle.outer,
                  offset: Offset(1, 0),
                  spreadRadius: 0.5,
                  blurRadius: 1),
            ]),
        child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
                color: color,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white54,
                      blurStyle: BlurStyle.outer,
                      offset: Offset(1, 0),
                      spreadRadius: 0.2,
                      blurRadius: 1)
                ],
                borderRadius: BorderRadius.all(Radius.circular(rounded ?? 5))),
            child: child));
  }
}
