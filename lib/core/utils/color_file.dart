import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorFile {
  static Map<int, Color> color = {
    50: const Color.fromRGBO(204, 0, 0, .1),
    100: const Color.fromRGBO(204, 0, 0, .2),
    200: const Color.fromRGBO(204, 0, 0, .3),
    300: const Color.fromRGBO(204, 0, 0, .4),
    400: const Color.fromRGBO(204, 0, 0, .5),
    500: const Color.fromRGBO(204, 0, 0, .6),
    600: const Color.fromRGBO(204, 0, 0, .7),
    700: const Color.fromRGBO(204, 0, 0, .8),
    800: const Color.fromRGBO(204, 0, 0, .9),
    900: const Color.fromRGBO(204, 0, 0, 1),
  };
  static MaterialColor primarySwatchColor = MaterialColor(0xFF00696A, color);

  static const Color theme = Color(0xFF3B1550);

  static const Color theme800 = Color(0xFF672E86);
  static const Color theme700 = Color(0xFF8630B6);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static Color whiteColorOpaque50 = const Color(0x80FFFFFF);
  static Color whiteColorOpaque80 = const Color(0xCCFFFFFF);
  static Color whiteColorOpaque30 = const Color(0x4DFFFFFF);
  static Color whiteColorOpaque10 = const Color(0x1AFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static Color blackColorOpaque80 = const Color(0xCC000000);
  static Color blackColorOpaque60 = const Color(0x99000000);
  static Color blackColorOpaque50 = const Color(0x80000000);
  static Color blackColorOpaque30 = const Color(0x4D000000);
  static Color blackColorOpaque10 = const Color(0x1A000000);
  static Color errorColor = const Color(0xFFC9252D);
  static Color errorColorOpaque10 = const Color(0x1AC9252D);
  static Color successColor = const Color(0xFF008069);
  static Color successColorOpaque10 = const Color(0x1A008069);
  static Color successColorOpaque20 = const Color(0x33008069);
  static Color infoColor = const Color(0xFF0D66D0);
  static Color infoColorOpaque10 = const Color(0x1A0D66D0);
  static Color warningColor = const Color(0xFFE78F00);
  static Color warningColorOpaque10 = const Color(0x1AE78F00);
  static Color lightBlackColor = const Color(0xFF2e2e2e);
  static Color unSelectedColor = const Color(0x808C8FA5);
  static Color hintTextColor = const Color(0xFF8C8FA5);
  static Color edBGColor = const Color(0xFFF7F8F8);
  static Color grayTextColor = const Color(0xFFADA4A5);
  static Color darkGrayTextColor = const Color(0xFF595D61);
  static Color unSelectedTextColor = const Color(0xFF595D61);
  static Color dividerColor = const Color(0xFFE7E9EC);
  static Color grayColor = const Color(0xFF808080);
  static Color gray999Color = const Color(0xFF999999);
  static Color gray66Color = const Color(0xFF666666);
  static Color grayFFFColor = const Color(0xFFF3F1F5);
  static Color lightGrayColor = const Color(0xFFE0E0E0);
  static Color brownishRedColor = const Color(0xFF8A0002);
  static Color onlineColor = const Color(0xFF16FF5C);
  static Color cardColor = const Color(0xFF004358);
  static Color greenColor = const Color(0xFF008000);
  static Color spinnerBGColor = const Color(0xFFf7f8f8);
  static Color spinnerHintTextColor = const Color(0xFFADA4A5);
  static Color cancelColor = const Color(0xFFF5F6FA);
  static Color cancelRedColor = const Color(0xFFcf142b);
  static Color bgCardGray = const Color(0xFFf6f5fa);
  static Color shimmerBaseColor = Colors.grey[300]!;
  static Color shimmerHighlightColor = Colors.grey[100]!;
  static Color shimmerViewColor = Colors.white;
  static Color transparentColor = Colors.transparent;
  static Color iconGreyColor = const Color(0xFF7b6f72);
  static Color randColor1 = const Color(0xFFCCCCFF);
  static Color randColor2 = const Color(0xFF6495ED);
  static Color randColor3 = const Color(0xFF40E0D0);
  static Color randColor4 = const Color(0xFFFF7F50);
  static Color randColor5 = const Color(0xFFFFBF00);
  static Color blueColor = const Color(0xFF575CE5);
  static Color randColor1Opacity = const Color(0x26CCCCFF);
  static Color randColor2Opacity = const Color(0x266495ED);
  static Color randColor3Opacity = const Color(0x2640E0D0);
  static Color randColor4Opacity = const Color(0x26FF7F50);
  static Color randColor5Opacity = const Color(0x26FFBF00);
  static Color tempColor = const Color(0xFF02025C);
  static Color tempColor1 = const Color(0xFFD9001D);
  static Color lightGrey = const Color(0xFFD6D6D6);
  static Color lightGray2 = const Color(0xFFF5F5F5);

  static Color webThemeColorOpaque5 = const Color(0x0D3B1550);
  static Color webThemeColorOpaque50 = const Color(0x803B1550);
  static Color webThemeColorOpaque15 = const Color(0x263B1550);
  static Color webThemeColorOpaque10 = const Color(0x1A3B1550);
  static const Color webThemeColorOpaque10Copy = Color(0x1A3B1550);
  static const Color webThemeColor = Color(0xFF3B1550);
  static Color webThemeColorOpaque80 = const Color(0xCC3B1550); // 80% opacity
  static Color webThemeColorOpaque60 = const Color(0x993B1550); // 60% opacity
  static Color webThemeColorOpaque40 = const Color(0x663B1550); // 40% opacity
  static Color webThemeColorOpaque20 = const Color(0x333B1550); // 20% opacity
  static Color webDarkThemeColor = const Color(0xFF250B33);
  static Color webSecondThemeColor = const Color(0xFFebf7f5);
  static Color webLightGrayColor = const Color(0xFFf7f8f9);
  static Color metalBlackColor = const Color(0xFF2C2C2B);
  static Color lightWhiteColor = const Color(0xF1ECECFF);
  static Color googleColor = const Color(0xFF4285F4);
  static Color facebookColor = const Color(0xFF1877F2);
  static Color twitterColor = const Color(0xFF00acee);
  static Color webThemeGradientDarkColor = const Color(0xFF4A154B);
  static Color webThemeGradientLightColor = const Color(0xFF83157B);
  static Color lineColor = const Color(0xFFD8D8D8);
  static Color lightPinkColor = const Color(0xFFFFF9FF);
  static Color grayC9Color = const Color(0xFFC9C9C9);
  static const Color grayDDColor = Color(0xFFDDDDDD);
  static Color grayEEColor = const Color(0xFFEEEEEE);
  static Color gray7979Color = const Color(0xFF797979);
  static Color popularDoctorBGColor = const Color(0xFFD4D2E3);
  static Color lightBlack1Color = const Color(0xFF111111);
  static Color lightBlack1ColorOpaque80 = const Color(0xCC111111);
  static Color lightBlack1ColorOpaque50 = const Color(0x80111111);
  static Color lightBlack1ColorOpaque10 = const Color(0x1A111111);
  static Color lightGrayEColor = const Color(0xFFEEEEEE);
  static Color testimonialsBGColor = const Color(0xFFFCE6F1);
  static Color practiceWithHelixDocBGColor = const Color(0xFFCED4E4);
  static Color careBGColor = const Color(0xFFF0EDF1);
  static Color grayF2Color = const Color(0xFFF2F0F3);
  static Color disableColor = const Color(0xFFF1F1F1);
  static Color bookSlotBGColor = const Color(0xFFD5CDD9);
  static Color reviewProgressColor = const Color(0xFFFFA500);
  static Color appointmentConformationBGColor = const Color(0xFFEBE7ED);
  static Color grayIconColor = const Color(0xFFBBBBBB);
  static Color stepProgressColor = const Color(0xFF008069);
  static Color redColor = const Color(0xFFFF0000);
  static Color statusRedColor = const Color(0xFFC91409);
  static const Color webBorderGrayColor = Color(0xFFDDDDDD);
  static Color webLightCancellationColor = const Color(0xFFf4E3E7);
  static Color dashboardBGColor = const Color(0xFFF3F1F4);
  static Color activeColor = const Color(0xFF008069);
  static Color activeColorOpacity15 = const Color(0x26008069);
  static Color accessRevokedColor = const Color(0xFFDA0000);
  static Color accessRevokedColorOpacity15 = const Color(0x26DA0000);
  static Color externalColor = const Color(0xFF008BCC);
  static Color externalColorOpacity15 = const Color(0x26008BCC);
  static Color externalColorOpacity20 = const Color(0x32008BCC);
  static Color gray99Color = const Color(0x26008BCC);
  static Color pendingColor = const Color(0xFFFFA500);
  static Color pendingColorOpacity20 = const Color(0x32FFA500);
  static Color approvedColor = const Color(0xFF008069);
  static Color color008BCC = const Color(0xFF008BCC);
  static Color color008BCCOpaque30 = const Color(0x4D008BCC);
  static Color approvedColorOpacity20 = const Color(0x32008069);
  static Color generalColorOpacity20 = const Color(0x32008BCC);
  static Color cancelledColor = const Color(0xFFFF1F00);
  static Color cancelledOpacity20 = const Color(0x32FF1F00);
  static Color titleBGColor = const Color(0xFFE1DBE5);
  static Color colorD9ECE9 = const Color(0xFFD9ECE9);
  static Color color008069 = const Color(0xFF008069);
  static Color goodReviewColor = const Color(0xFF008069);
  static Color mediumReviewColor = const Color(0xFFFFA500);
  static Color badReviewColor = const Color(0xFFFF3A44);
  static Color tableHeaderColor = const Color(0xFFF5F3F6);
  static Color blackColor333 = const Color(0xFF333333);

  static Color sentStatusColor = const Color(0xFF008069);
  static Color pendingStatusColor = const Color(0xFFC98200);
  static Color sentStatusColorOpacity20 = const Color(0x32008069);
  static Color failStatusColor = const Color(0xFFFF5C00);
  static Color failStatusColorOpacity20 = const Color(0x32FF5C00);

  static Color priorityEmergencyColor = const Color(0xFFFF0000);
  static Color priorityHighestColor = const Color(0xFFFF5C00);
  static Color priorityMediumColor = const Color(0xFF008BCC);
  static Color grayD9Color = const Color(0xFFD9D9D9);
  static Color lightBlack44Color = const Color(0xFF444444);
  static Color darkBlueColorOpaque10 = const Color(0x1A0D66D0);
  static Color darkBlueColorOpaque30 = const Color(0x4D0D66D0);
  static Color darkBlueColor = const Color(0xFF0D66D0);

  static Color availableColor = const Color(0xFFFFE7D9);
  static Color availableTextColor = const Color(0xFFB45309);
  static Color notAvailableColorOpaque10 = const Color(0x1ABE123C);
  static Color notAvailableColor = const Color(0xFFBE123C);
  static Color skyBlueColor = const Color(0xFF0D66D0);
  static Color skyBlueColor30 = const Color(0x4D0D66D0);
  static Color skyBlueColor10 = const Color(0x1A0D66D0);
  static Color uploadMultipleColor = const Color(0xFFFDCA85);
  static Color uploadMultipleColor50 = const Color(0x80FDCA85);
  static Color purple = const Color(0xFF57167E);
  static Color vividPink = const Color(0xFFEA5F89);
  static Color deepPinkColor = const Color(0xFFC02DA5);

  static Color validationColor = const Color(0xFF0D66D0);
  static Color validationColor10 = const Color(0x1A0D66D0);
  static Color grayColor10 = const Color(0x1A808080);
  static Color resetPasswordColor = const Color(0xFFFCAC4D);
  static Color resetPasswordColor2 = const Color(0xFFFCEED7);
  static Color dialogBg = const Color(0xFFDAE8F8);
  static Color grayA0Color = const Color(0xFFA0A0A0);
  static Color primaryTagBG = const Color(0xffBBDEFB);

  static Color webThemeColorOpaque30 = const Color(0x4D3B1550);
  static Color pendingStatus = const Color(0x33FF5C00);
  static Color pendingStatusText = const Color(0xffFF5C00);
  static Color appointmentStatusButton = const Color(0x1A008BCC);
  static Color appointmentStatusButtonText = const Color(0xff008BCC);
  static Color appointmentStatusButton2Text = const Color(0xff008069);
  static Color statusDropDownCheckedInColor = const Color(0xffE49400);
  static Color lightBlack1ColorOpaque70 = const Color(0xB3111111);

  static Color lightGrayColorOpaque50 = const Color(0x80EEEEEE);
  static Color dottedBorderColor = const Color(0xffB5B5B5);
  static Color statusDropDownCheckedInColor50 = const Color(0x80E49400);
  static Color statusDropDownCheckedInColor10 = const Color(0x1AE49400);

  static Color blackColorOpaque70 = const Color(0xB2000000);

  static Color grayColorF9F9F9 = const Color(0xffF9F9F9);
  static Color grayColorF6F6F6 = const Color(0xffF6F6F6);
  static Color grayColorD3D3D3 = const Color(0xffD3D3D3);

  static Color failStatusColorOpacity15 = const Color(0x26FF5C00);
  static Color bmiChartColor = const Color(0xff7D3F98);
  static Color weightChartColor = const Color(0xff013BA3);
  static Color glucoseLevelChartColor = const Color(0xffEC6666);
  static Color bloodCountChartColor = const Color(0xff0094A8);
  static Color grayD0D0D0Color = const Color(0xffD0D0D0);
  static Color brownLightColor = const Color(0xffF9520A);

  static Color greyColorOpaque20 = const Color(0x33999999);

  static Color suggestionColor = const Color(0xff4B2F00);
  static Color warningColorOpaque20 = const Color(0x33E78F00);
  static Color labStatusColor = const Color(0xffC80C00);
  static Color purpleBlue = const Color(0xff8630B6);

  static Color hexToColor(String code) {
    try {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      e.printError();
      return const Color(0xff3B1550);
    }
  }

  static Color greenRadialGaugeColor = const Color(0xFF1ABC9C);
  static Color yellowRadialGaugeColor = const Color(0xFFFFB225);
  static Color redRadialGaugeColor = const Color(0xFFFF3845);
  static Color blueRevenueChartColor = const Color(0xFF0C6DFF);
  static Color pieChartVioletColor = const Color(0xFF9B3192);
  static Color pieChartDeceasedColor = const Color(0xFFEA7E5D);
  static Color pieChartRefillBlueColor = const Color(0xFF6CAAE3);
  static Color pieChartDarkCerulean = const Color(0xFF0A3F76);
  static Color pieChartSiennaColor = const Color(0xFFEA7E5D);
  static Color pieChartDarkBlue = const Color(0xFF6CAAE3);
  static Color pieChartTrendyPink = const Color(0xFF80619B);
  static Color pieChartPinkDaisy = const Color(0xFFE19B95);
  static Color pieChartPinkishRed = const Color(0xFFE93A56);
  static Color pieChartRescheduledColor = const Color(0xFFC0CF8B);

  static Color pieChartInternalReferralColor = const Color(0xFF3498DB);
  static Color pieChartExternalReferralColor = const Color(0xFF9D57D5);
  static Color pieChartExternalReferralYellowishColor = const Color(0xFFFEAB00);
  static Color pieChartLeackageReferralColor = const Color(0xFFC893FD);
  static Color pieChartLeackageReferralBlueishColor = const Color(0xFF4A3AFF);

  static Color warningDialogBgColor = const Color(0xFFFFF3DE);
  static Color blackColorCC1E1B39 = const Color(0xCC1E1B39);
  static Color blackColorff1E1B39 = const Color(0xFF1E1B39);
  static Color externalStatusColor = const Color(0xFFFF5C00);
  static Color riskScoreHighColor = const Color(0xFFD40000);
  static Color riskScoreModerateColor = const Color(0xFFE29200);
  static Color riskScoreLowColor = const Color(0xFF0071BC);
  static Color satisfiedColor = const Color(0xFF0DD8B0);
  static Color neutralColor = const Color(0xFFF9B72F);
  static Color unSatisfiedColor = const Color(0xFFF9909F);
  static Color veryUnSatisfiedColor = const Color(0xFFFA586C);
  static Color readOnlyDataBgColor = const Color(0xFFF8F8F8);

  static Color fileUploadInProgressColor = const Color(0xFF0863cf);
  static Color fileUploadInDoneColor = const Color(0xFF007a62);
  static Color fileUploadFailedColor = const Color(0xFFfcf3f3);
  static Color infoDialogTextColor = const Color(0xFF002D63);
  static Color participantAvtarColor = const Color(0xFFECE8EE);
  static Color lightBlack1Color60 = const Color(0x99111111);

  static String getColorCode(Color colorCode) =>
      '#${colorCode.value.toRadixString(16).substring(2, 8).toUpperCase()}';

  static Color getColorFromCode(String colorCode) {
    String hex = colorCode.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  static Color patientInsuranceOutCardBgColor = const Color(0xFFF7EFFF);
  static Color patientInsuranceOutCardValueColor = const Color(0xFF380071);
  static Color patientPatientOutCardBgColor = const Color(0xFFEFF0FF);
  static Color patientPatientOutCardValueColor = const Color(0xFF050C7D);
  static Color patientPatientPaidCardBgColor = const Color(0xFFEAF3FF);
  static Color patientPatientPaidCardValueColor = const Color(0xFF00295E);
  static Color patientOldestDOSCardBgColor = const Color(0xFFFFEFF3);
  static Color patientOldestDOSCardValueColor = const Color(0xFF690014);
  static Color patientWalletBalanceCardBgColor = const Color(0xFFFFF2FF);
  static Color patientWalletBalanceCardValueColor = const Color(0xFF4D044D);
  static Color xf0707007 = const Color(0xFF070707);
  static Color xfE1E4EA = const Color(0xFFE1E4EA);
}
