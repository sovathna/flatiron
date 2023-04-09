const int kOtpTimer = 5;

class Const {
  static String cardNumber = "1110000661";

  static String baseUrl = "https://www.flatironbymeridian.top/api/";

  static String me = "account/me";
  static String getFloor =
      "${baseUrl}qr-code"; // params ?cardNo=1110000661&mainFloor=18
  static String getLift =
      "${baseUrl}biz/get-lift/"; // path value from getQrCode

  static String signin = "${baseUrl}otp";

  static String verifyOtp = "${baseUrl}token-otp";

  static Map<String, String> signinHeaders = {
    "accept": "application/json",
    "cache-control": "no-cache",
    "x-locale": "en-US",
    "Connection": "Keep-Alive",
    "User-Agent": "okhttp/4.9.1",
  };

  static String bearerToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI2MzQ5ODI1ZWNhMWY5MTAwMjhkZjAzMjQiLCJjbGllbnRJZCI6IkE4NTdEN0M3RjVEQzBCMkJDNjlGMkFDNDBGNThDMEQyOTg1NDA1NjQ2QkEzMkIzRjFDNjZDN0NBN0FERDMzNUEiLCJjcmVhdGVkQXQiOiIyMDIzLTA0LTA2VDE0OjE3OjA1KzAwOjAwIn0.Zd0KmpkD5rL4Z5zDcbHsN5DkPPO8XjVqOyxCmXFBcjo";

  static Map<String, String> floorHeaders = signinHeaders
    ..putIfAbsent("authorization", () => "Bearer $bearerToken");

  static String deviceToken =
      "c6BdDiF6TWSa9YqEhiU3sz:APA91bEKLcI-ybetO313UiNYVrMhAomkEVCV7wbm533qy5H_LaPTjR0qzDRUVuAX_TZlPbcVpANJ6CkXwl74kLyTqKF3lmVEU7vkC712teviT3sRNSmFZGIP5jR1oI_phqMrNa11jnqy";

  static Map<String, String> meHeaders = floorHeaders
    ..putIfAbsent("devicetoken", () => deviceToken);

  static List<Map<String, dynamic>> phones = [
    // {"prefix": "0235", "len": 7, "network": "Cellcard"},
    {
      "prefix": "011",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "012",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "014",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "017",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "061",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "076",
      "len": 7,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "077",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "078",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "079",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "085",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "089",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "092",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "095",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {
      "prefix": "099",
      "len": 6,
      "network": "Cellcard",
      "icon": "assets/icons/cellcard.jpg"
    },
    {"prefix": "038", "len": 7, "network": "CooTel", "icon": ""},
    {"prefix": "039", "len": 7, "network": "Kingtel", "icon": ""},
    {"prefix": "018", "len": 7, "network": "Seatel", "icon": ""},
    // {"prefix": "0236", "len": 7, "network": "Metfone"},
    {
      "prefix": "031",
      "len": 7,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "060",
      "len": 6,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "066",
      "len": 7,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "067",
      "len": 6,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "068",
      "len": 6,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "071",
      "len": 7,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "088",
      "len": 7,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "090",
      "len": 6,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "097",
      "len": 7,
      "network": "Metfone",
      "icon": "assets/icons/metfone.png"
    },
    {
      "prefix": "010",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "015",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "016",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "069",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "070",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "086",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "087",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "093",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "096",
      "len": 7,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
    {
      "prefix": "098",
      "len": 6,
      "network": "Smart",
      "icon": "assets/icons/smart.jpg"
    },
  ];
}
