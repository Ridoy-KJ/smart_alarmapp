import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../constants/image_paths.dart';
import 'location_viewmodel.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LocationViewModel>();

    final scale = MediaQuery.of(context).size.width / 360.0;
    double px(double v) => v * scale;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: px(24), vertical: px(32)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heading and description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome! Your Smart Travel Alarm",
                        style: AppTextStyles.headliner,
                      ),
                      SizedBox(height: px(12)),
                      Text(
                        "Stay on schedule and enjoy every moment of your journey.",
                        style: AppTextStyles.subhead,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: px(70)),

                // Circular image
                Container(
                  width: px(296),
                  height: px(296),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(ImagePaths.locationAccess),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: px(80)),

                // Use Current Location button
                SizedBox(
                  width: double.infinity,
                  height: px(56),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(px(57)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: px(16)),
                    ),
                    onPressed: () async {
                      await vm.requestAndGetLocation();
                      if (vm.currentAddress != null && mounted) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(vm.errorMessage.isNotEmpty
                                ? vm.errorMessage
                                : "Unable to get location"),
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // location icon container
                        Container(
                          width: px(14),
                          height: px(16),
                          margin: EdgeInsets.only(right: px(8)),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(px(4)),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),

                        // Button label
                        Text(
                          "Use Current Location",
                          style: AppTextStyles.iconLabel,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: px(16)),

                // Home button
                SizedBox(
                  width: double.infinity,
                  height: px(56),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(px(57)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      'Home',
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
