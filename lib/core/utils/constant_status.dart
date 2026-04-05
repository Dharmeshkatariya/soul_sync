class ConstantStatus {
  static const String pending = "pending";
  static const String refund = "refund";
  static const String all = "all";
  static const String cardAndAccounts = "cardAndAccounts";
  static const String failed = "failed";
  static const String underReview = "under review";
  static const String notVerified = "not verified";
  static const String vacant = "vacant";
  static const String completed = "completed";
  static const String cancelled = "cancelled";
  static const String drafts = "drafts";
  static const String myWallet = "myWallet";
  static const String onPP = "on_pp";
  static const String paid = "paid";
  static const String complete = "complete";
  static const String approved = "approved";
  static const String verified = "verified";
  static const String active = "active";
  static const String inActive = "inactive";
  static const String confirmed = "confirmed";
  static const String rejected = "rejected";
  static const String external = "external";
  static const String denied = "denied";
  static const String payment_plan = "payment_plan";
  static const String rejectedByPayer = "rejected by payer";
  static const String intakeFormAssigned = "intake form assigned";
  static const String inReview = "in review";
  static const String inProgress = "in progress";
  static const String partialPayment = "partial payment";
  static const String appealed = "appealed";
  static const String draft = "draft";
  static const String submitted = "submitted";
  static const String posted = "posted";
  static const String resubmitted = "resubmitted";
  static const String e = "E";
  static const String success = "success";
  static const String emergency = "Emergency";
  static const String highest = "Highest";
  static const String medium = "Medium";
  static const String low = "Low";
  static const String primary = "primary";
  static const String month = "month";
  static const String up = "UP";
  static const String unChanged = "UNCHANGED";
  static const String others = "Others";
  static const String backToSource = "back_to_source";
  static const String user = "User";

  /// status is "pending" or "in progress".
  static bool isGetPendingInProgressStatus({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == pending || normalizedStatus == inProgress;
  }

  static bool isGetPending({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == pending;
  }

  static bool isGetCompleted({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == complete || normalizedStatus == completed;
  }

  static bool isGetUp({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == up.toLowerCase() ;
  }
  static bool isUnChanged({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == unChanged.toLowerCase() ;
  }

  static bool isGetApprovedStatus({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == approved;
  }

  static bool isGetPartiallyPaidStatus({required String status}) {
    final normalizedStatus = status.toLowerCase();
    return normalizedStatus == partialPayment;
  }
}
