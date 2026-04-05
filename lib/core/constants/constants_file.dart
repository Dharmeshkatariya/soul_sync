import 'dart:ui';

import 'package:get/get.dart';

class ConstantsFile {
  static var themeColor = const Color(0xFFD9001D).obs;
  static var themeColor50 = const Color(0x80D9001D).obs;
  static var themeColor15 = const Color(0x26D9001D).obs;
  static var drawerColor = const Color(0xFFF0403E).obs;
  static var darkThemeColor = const Color(0xFF6D0E1B).obs;
  static const String appName = 'Property Management';
  static const String boldFont = 'BoldFontMontserrat';
  static const String regularFont = 'RegularFontMontserrat';
  static const String semiBoldFont = 'SemiBoldFontMontserrat';
  static const String mediumFont = 'MediumFontMontserrat';
  static const String italicFont = 'italicFontMontserrat';

  static String percentSymbol = '\u0025';

  static const String fcmVapidKey =
      "BFFP9Z0YE3mg-wo0uLdEw7_LJ07udZZhfnZdUdmACMERO8JDyddvzfdmt-U3m5yypfvqwEzxcI0g3XGcXCS8SH0";

  static const String checkBoxTag = 'checkbox';
  static const String messageViewTag = 'message-pages';
  static const String bookViewTag = 'book-pages';
  static const String detailViewTag = 'detail-pages';
  static const String locationTag = 'location';
  static const String permissionTag = 'permissions';
  static const String editTag = 'edit';
  static const String selectionTag = 'select';
  static const String editLocationTag = 'edit-location';
  static const String deleteTag = 'delete';
  static const String switchTag = 'switch';
  static const String smsTag = 'sms';
  static const String callTag = 'call';
  static const String chatTag = 'chat';
  static const String isActive = 'is-active';
  static const String providerTag = 'provider-tag';
  static const String organizationTag = 'organization-tag';
  static const String moreTag = 'more-tag';
  static const String favoriteTag = 'favorite-tag';
  static const String activeTag = 'active-tag';
  static const String isLocation = 'is-location';

  static const String contentType = 'Content-Type';
  static const String applicationJSON = 'application/json';
  static const String authorization = 'Authorization';

  static String webHomePageController = 'web-home-pages-controller';
  static String primarySideBarIndex = 'primarySideBarIndex';
  static String openLogin = 'openLogin';
  static String urlToGo = 'url to go';
  static String subPage = 'sub_page';
  static String previousPage = 'previous-pages';
  static String mode = 'mode';
  static String refund = 'refund';

  static String address1 = 'address1';
  static String address2 = 'address2';
  static String city = 'city';
  static String zip = 'zip';
  static String state = 'state';
  static String country = 'country';

  static String helixPatient = 'HelixPatient';
  static String helixStaff = 'HelixStaff';
  static String helixUser = 'HelixUser';

  static String provider = 'provider';
  static String nurse = 'nurse';
  static String patient = 'patient';
  static String resend = 'resend';

  static String uid = 'uid';
  static String approveTag = 'approve';
  static String priorityChangeTag = 'priority-change-Tag';
  static String cancelTag = 'cancel';

  // static const String defaultVisitType = 'NP_PHY';
  static const String participant = 'participant';
  static const String female = 'female';
  static const String other = 'OTHER';
  static const int successStatusCode = 200;
  static const int otpExpireTime = 300;
  static const String minute = 'minute';
  static const String minutes = 'minutes';
  static const String second = 'second';
  static const String seconds = 'seconds';

  // const Input mask
  static const String phoneMask = '(###)-###-####';
  static const String zipMask = '#####-####';

  static const String mainTab = 'main-tab';
  static const String subTab = 'sub-tab';
  static const double horizontalPaddingRatio = 5.5;
  static const double horizontalPaddingRatioMobile = 3.8;

  static const String dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'";
  static const String dateTimeFormat2 = "yyyy-MM-dd'T'HH:mm:ss";

  static const String mmDDYyyy = "MMM dd yyyy"; //
  static const String MDY = "dd-MM-yyyy"; //
  //  Oct 25 2024
  static const String mDY = "MM/dd/yyyy"; //  10/25/2024
  static const String dmY = "dd/MM/yyyy"; //  10/25/2024

  static const String hhMMA = "hh:mm a";
  static const String hhMMAz = "hh:mm a z";
  static const String eeeMMMddYYYY = "EEE MMM dd, yyyy";
  static const String mDYhhMMA = "MM/dd/yyyy, hh:mm a"; //  10/25/2024, 02:45 PM
  static const String yyyyMMDDHHmmSS =
      "yyyy-MM-dd HH:mm:ss"; //  10/25/2024, 02:45 PM

  static const String mmmDDYyyyHHMMA =
      "MMM dd, yyyy, hh:mm a"; //  Oct 25, 2024, 02:45 PM
  static const String yyyyMMDD = "yyyy-MM-dd"; //  2024-10-25
  static const String eeeMmmDDHhMma =
      "EEE, MMM dd, hh:mm a"; //  Fri, Oct 25, 02:45 PM
  static const String mmmDDYyyyHhMMA =
      "MMM dd, yyyy, hh:mm a"; //  Oct 25, 2024, 02:45 PM
  static const String eEE = "EEE"; //  Fri (for Mon, Tue, Wed)
  static const String eEEE = "EEEE"; //  Friday (for Monday, Tuesday, Wednesday)
  static const String mMM = "MMM"; //  Oct (for Jan, Feb, Oct)
  static const String mMMM = "MMMM"; // October (for January, February, October)
  static const String eD = "E d";
  static const String mMMddYYY = "MMM dd, yyyy"; //  Oct 25, 2024
  static const String eeeMMD = "EEE, MMM d"; //  Fri, Oct 25
  static const String mmmD = "MMM d"; //   Oct 25
  static const String mmmmYYYY = "MMMM, yyyy"; //  October, 2024
  static const String dd = "dd"; //  19
  static const String E = "E"; //  Sun
  static const String HHmm = "HH:mm"; //  October, 2024
  static const String hhmm = "hh:mm"; //  October, 2024

  static const String mMMdYYYYhMMssA = "MMM d, yyyy h:mm:ss a";
  static const String eeeMMMdHHMMSSYYYY = "EEE MMM d HH:mm:ss yyyy";
  static const String eeeMMMDDHHMMSSYYYY = "EEE MMM dd HH:mm:ss yyyy";
  static const String eeeMMMdYYYYHHMMSSa = "EEE, MMM d, yyyy hh:mm:ss a";

  static const String eeeMMMdYYYYhMMSs = "EEE, MMM d, yyyy H:mm:ss";
  static const String eeeMMMdYYYYhMMSsa = "EEE, MMM d, yyyy h:mm:ss a";
  static const String ddMMMYYYYHHMMssSSSS =
      "dd MMM yyyy HH:mm:ss.SSSSSS"; // Fri Aug 16 17:55:55 IST 2024
  static const String MMYY = "MMM yy"; //  Oct 24
  static const String MMdd = "MMM dd"; //  Oct 30
  static String isTrue = 'true';
  static String isFalse = 'false';

  static const String eid = "eid";
  static bool isLoginDialogOpen = false;
  static const String isFromTakeVitals = "isFromTakeVitals";
  static const String aid = "aid";

  static const String isLocked = "isLocked";
  static const String status = "status";
  static const String flat = "FLAT";
  static const String percent = "PERCENT";
  static const String freeText = "Free Text";
  static const String tempAuth = "temporary-auth-status";
  static const String visa = "Visa";
  static const String mastercard = "Mastercard";
  static const String americanExpress = "American Express";
  static const String discover = "Discover";

  static const String chatsTag = 'chats';
  static const String videoCallTag = 'video call';
  static const String voiceDialerTag = 'voice dialer';

  static const String isExpToken = 'token-expired';

  static const String creditCard = 'CREDIT_CARD';
  static const String debitCard = 'DEBIT_CARD';
  static const String cash = 'CASH';
  static const String bankTransfer = 'BANK_TRANSFER';
  static const String posPayment = 'POS_PAYMENT';
  static const String wallet = 'WALLET';

  static const String mMMdd = "MMM dd";

  static List<String> insurancePriority = ['primary', 'secondary', 'tertiary'];
  static const String temperatureDegC = "Temperature (DEG C)";
  static const String bloodPressureMmHg = "Blood Pressure (mmHg)";
  static const String pulseBeatsMin = "Pulse (beats/min)";
  static const String rrate = "R.rate";
  static const String spo2 = "SpO2";
  static const String weightKg = "Weight (kg)";
  static const String bmiKGM = "BMI (kg / m²)";
  static const String muacCm = "MUAC (cm)";
  static const String degC = "Deg.C";
  static const String mmHg = "mmHg";
  static const String beatsOrMin = "beats/min";
  static const String breathsOrMin = "breaths/min";
  static const String kg = "kg";
  static const String mg = "mg";
  static const String cmH = "cm";
  static const String cm = "cm";
  static const String bmiCalc = "BMI (calc.)";
  static const String kgmSquare = "kg / m²";
  static const String helixLinkedin =
      'https://www.linkedin.com/company/helixbeat/';
  static const String helixFacebook = 'https://www.facebook.com/helixbeat/';
  static const String helixInstagram =
      'https://www.instagram.com/helixbeat_global/';
  static const String helixYouTube = 'https://www.youtube.com/@helixbeat';
  static const String helixAppStore = 'https://www.apple.com/app-store/';
  static const String helixPlayStore =
      'https://play.google.com/store/apps?hl=en';
  static const ssnMaxLength = 12;
  static const String appFontHelvetica = 'Helvetica';
  static const double horizontalPaddingRatioWeb = 1.0;

  //------------------Rest Constants -----------------//
  static const String bearer = 'Bearer';
  static const String curl = 'curl';
  static const String response = 'response';
  static const String production = 'production';
  static const double requestResponseBoxHeight = 600;

  //------------------Route Constants -----------------//

  static const String createTag = 'create';
  static const String viewTag = 'pages';
  static const String policyId = 'policy-id';
  static const String payrollElementId = 'element-id';
  static const String empId = 'employee-id';
  static const String companyId = 'company-id';
  static const String monthly = 'Monthly';
  static const String adhoc = 'Adhoc';
  static const String quarterly = 'Quarterly';
  static const String annual = 'Annual';
  static const String id = 'id';

  // api response variable key Name is data
  static const String data = 'data';
  static const String errors = 'errors';
  static const String results = 'results';
  static const String pagination = 'pagination';
}
