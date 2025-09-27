import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';
import '../location/location_viewmodel.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../common_widgets/alarm_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();

    final scale = MediaQuery.of(context).size.width / 360.0;
    double px(double v) => v * scale;

    final locationVM = context.watch<LocationViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Selected Location Box
            Text("Selected Location", style: AppTextStyles.headliner),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  //  Custom location icon
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

                  //  Location text
                  Expanded(
                    child: Text(
                      locationVM.currentAddress ?? "No location selected",
                      style: AppTextStyles.body,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            ),

            const SizedBox(height: 32),

            // 🔹 Alarm List
            Text("Alarms", style: AppTextStyles.headliner),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: homeVM.alarms.length,
                itemBuilder: (context, index) {
                  final alarm = homeVM.alarms[index];
                  return AlarmListTile(
                    alarm: alarm,
                    onToggle: (value) => homeVM.toggleAlarm(index, value),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //  Floating Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(), // circular shape
        onPressed: () async {
          final TimeOfDay? t = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
          );
          if (t != null) {
            final now = DateTime.now();
            final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
            context.read<HomeViewModel>().addAlarm(dt);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

    );
  }
}
