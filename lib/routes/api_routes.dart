class ApiRoute {
  static String prodHostAPI = "http://10.0.2.2:8000/api/android/";
  static String devHostAPI = "http://192.168.100.180/api/android/";
  static String localHostAPI = "http://192.168.101.190:8000/api/android/";
  //static String localHostAPI = "http://192.168.125.238:8000/api/android/";

  getApiRoute() => localHostAPI;

  //ENDPOINT URL
  static String endptLogin = "login";
  static String endptSync = "sync-all";
  static String submitData = "submition-all";
  static String submitImage = "submition-image";
}
