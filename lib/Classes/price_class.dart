class PriceClass {
  PriceClass();

  String priceFormat(double price) {
    String priceInString = price.toString();
    var splitDecimal = priceInString.split('.');
    return '${wholeNumberPriceFormating(splitDecimal[0])}${decimalNumberPriceFormating(splitDecimal[1])}';
  }

  String wholeNumberPriceFormating(String wholeNumber) {
    //Separate whole number
    int wholeNumberInInt = int.parse(wholeNumber);
    if (wholeNumberInInt > 9) {
      return '₱ $wholeNumberInInt';
    }
    return '₱ 0$wholeNumberInInt';
  }

  String decimalNumberPriceFormating(String decimalNumber) {
    //Separate decimal value
    //decimal value will be divided base on its length
    //to display decimal with just 2 digit
    int decimalNumberInInt = int.parse(decimalNumber);
    if (decimalNumberInInt > 10 && decimalNumberInInt < 100) {
      return '.$decimalNumberInInt';
    }

    //On higher number decimal
    if (decimalNumber.length > 2) {
      // int processingValue = 1;

      // for (var i = 0; i < decimalNumber.length - 2; i++) {
      //   processingValue *= 10;
      // }
      // String processedDecimalFormat =
      //     (decimalNumberInInt / processingValue).toString();

      return '.${decimalNumber.substring(0, 2)}';
    }

    return '.${decimalNumberInInt}0';
  }
}
