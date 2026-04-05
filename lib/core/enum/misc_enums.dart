
enum GeneralListingTypes {
  all(''),
  internal('INT'),
  external('EXT');

  final String param;

  const GeneralListingTypes(this.param);
}

enum EntityType{
  internal('Internal', 'INT'),
  external('External', 'EXT');

  final String name;
  final String code;

  const EntityType(this.name, this.code);
}

enum Recipient{
  user,
  patient,
  other;
}

enum PracticesSort{
  name('Name', 'name'),
  city('City', 'city'),
  state('State', 'state'),
  zipCode('Zip Code', 'zipcode'),
  specialities('Specialization', 'specialities');

  final String displayName;
  final String param;

  const PracticesSort(this.displayName, this.param);
}

enum UsersSort{
  status('Status', 'user__status'),
  name('Name', 'name');

  final String displayName;
  final String param;

  const UsersSort(this.displayName, this.param);
}

enum PrimarySidebarItemsEnum {
  dashboard(0),
  appointments(1),
  referrals(2),
  scheduling(3),
  practices(4),
  practiceStaff(5),
  insurance(6),
  patients(7),
  emails(8),
  chat(9),
  campaign(10),
  sms(11),
  telehealth(12),
  voiceDialer(13),
  billingDashboard(14),
  billingHistory(15),
  transactionHistory(16),
  paymentGateways(17),
  chargeCapture(18),
  insuranceVerification(19),
  claimsManagement(20),
  paymentPosting(21),
  paymentStatement(22),
  denialsManagement(23),
  collectionManagement(24),
  reports(25),
  reviews(26),
  tasks(27),
  systemSetting(28),
  userManagement(29),
  roleManagement(30),
  dataManagement(31),
  notifications(32),
  settings(33);

  final int id;

  const PrimarySidebarItemsEnum(this.id);
}

enum PrimarySidebarPatientItemsEnum {
  dashboard(0),
  appointments(1),
  referrals(2),
  scheduling(3),
  healthCenters(4),
  practiceUsers(5),
  insurances(6),
  patients(7),
  emails(8),
  chat(9),
  campaign(10),
  sms(11),
  telehealth(12),
  voiceDialer(13),
  reports(14),
  reviews(15),
  tasks(16),
  userManagement(17),
  roleManagement(18),
  masterData(19);

  final int id;

  const PrimarySidebarPatientItemsEnum(this.id);
}

enum DataMgmtPages{
  masterData,
  insurances,
  bills;
}

enum SnackBarType{
  error,
  info,
  warning,
  success;
}

enum OtpTypes{
  patientCreate('patient_create');

  final String paramValue;

  const OtpTypes(this.paramValue);
}

enum GlobalFilter { patient, practiceStaff, healthCenters, locations }

enum ReferralPriority { emergency, highest, medium, low }

enum PaymentMethod {
  insurance('Insurance'),
  willPayCash('I will pay cash');

  final String displayName;

  const PaymentMethod(this.displayName);
}

enum ProviderFilterParams { displayId, name, city, zipCode }


enum UserType{
  provider,
  patient
}

enum NotificationsType{
  call,
  email,
  sms,
  message
}

enum MeetingType{
  onDemand('ON_DEMAND'),
  immediate('IMMEDIATE'),
  scheduled('SCHEDULED');

  final String param;

  const MeetingType(this.param);
}

enum MeetingParticipationType{
  inviteOnly('INVITE_ONLY'),
  limited('LIMITED');

  final String param;

  const MeetingParticipationType(this.param);
}

enum AppointmentCategory{
  physical('PHYSICAL'),
  telehealth('TELEHEALTH');

  final String value;

  const AppointmentCategory(this.value);
}

enum TelehealthBeginStatus{
  completeIntake('COMPLETE_INTAKE'),
  beginTriage('BEGIN_TRIAGE'),
  completeTriage('COMPLETE_TRIAGE'),
  // pending('PENDING'),
  beginAssessment('BEGIN_CLN_ASSESS');

  final String value;

  const TelehealthBeginStatus(this.value);
}

enum FaceMeetMoreOptions{
  visualEffects,
  participants,
  chat,
  screenLayout,
  whiteBoard,
  hostControls,
  meetingDetails
}


enum ListingTheme{
  primary,
  secondary
}


enum DateFilterType {
  currentWeek('Current Week'),
  lastWeek('Last Week'),
  currentMonth('Current Month'),
  lastMonth('Last Month'),
  customRange('Custom Range');
  final String? type;
  const DateFilterType(this.type);
}

enum DisplayDateType {
  date('Date') ,
  time('Time') ,
  dateAndTime('Date And Time');


  final String dateTime;
  const DisplayDateType(this.dateTime);
}