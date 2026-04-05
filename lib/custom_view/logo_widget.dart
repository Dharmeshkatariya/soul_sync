import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/assets_icons.dart';
import 'package:soul_sync/custom_view/custom_asset_image.dart';
import 'package:soul_sync/custom_view/custom_gesture_detector.dart';

import '../core/routes/routes.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, this.onTapLogo});

  final Function()? onTapLogo;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
        if (onTapLogo != null) {
          onTapLogo!();
        } else {
          Get.toNamed(Routes().managerDashboard);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.h),
        child: CustomAssetImage(path: AssetsIcons.icAppLogo),
      ),
    );
  }
}

// class LogoWidget extends StatefulWidget {
//   LogoWidget({this.width, this.onTapLogo, super.key});
//
//   final double? width;
//   Function()? onTapLogo;
//
//   @override
//   State<LogoWidget> createState() => _LogoWidgetState();
// }
//
// class _LogoWidgetState extends State<LogoWidget> {
//   var logoPhotoFileBytes = Rx<Uint8List>(Uint8List(0));
//   Widget? cachedSvgWidget;
//
//   @override
//   void initState() {
//     getSystemData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (logoPhotoFileBytes.value != null && logoPhotoFileBytes.value!.isNotEmpty) {
//         return CustomGestureDetector(
//           semanticsLabel: 'Logo',
//           onTap: widget.onTapLogo,
//           child: isSvgImage(logoPhotoFileBytes.value!)
//               ? (cachedSvgWidget ??= buildLogoSvg(logoPhotoFileBytes.value))
//               : Image.memory(
//             logoPhotoFileBytes.value!,
//             width: widget.width ?? 152.w,
//             errorBuilder: (context, exception, stackTrace) => SizedBox(width: widget.width ?? 152.w),
//           ),
//         );
//       } else {
//         return SizedBox(width: widget.width ?? 152.w);
//       }
//     });
//   }
//
//   getLogoImage(String? file) async {
//     var byte = await ApiServices().getImageByteFromUrl(url: file ?? "");
//
//     return byte;
//   }
//
//   getSystemData() async {
//     String storedData = await SharedPref().getStringPref(SharedPref().keySystemSettingData);
//     if (storedData.isNotEmpty) {
//       SystemSettingModel decodedData = SystemSettingModel.fromJson(json.decode(storedData));
//       try {
//         logoPhotoFileBytes.value = await getLogoImage(decodedData.data!.logoDetails!.file!);
//       } catch (e) {
//         Common().printLog('Logo Widget getSystemData: ', e.toString());
//       }finally {
//         // Assign transparent image if no valid data is loaded
//         logoPhotoFileBytes.value ??= Uint8List(0);
//       }
//     }
//   }
//
//   Future<Widget> _loadSvgImage(Uint8List svgBytes) async {
//     try {
//       return SvgPicture.memory(svgBytes, width: widget.width ?? 152.w,
//         placeholderBuilder: (context) {
//         return placeholderImageWidget();
//       },);
//     } catch (e) {
//       debugPrint('Invalid SVG data: $e');
//       throw Exception('Invalid SVG data');
//     }
//   }
//
//   Widget buildLogoSvg(Uint8List? svgBytes) {
//     if (svgBytes == null || svgBytes.isEmpty) return SizedBox(width: widget.width ?? 152.w, child: Image.asset(AssetsIcons.icLogoWebsite),);
//     return FutureBuilder<Widget>(
//       future: cachedSvgWidget == null ? _loadSvgImage(svgBytes) : Future.value(cachedSvgWidget),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             debugPrint('Error loading SVG: ${snapshot.error}');
//             return placeholderImageWidget();
//           }
//           return snapshot.data ?? placeholderImageWidget();
//         } else {
//           return placeholderImageWidget();
//         }
//       },
//     );
//   }
//
//   Widget placeholderImageWidget() {
//     return SizedBox(width: widget.width ?? 152.w, child: Image.asset(AssetsIcons.icLogoWebsite),);
//   }
//
//   bool isSvgImage(Uint8List data) {
//     final String header = String.fromCharCodes(data);
//     return header.contains('<svg') || header.contains('<?xml');
//   }
// }
