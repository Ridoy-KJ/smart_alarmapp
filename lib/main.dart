import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// App-wide constants and screens
import 'package:smart_alarmapp/constants/app_colors.dart';
import 'package:smart_alarmapp/features/home/home_screen.dart';
import 'package:smart_alarmapp/features/location/location_screen.dart';
import 'package:smart_alarmapp/features/onboarding/onboarding_screen.dart';

// ViewModels (state management)
import 'package:smart_alarmapp/features/location/location_viewmodel.dart'; // ✅ Location screen logic
import 'package:smart_alarmapp/features/home/home_viewmodel.dart';         // ✅ Home screen logic

// Timezone setup for scheduling alarms
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  // Ensures all bindings are initialized before async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data for scheduling notifications
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Dhaka')); // ✅ You can dynamically detect this later

  // Check if onboarding has been completed (stored in SharedPreferences)
  final prefs = await SharedPreferences.getInstance();
  final bool hasCompletedOnboarding = prefs.getBool('hasCompletedOnboarding') ?? false;

  // Launch the app with onboarding state passed in
  runApp(MyApp(hasCompletedOnboarding: hasCompletedOnboarding));
}

class MyApp extends StatelessWidget {
  final bool hasCompletedOnboarding;

  const MyApp({super.key, required this.hasCompletedOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ Provide LocationViewmodel globally so LocationScreen can access it
        ChangeNotifierProvider(create: (_) => LocationViewModel()),

        // ✅ Provide HomeViewmodel globally so HomeScreen can access it
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
          fontFamily: 'Inter', // ✅ Global font setting
        ),

        // ✅ Route based on onboarding status
        initialRoute: hasCompletedOnboarding ? '/location' : '/onboarding',

        // ✅ Define app routes
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/location': (context) => const LocationScreen(),
          '/home': (context) =>  HomeScreen(),
        },
      ),
    );
  }
}
