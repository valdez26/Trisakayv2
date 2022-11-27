import 'package:trisakay/packages.dart';

class CustomTextForm {
  static Widget widget({
    TextEditingController? controller,
    TextInputType textInputType = TextInputType.text,
    String label = '',
    IconData? icon,
    bool hasBorder = false,
    bool isHint = true,
  }) {
    RxBool obscure = true.obs;

    if (label.toLowerCase().contains('password')) {
      return Obx(
        () => TextFormField(
          obscureText: obscure.value,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: isHint ? label : null,
              label: isHint ? null : Text(label),
              prefixIcon: icon == null ? null : Icon(icon),
              border: hasBorder ? const OutlineInputBorder() : InputBorder.none,
              suffixIcon: label.toLowerCase().contains('password')
                  ? IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        obscure.value = !obscure.value;
                      },
                      icon: Icon(obscure.isTrue
                          ? Icons.visibility_off
                          : Icons.visibility))
                  : null),
        ),
      );
    }

    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: isHint ? label : null,
        label: isHint ? null : Text(label),
        prefixIcon: icon == null ? null : Icon(icon),
        border: hasBorder ? const OutlineInputBorder() : InputBorder.none,
      ),
    );
  }
}
