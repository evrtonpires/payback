import 'dart:ui';

abstract class SweetPetColors {
  static const Color primary800 = Color(0xFF2F2B7F);
  static const Color BlueGrey = Color(0xFF3D5E8B);

  static const Color yellow = Color(0xFFF8B133);
  static const Color orangeLight = Color(0xFFF08814);
  static const Color orange = Color(0xFFEC6C07);

  //----------------------------------------------------------------------------
  static const Color secundary800 = Color(0xFF7E358A);
  static const Color secundary700 = Color(0xFF7B1FA2);
  static const Color secundary600 = Color(0xFF8E24AA);
  static const Color secundary500 = Color(0xFF9C27B0);
  static const Color secundary400 = Color(0xFFAB47BC);
  static const Color secundary300 = Color(0xFFBA68C8);
  static const Color secundary200 = Color(0xFFCE93D8);
  static const Color secundary100 = Color(0xFFE1BEE7);
  static const Color secundary050 = Color(0xFFF3E5F5);

  //----------------------------------------------------------------------------
  static const Color orange900 = Color(0xFFE65100);
  static const Color orange800 = Color(0xFFEF6C00);
  static const Color orange700 = Color(0xFFF57C00);
  static const Color orange600 = Color(0xFFFB8C00);
  static const Color orange500 = Color(0xFFFF9800);
  static const Color orange400 = Color(0xFFFFA726);
  static const Color orange300 = Color(0xFFFFB74D);
  static const Color orange200 = Color(0xFFFFCC80);
  static const Color orange100 = Color(0xFFFFE0B2);
  static const Color orange050 = Color(0xFFFFF3E0);

  //----------------------------------------------------------------------------
  static const Color grey900 = Color(0xFF212121);
  static const Color grey800 = Color(0xF424242);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey050 = Color(0xFFFAFAFA);

  //----------------------------------------------------------------------------

  static const Color PRETOSGS = Color.fromARGB(255, 080, 079, 081);
  static const Color LARANJASGS = Color.fromARGB(255, 243, 112, 33);
  static const Color CINZASGS = Color.fromARGB(255, 119, 120, 123);

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

  static Color scrollBarColor = primary800.withOpacity(0.8);
  static const Color error = Color(0xFFF74237);

//----------------------------------------------------------------------------
  static List<Color> linearGradient = [secundary500, primary800];
  static List<Color> linearGradientLight = [secundary100, secundary200];
  static List<Color> linearGradientButton = [orangeLight, orange];
}
