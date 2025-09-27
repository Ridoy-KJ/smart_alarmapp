import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core screens
import 'package:smart_alarmapp/features/onboarding/onboarding_screen.dart';
import 'package:smart_alarmapp/features/location/location_screen.dart';
import 'package:smart_alarmapp/features/home/home_screen.dart';

// ViewModels for state management
import 'package:smart_alarmapp/features/location/location_viewmodel.dart';
import 'package:smart_alarmapp/features/home/home_viewmodel.dart';

// App-wide constants
import 'package:smart_alarmapp/constants/app_colors.dart';

// Timezone setup for scheduling notifications
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Local notifications plugin
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // Ensure Flutter bindings are initialized before any async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data for accurate alarm scheduling
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Dhaka')); // You can make this dynamic later

  // Load onboarding completion status from local storage
  final prefs = await SharedPreferences.getInstance();
  final bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;

  // Launch the app with onboarding state passed to the root widget
  runApp(MyApp(hasCompletedOnboarding: hasCompletedOnboarding));
}

class MyApp extends StatelessWidget {
  final bool hasCompletedOnboarding;

  const MyApp({super.key, required this.hasCompletedOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide location logic globally
        ChangeNotifierProvider(create: (_) => LocationViewModel()),

        // Provide alarm logic globally
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Alarm',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.primary,
          fontFamily: 'Inter',
        ),

        // Route based on onboarding completion
        initialRoute: hasCompletedOnboarding ? '/location' : '/onboarding',

        // Define app routes
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/location': (context) => const LocationScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
