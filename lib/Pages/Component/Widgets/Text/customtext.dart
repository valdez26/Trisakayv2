import 'package:trisakay/packages.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText {
  static Widget widget(
      {String title = '',
      Color color = Colors.black,
      double fontSize = 12.0,
      FontWeight fontWeight = FontWeight.w400,
      TextAlign textAlgin = TextAlign.start}) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: color, fontSize: fontSize, fontWeight: fontWeight)),
      textAlign: textAlgin,
    );
  }
}
