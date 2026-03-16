class AppConstants {
  static const APP_NAME = "SPEX";

  static const int perPage = 50;
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
  static const String apiCustomVersion = "custom/v1/";

  // static const String baseURL = "https://api.smat.sa/";

  static String consumerKey = "ck_41f208124a533bae17da18ad55dd080a2387918e";
  static String consumerSecret = "cs_88435eac44ab81115d95850db10598a5028f2720";

  static String loginEndPoint = "${apiMobileVersion}login";
  static String registerEndPoint = "${apiMobileVersion}register";
  static String getProductsEndPoint = "${apiVersion}products";
  static String getBestSellersEndPoint = "${apiCustomVersion}best-selling-products";
  static String getPromotionsEndPoint = "${apiCustomVersion}discount-products";
  // static String getProductDetailsEndPoint ="${apiVersion}products";
  static String getCategoriesEndPoint = "${apiVersion}products/categories";
  static String searchEndPoint = "${apiMobileVersion}search";
  static String categoryProductsEndPoint = "${apiCustomVersion}category-products";
  static String productsListEndPoint = "${apiMobileVersion}products-by-ids";

  static const String USER_TEXT = "spex_user";
  static const String PASSWORD_TEXT = "spex_password";
  static const String ONBOARDING_TEXT = "spex_onBoarding";
  static const String THEME_TEXT = "spex_theme";

  static const String USER_BOX = "spex_userBox";
  static const String PASSWORD_BOX = "spex_passwordBox";
  static const String ONBOARDING_BOX = "spex_onBoardingBox";
  static const String THEME_BOX = "spex_themeBox";
  static const String FAVORITES_BOX = "spex_favoritesBox";
}

class ValuesOfAllApp {
  static const int mobileWidth = 660;
  static const int tabWidth = 1180;
}
