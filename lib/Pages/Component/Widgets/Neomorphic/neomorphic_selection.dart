import 'package:trisakay/packages.dart';

class NeoMorphicSelection extends StatelessWidget {
  const NeoMorphicSelection(
      {super.key,
      this.title,
      this.w,
      this.h,
      this.r,
      this.iconData,
      required this.list,
      required this.onChange});

  final String? title;
  final double? w;
  final double? h;
  final double? r;
  final IconData? iconData;
  final List<String>? list;
  final ValueChanged<String>? onChange;

  @override
  Widget build(BuildContext context) {
    RxString value = list![0].obs;
    return Container(
      width: w ?? Get.width,
      height: h ?? 80,
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
        child: InputDecorator(
          decoration: InputDecoration(
              errorStyle:
                  const TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: title,
              // labelText: 'Account type',
              border: InputBorder.none),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    items: list!.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    value: value.value,
                    isDense: true,
                    onChanged: (newValue) {
                      value.value = newValue!;
                      onChange!(newValue);
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
