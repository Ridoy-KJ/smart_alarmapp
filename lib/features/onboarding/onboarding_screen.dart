import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:smart_alarmapp/constants/app_colors.dart';
import 'package:smart_alarmapp/constants/text_styles.dart';
import 'package:smart_alarmapp/constants/image_paths.dart';

/// OnboardingScreen displays 3 swipeable pages with videos, headings, and descriptions.
/// It includes a Skip button (top-right), page indicators, and a Next/Get Started button.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define onboarding content for each page
  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      videoPath: ImagePaths.onboardingVideo1,
      heading: "Discover the world, one\njourney at a time.",
      body:
      "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.",
    ),
    _OnboardingPageData(
      videoPath: ImagePaths.onboardingVideo2,
      heading: "Explore new horizons, one step at a time.",
      body:
      "Every step holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.",
    ),
    _OnboardingPageData(
      videoPath: ImagePaths.onboardingVideo3,
      heading: "See the beauty, one journey at a time.",
      body:
      "Travel made simple and exciting—discover places you'll love and moments you'll never forget.",
    ),
  ];

  // Navigate to next page or location screen
  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/location');
    }
  }

  // Skip onboarding entirely
  void _onSkip() {
    Navigator.pushReplacementNamed(context, '/location');
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 360.0;
    double px(double v) => v * scale;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // PageView for swipeable onboarding pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _OnboardingPage(
                    data: page,
                    scale: scale,
                    onSkip: _onSkip,
                  );
                },
              ),
            ),

            // Page indicators + Next/Get Started button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: px(24), vertical: px(20)),
              child: Column(
                children: [
                  // Page indicators (dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: px(4)),
                        width: _currentPage == index ? px(16) : px(8),
                        height: px(8),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF5200FF) // Active dot
                              : const Color(0x335200FF), // Inactive dot (20% opacity)

                          borderRadius: BorderRadius.circular(px(4)),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: px(20)),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: px(56),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(px(69)),
                        ),
                      ),
                      onPressed: _onNext,
                      child: Text(
                        _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for each onboarding page
class _OnboardingPageData {
  final String videoPath;
  final String heading;
  final String body;

  _OnboardingPageData({
    required this.videoPath,
    required this.heading,
    required this.body,
  });
}

/// Widget for a single onboarding page
class _OnboardingPage extends StatefulWidget {
  final _OnboardingPageData data;
  final double scale;
  final VoidCallback onSkip;

  const _OnboardingPage({
    required this.data,
    required this.scale,
    required this.onSkip,
  });

  @override
  State<_OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<_OnboardingPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.data.videoPath)
      ..initialize().then((_) {
        if (mounted) setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(1.0);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final px = (double v) => v * widget.scale;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // Video section with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(px(32)),
                child: Container(
                  width: px(360),
                  height: px(429),
                  color: Colors.black,
                  child: _videoController.value.isInitialized
                      ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),

              SizedBox(height: px(24)),

              // Heading and body text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: px(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.heading,
                      style: AppTextStyles.display.copyWith(
                        fontSize: 24 * widget.scale,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: px(12)),
                    Text(
                      widget.data.body,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14 * widget.scale,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Skip button positioned top-right over video
        Positioned(
          top: px(16),
          right: px(16),
          child: TextButton(
            onPressed: widget.onSkip,
            child: Text(
              "Skip",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Oxygen',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.0,
                color: Colors.white,
              ),
            )
            ,
          ),
        ),
      ],
    );
  }
}
