class AppConstants {
  static const APP_NAME = "SPEX";
}

class AppImages {
  static const appLogoImagePath = "assets/images/spex-logo.webp";
}

class FontSelectionData {
  static const int boldFontFamily = 1;
  static const int semiBoldFontFamily = 2;
  static const int regularFontFamily = 3;
}

class ServicesConstants {
  static const String baseURL = "https://spexeg.com/wp-json/";
  static const String apiVersion = "wc/v3/";
  static const String apiMobileVersion = "mobile/v1/";

  // static const String baseURL = "https://api.smat.sa/";

  static String consumerKey = "ck_41f208124a533bae17da18ad55dd080a2387918e";
  static String consumerSecret = "cs_88435eac44ab81115d95850db10598a5028f2720";

  static String getProductsEndPoint = "${apiVersion}products";
  // static String getProductDetailsEndPoint ="${apiVersion}products";
  static String getCategoriesEndPoint = "${apiVersion}products/categories";
  static String searchEndPoint = "${apiMobileVersion}search";

  static const String USER_TEXT = "user";
  static const String PASSWORD_TEXT = "password";
  static const String ONBOARDING_TEXT = "onBoarding";
  static const String THEME_TEXT = "theme";

  static const String USER_BOX = "userBox";
  static const String PASSWORD_BOX = "passwordBox";
  static const String ONBOARDING_BOX = "onBoardingBox";
  static const String THEME_BOX = "themeBox";
}

class ValuesOfAllApp {
  static const int mobileWidth = 660;
  static const int tabWidth = 1180;
}
