import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_alarmapp/constants/image_paths.dart';

class OnboardingViewmodel with ChangeNotifier {
  final PageController pageController = PageController();
  
  // Updated data to use video paths
  final List<Map<String, String>> onboardingData = [
    {
      'video': ImagePaths.onboardingVideo1,
      'title': 'Discover the world, one journey at a time.',
      'description':
          'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
    },
    {
      'video': ImagePaths.onboardingVideo2,
      'title': 'Explore new horizons, one step at a time.',
      'description':
          'Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.',
    },
    {
      'video': ImagePaths.onboardingVideo3,
      'title': 'See the beauty, one journey at a time.',
      'description':
          'Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.',
    },
  ];

  bool isLastPage = false;

  void onPageChanged(int index) {
    isLastPage = index == onboardingData.length - 1;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedOnboarding', true);
  }

  void dispose() {
    pageController.dispose();
  }
}
