const int kOtpTimer = 60;
const String appBox = "app_settings";

class Const {
  static String baseUrl = "https://www.flatironbymeridian.top/api/";

  static String myCardNumber = "1110000661";

  static String clientId =
      "A857D7C7F5DC0B2BC69F2AC40F58C0D2985405646BA32B3F1C66C7CA7ADD335A";

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

  static List<Map<String, dynamic>> phones = [
    // {"prefix": "0235", "len": 7, "network": "Cellcard"},
    {"prefix": "011", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "012", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "014", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "017", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "061", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "076", "len": 7, "network": "Cellcard", "icon": ""},
    {"prefix": "077", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "078", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "079", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "085", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "089", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "092", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "095", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "099", "len": 6, "network": "Cellcard", "icon": ""},
    {"prefix": "038", "len": 7, "network": "CooTel", "icon": ""},
    {"prefix": "039", "len": 7, "network": "Kingtel", "icon": ""},
    {"prefix": "018", "len": 7, "network": "Seatel", "icon": ""},
    // {"prefix": "0236", "len": 7, "network": "Metfone"},
    {"prefix": "031", "len": 7, "network": "Metfone", "icon": ""},
    {"prefix": "060", "len": 6, "network": "Metfone", "icon": ""},
    {"prefix": "066", "len": 7, "network": "Metfone", "icon": ""},
    {"prefix": "067", "len": 6, "network": "Metfone", "icon": ""},
    {"prefix": "068", "len": 6, "network": "Metfone", "icon": ""},
    {"prefix": "071", "len": 7, "network": "Metfone", "icon": ""},
    {"prefix": "088", "len": 7, "network": "Metfone", "icon": ""},
    {"prefix": "090", "len": 6, "network": "Metfone", "icon": ""},
    {"prefix": "097", "len": 7, "network": "Metfone", "icon": ""},
    {"prefix": "010", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "015", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "016", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "069", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "070", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "086", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "087", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "093", "len": 6, "network": "Smart", "icon": ""},
    {"prefix": "096", "len": 7, "network": "Smart", "icon": ""},
    {"prefix": "098", "len": 6, "network": "Smart", "icon": ""},
  ];
}
