class Const {
  static String cardNumber = "1110000661";

  static String baseUrl = "https://www.flatironbymeridian.top/api/";

  static String me = "account/me";
  static String getFloor =
      "${baseUrl}qr-code"; // params ?cardNo=1110000661&mainFloor=18
  static String getLift =
      "${baseUrl}biz/get-lift/"; // path value from getQrCode

  static String bearerToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI2MzQ5ODI1ZWNhMWY5MTAwMjhkZjAzMjQiLCJjbGllbnRJZCI6IkE4NTdEN0M3RjVEQzBCMkJDNjlGMkFDNDBGNThDMEQyOTg1NDA1NjQ2QkEzMkIzRjFDNjZDN0NBN0FERDMzNUEiLCJjcmVhdGVkQXQiOiIyMDIzLTA0LTA2VDE0OjE3OjA1KzAwOjAwIn0.Zd0KmpkD5rL4Z5zDcbHsN5DkPPO8XjVqOyxCmXFBcjo";

  static Map<String, String> floorHeaders = {
    "authorization": "Bearer $bearerToken",
    "accept": "application/json",
    "cache-control": "no-cache",
    "x-locale": "en-US",
    "Connection": "Keep-Alive",
    "User-Agent": "okhttp/4.9.1",
  };

  static String deviceToken =
      "c6BdDiF6TWSa9YqEhiU3sz:APA91bEKLcI-ybetO313UiNYVrMhAomkEVCV7wbm533qy5H_LaPTjR0qzDRUVuAX_TZlPbcVpANJ6CkXwl74kLyTqKF3lmVEU7vkC712teviT3sRNSmFZGIP5jR1oI_phqMrNa11jnqy";

  static Map<String, String> meHeaders = floorHeaders
    ..putIfAbsent("devicetoken", () => deviceToken);
}
