import 'dart:ui';

abstract class ColorsConstants {
  static const Color primary = Color(0xFF006699);
  static const Color secundary = Color(0xFF0098C5);

  static const Color redBlood = Color(0xFFE30613);
  static const Color error = Color(0xFFF74237);

  static const Color yellow = Color(0xFFF9B233);
  static const Color orangeLight = Color(0xFFF08814);
  static const Color orange = Color(0xFFEC6C07);

  //----------------------------------------------------------------------------
  static const Color grey900 = Color(0xFF212121);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey050 = Color(0xFFFAFAFA);

  //----------------------------------------------------------------------------

  static const Color pretoSGS = Color.fromARGB(255, 080, 079, 081);
  static const Color laranjaSGS = Color.fromARGB(255, 243, 112, 33);
  static const Color cinzaSGS = Color.fromARGB(255, 119, 120, 123);

  //----------------------------------------------------------------------------

  // static const Color yellow = Color(0xFFF9B233);
  static const Color white = Color(0xFFFFFFFF);

  //----------------------------------------------------------------------------
  static const Color gray = Color(0xFF404040);
  static const Color grayLighter = Color(0xFFEAEAEA);
  static const Color grayLight = Color(0xFFC0C0C0);

  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralGray = Color(0xFF909090);

  static const Color successLight = Color(0xFF51E572);
  static const Color success = Color(0xFF51E572);

  static Color scrollBarColor = primary.withOpacity(0.8);

//----------------------------------------------------------------------------
  static List<Color> linearGradient = [secundary, primary];
  static List<Color> linearGradientButton = [orangeLight, orange];
}
