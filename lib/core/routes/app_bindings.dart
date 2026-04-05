// import 'package:get/get.dart';
// import 'package:soul_sync/nav_bar_layout/manager_home_controller.dart';
// import 'package:soul_sync/services/api_services.dart';
// import 'package:soul_sync/web/customer/properties/entities/view/controller/customer_entities_controller.dart';
// import 'package:soul_sync/web/forgot_password/data/forgot_password_repo_impl.dart';
// import 'package:soul_sync/web/forgot_password/domain/forgot_password_repo.dart';
// import 'package:soul_sync/web/forgot_password/view/controller/forgot_password_controller.dart';
// import 'package:soul_sync/web/login/data/login_repo_impl.dart';
// import 'package:soul_sync/web/login/data/user_details_repo.dart';
// import 'package:soul_sync/web/login/domain/login_repo.dart';
// import 'package:soul_sync/web/login/view/controller/login_controller.dart';
// import 'package:soul_sync/web/verifyOtp/controller/verify_otp_controller.dart';
//
// class AppBindings extends Bindings {
//   @override
//   void dependencies() {
//     //services
//     Get.lazyPut(() => APIServices());
//
//     //repos
//     Get.lazyPut<LoginRepo>(
//       () => LoginRepoImpl(apiServices: Get.find(), userDetailRepo: Get.find()),
//     );
//     Get.lazyPut(() => UserDetailRepo(apiServices: Get.find()));
//     Get.lazyPut<ForgotPasswordRepo>(
//       () => ForgotPasswordRepoImpl(apiServices: Get.find()),
//     );
//
//     // controllers
//     Get.lazyPut<ManagerHomeController>(() => ManagerHomeController());
//     Get.lazyPut<LoginController>(() => LoginController(loginRepo: Get.find()));
//     Get.lazyPut<ForgotPasswordController>(
//       () => ForgotPasswordController(repo: Get.find()),
//     );
//     Get.lazyPut<VerifyOtpController>(
//       () => VerifyOtpController(repo: Get.find()),
//     );
//   }
// }
