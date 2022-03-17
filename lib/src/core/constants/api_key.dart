mixin ApiKey{
   static const String apiBaseUrl='https://3leena.com/public/api/shops/';

   final String URLLogin = apiBaseUrl + "login";
   final String URLRegister = apiBaseUrl + "sign-up";
   final String URLRegisterInfo = apiBaseUrl + "setInfo";
   final String uRLSetRate = apiBaseUrl + "rateOrder";
   final String URLCheckPhone = apiBaseUrl + "check_phone";
   final String URLResetPassword = apiBaseUrl + "reset_password";
   final String URLSetLocation = apiBaseUrl + "Address";
   final String URLGetOrders = apiBaseUrl + "getOrder";
   final String URLPostOrder = apiBaseUrl + "postOrder";
   final String URLVerifyPhone = apiBaseUrl + "phone_verify";
   final String uRLChangeNotificationsStatus = apiBaseUrl + "change_notifications_status";
   final String uRLContactWithUs = apiBaseUrl + "contactus";
   final String uRLResetPassword = apiBaseUrl + "reset_password";
   final String uRLQuestions = apiBaseUrl + "qustions";
   final String uRLShopInfo = apiBaseUrl + "shop";
   final String uRLUpdateShopInfo = apiBaseUrl + "updateInfo";
   final String uRLUpdatePersonalInfo = apiBaseUrl + "updateShop";
   final String uRLChangePassword = apiBaseUrl + "change_password";
   final String uRLNotifications = apiBaseUrl + "notifications";
   final String uRLLogOut = apiBaseUrl + "log_out";
   final String uRLHowAreWe = apiBaseUrl + "aboutus";
   final String uRLPrivacyAndTerms = apiBaseUrl + "privacy";
   final String uRLCity = apiBaseUrl + "city";
   final String uRLArea = apiBaseUrl + "cityarea";
   final String uRLLastOrder = apiBaseUrl + "lastOrder";
   final String uRLReturnOrders = apiBaseUrl + "return_orders";
   final String uRLDeleteOrder = apiBaseUrl + "Order";
   final String uRLChangeStatusNotification = apiBaseUrl + "statusNotification";
   final String uRLFetchDeliveryFee = apiBaseUrl + "fetch_delivery_fee";

   final String uRLFetchRegoins = apiBaseUrl + "get_area_lat_lng";

   String uRLFetchPlaceId({required String place , required String lang}){
      return 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$place&language=$lang&types=geocode&key=AIzaSyAr46q-zhrzke0rLD7YbTvDxO91cIdBX_Q';
   }
   String uRLFetchPlaceCoordinates({required String placeId}){
      return 'https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyAr46q-zhrzke0rLD7YbTvDxO91cIdBX_Q&place_id=$placeId';
   }
}