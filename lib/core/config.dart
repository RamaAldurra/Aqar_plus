class Config {
  static const String baseUrl = "http://192.168.1.102:8000/api/";
  static const String host = "192.168.1.102";

// no token
  static String fliter = "filter/properties";

// user
  static String filterUser = "user/filter/properties";
  // favorite
  static String addFavoriteUser = "user/addfavorite";
  static String deleteFavoriteUser = "user/deletefavorite";
  // rating
  static String addRatingUser = "user/add/rating";

// seller
  static String filterSeller = "seller/filter/properties";
  // favorite
  static String addFavoriteSeller = "seller/addfavorite";
  static String deleteFavoriteSeller = "seller/deletefavorite";
  // rating
  static String addRatingSeller = "seller/add/rating";
   //login_user
   static String loginUser = "user/login";
   //show_favorite
   static String showFavorite = "user/showfavorite";
   //show_proofile
    static String showProfile = "user/showprofile";
}
