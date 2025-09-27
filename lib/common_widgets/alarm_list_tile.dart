import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_alarmapp/constants/app_colors.dart';
import 'package:smart_alarmapp/constants/text_styles.dart';
import 'package:smart_alarmapp/features/home/alarm_model.dart';

class AlarmListTile extends StatelessWidget {
  final AlarmModel alarm;
  final ValueChanged<bool> onToggle;

  const AlarmListTile({
    super.key,
    required this.alarm,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // compute semi-transparent secondary using withAlpha instead of withOpacity
    final Color secondaryHalf = AppColors.secondary.withAlpha((0.5 * 255).round());

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: alarm.isEnabled ? AppColors.secondary : secondaryHalf,
        borderRadius: BorderRadius.circular(15),
        boxShadow: alarm.isEnabled
            ? [
          BoxShadow(
            color: AppColors.primary.withAlpha((0.3 * 255).round()),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left column: time + date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('hh:mm a').format(alarm.time),
                style: AppTextStyles.alarmTime.copyWith(
                  color: alarm.isEnabled ? Colors.white : Colors.grey,
                  decoration:
                  alarm.isEnabled ? TextDecoration.none : TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('EEE dd MMM yyyy').format(alarm.time),
                style: AppTextStyles.bodyText1.copyWith(
                  color: alarm.isEnabled ? AppColors.textFaded : Colors.grey[600],
                ),
              ),
            ],
          ),

          // Toggle Switch (use newer properties)
          Switch(
            value: alarm.isEnabled,
            onChanged: onToggle,
            activeThumbColor: Colors.white, // active thumb color
            activeTrackColor: AppColors.primary.withAlpha((0.8 * 255).round()),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
