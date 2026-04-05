
class Routes {
  String login = '/login';

  String register = '/register';
  String createNewPatient = '/create-new-patient';
  String dashboardView = '/dashboard';

  static String providerHomePage = '/provider-home-pages';

  String managerDashboard = '/manager-dashboard';
  String manageAppointments = '/manage-appointments';
  String manageReferrals = '/manage-referrals';
  String forgotPassword = '/forgot-password';

  static String forgotPasswordOtpVerificationPage =
      '/forgot-password-otp-verification';
  static String resetPasswordPage = '/reset-password';

  static String dataManagement = '/data-management';
  String managePatients = '/manage-patients';
  static String roleManagement = '/role-management';
  static String addRoleView = '/add-role-view';
  static String customerView = '/customer-view';
  static String addCustomerView = '/add-customer-view';
  static String manageTenants = '/manage-tenants';
  static String applicationVersion = '/application-version';
  static String managePractices = '/manage-practices';
  static String addPropertyLocationView = '/add-property-location-view';
  static String propertyUnits = '/property-units';

  Map<String, String> get routeDisplayNames => {
    providerHomePage: 'Provider home Page',
    managerDashboard: 'Manager Dashboard',
    roleManagement: 'Role Management',
    addRoleView: 'Add Role View',
    manageTenants: 'Manage Tenants',
    managePractices: 'Manage Practices',
    customerView: 'Customer View',
    addCustomerView: 'Add Customer View',
    addPropertyLocationView: 'Add Property Location View',
    propertyUnits: 'Property Units',
  };

  Map<String, String> get providerInternalRoutes => {
    roleManagement: roleManagement,
    addRoleView: addRoleView,
    customerView: customerView,
    addCustomerView: addCustomerView,
    addPropertyLocationView: addPropertyLocationView,
  };

  //
  // GetPage notFoundPageWidget = GetPage(
  //   name: '/not-found',
  //   binding: AppBindings(),
  //   page: () => const PageNotFound(),
  // );
}
