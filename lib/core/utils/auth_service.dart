// import 'package:get/get.dart';
// import 'package:soul_sync/core/routes/routes.dart';
//
// class AuthService {
//   // Private constructor
//   AuthService._internal();
//
//   // Static instance
//   static final AuthService _instance = AuthService._internal();
//
//   // Static getter for the instance
//   static AuthService get instance => _instance;
//
//   // Cached user ID
//   String? _cachedUserId;
//   bool hasPatientAcquisitionPermission = false;
//   bool hasProviderAcquisitionPermission = false;
//   bool isPatient = false;
//   bool isProvider = false;
//   bool isLoggedin = false;
//
//   APIServices apiServices = Get.find();
//
//
//   Future<String> getCurrentUserId() async {
//     // Return cached value if available
//     if (_cachedUserId != null) return _cachedUserId!;
//
//     // final isPatientPortal = await SharedPref().isPatientLoggedIn();
//     String userId = '';
//
//     // if (isPatientPortal) {
//     //   var data = await SharedPref().getPatientData();
//     //   userId = (data != null) ? data.patientId! : '';
//     // } else {
//     //   userId = await SharedPref().getStringPref(SharedPref().keyUserId);
//     // }
//     //
//     // // Cache the result
//     // _cachedUserId = userId;
//     return userId;
//   }
//
//   void clearUserIdCache() {
//     _cachedUserId = null;
//   }
//
//   void getPatientAcquisitionPermission() {
//     hasPatientAcquisitionPermission = true;
//   }
//
//   void getProviderAcquisitionPermission() {
//     hasProviderAcquisitionPermission = true;
//   }
//
//   Future<bool> patientLogin(String email, String password) async {
//     // GetLocationAndDeviceInfo? getLocationAndDeviceInfo;
//     //
//     // getLocationAndDeviceInfo = GetLocationAndDeviceInfo();
//     // await Future.wait([
//     //   getLocationAndDeviceInfo.fetchDeviceInfo(),
//     //   getLocationAndDeviceInfo.getLocation(),
//     //   NotificationService.refreshDeviceToken(),]);
//     //
//     // Map<String, dynamic> mapBody = {
//     //   RequestAndResponseParams.userName: CommonWidget()
//     //       .getPhoneNumberRemoveDash(email),
//     //   RequestAndResponseParams.password: password,
//     //
//     //   // device details
//     //   RequestAndResponseParams.deviceDetail: {
//     //     RequestAndResponseParams.make: getLocationAndDeviceInfo.make,
//     //     RequestAndResponseParams.models: getLocationAndDeviceInfo.models,
//     //     RequestAndResponseParams.ipAddress: getLocationAndDeviceInfo.externalIP,
//     //     if(NotificationService.deviceToken!=null && NotificationService.deviceToken!.isNotEmpty)
//     //       RequestAndResponseParams.deviceToken: NotificationService.deviceToken,
//     //   },
//     //
//     //   // location details
//     //   if (getLocationAndDeviceInfo.geocoding != null)
//     //     RequestAndResponseParams.location: {
//     //       RequestAndResponseParams.houseNumber:
//     //       getLocationAndDeviceInfo.geocoding!.address.houseNumber,
//     //       RequestAndResponseParams.district:
//     //       getLocationAndDeviceInfo.geocoding!.address.district,
//     //       RequestAndResponseParams.state:
//     //       getLocationAndDeviceInfo.geocoding!.address.state,
//     //       RequestAndResponseParams.city:
//     //       getLocationAndDeviceInfo.geocoding!.address.city,
//     //       RequestAndResponseParams.country:
//     //       getLocationAndDeviceInfo.geocoding!.address.country,
//     //       RequestAndResponseParams.countryCode:
//     //       getLocationAndDeviceInfo.geocoding!.address.countryCode,
//     //       RequestAndResponseParams.postalCode:
//     //       getLocationAndDeviceInfo.geocoding!.address.postalCode,
//     //     },
//     // };
//     //
//     // var apiResponse = await ApiServices()
//     //     .postData(ApiEndPoint.loginPatient, mapBody, isSkipToken: true);
//     // if (apiResponse.success) {
//     //   PatientLogin patientLogin = PatientLogin.fromJson(apiResponse.data);
//     //   PatientLoginData patientLoginData = patientLogin.data!;
//     //   await SharedPref().setPatientDetail(patientLoginData.patient);
//     //   await patientLoginData.mSetPatientDetails(asPatient: true);
//     //   await SharedPref().setIsGuestPatientLoggedIn(false);
//     //   isPatient=true;
//     //   isProvider=false;
//     //   await _updateLocale(patientLoginData);
//     //   return true;
//     // } else {
//     //   Common().showSnackBar(apiResponse.errorMessage!);
//     return false;
//     //   }
//   }
//
//   // Future<void> _updateLocale(PatientLoginData patientLoginData) async {
//   //   final addresses = patientLoginData.patient?.patientAddressesList;
//   //   if (addresses != null && addresses.isNotEmpty) {
//   //     final primaryAddresses = addresses.where(
//   //       (element) => element.isPrimary == true,
//   //     );
//   //     if (primaryAddresses.isNotEmpty) {
//   //       final countryCode =
//   //           primaryAddresses.first.country ?? SupportedCountries.usa.code;
//   //       final lnCode = await SharedPref().getLanguage();
//   //       appLocale.changeLocale(lnCode: lnCode, countryCode: countryCode);
//   //     }
//   //   }
//   // }
//
//   patientSignOut() async {
//     //   ApiServices().accessToken = null;
//     //   Common().navigateToHomeORLoginPage();
//     //   await Get.deleteAll();
//     //   await Get.putAsync(() => AppLocale.initialize().checkLoginType());
//     //   AppBindings().dependencies();
//     //   // if(hasPatientAcquisitionPermission) {
//     //   //   Get.offAndToNamed(Routes().patientLogin);
//     //   // }else{
//     //   //   Get.offAndToNamed(Routes().homeScreen);
//     //   // }
//     //   await SharedPref().setStringPref(SharedPref().keyUserId, '');
//     //   await SharedPref().setBooleanPref(SharedPref().keyFromPatient, false);
//     //   await SharedPref().setStringPref(SharedPref().keyAuthToken, '');
//     //   await SharedPref().setStringPref(SharedPref().keyRefreshToken, '');
//     //   await SharedPref().setStringPref(SharedPref().keyUserType, '');
//     //   await SharedPref().setIsLoggedInWeb(false);
//     //   await SharedPref().setPatientData(null);
//     //   await SharedPref().setIsPatientLoggedIn(false);
//     //   await SharedPref().setIsProviderLoggedIn(false);
//     //   await SharedPref().setIsGuestPatientLoggedIn(false);
//     //   clearUserIdCache();
//     //   hasPatientAcquisitionPermission = false;
//     //   isPatient = false;
//     //   isProvider = false;
//     //   NotificationService.deleteToken();
//   }
//
//   providerSignOut() async {
//     await Get.deleteAll();
//     clearUserIdCache();
//     isProvider = false;
//     isPatient = false;
//     Get.delete<APIServices>();
// Get.lazyPut(() => APIServices());
//     apiServices.clearHeader();
//     apiServices.updateHeader({'Content-Type': 'application/json'});
//     Get.offAndToNamed(Routes().login);
//     // ApiServices().accessToken = null;
//     // Common().navigateToHomeORLoginPage();
//     // await Get.deleteAll();
//     // Common().initializeAppBindings();
//     // await Get.putAsync(() => AppLocale.initialize().checkLoginType());
//     // // if(hasProviderAcquisitionPermission) {
//     // //   Get.offAndToNamed(Routes().providerLogin);
//     // // }else{
//     // //   Get.offAndToNamed(Routes().homeScreen);
//     // // }
//     // await SharedPref().setStringPref(SharedPref().keyUserId, '');
//     // await SharedPref().setStringPref(SharedPref().keyAuthToken, '');
//     // await SharedPref().setStringPref(SharedPref().keyRefreshToken, '');
//     // await SharedPref().setStringPref(SharedPref().keyUserType, '');
//     // await SharedPref().setBooleanPref(SharedPref().keyFromPatient, false);
//     // await SharedPref().setIsLoggedInWeb(false);
//     // await SharedPref().setPatientData(null);
//     // await SharedPref().setIsPatientLoggedIn(false);
//     // await SharedPref().setIsProviderLoggedIn(false);
//     // await SharedPref().remove(SharedPref().customerId);
//     // await SharedPref().remove(SharedPref().providerAccessLevel);
//     // clearUserIdCache();
//     // isProvider = false;
//     // isPatient = false;
//     // hasProviderAcquisitionPermission = false;
//     // NotificationService.deleteToken();
//   }
// }
