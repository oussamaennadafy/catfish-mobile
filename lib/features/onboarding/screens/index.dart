import 'package:catfish_mobile/features/onboarding/data/onboarding_content.dart';
import 'package:catfish_mobile/features/onboarding/widgets/animated_dots.dart';
import 'package:catfish_mobile/features/onboarding/widgets/content_card.dart';
import 'package:catfish_mobile/routes/constants/app_screens.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/shared/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingStateScreen();
}

class _OnBoardingStateScreen extends State<OnBoardingScreen> with SingleTickerProviderStateMixin {
  int _selectedDot = 0;
  late AnimationController contentAnimationController;

  @override
  void initState() {
    super.initState();

    contentAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: onboardingContentList.length.toDouble(),
    );
  }

  void handleNextPress() {
    if (_selectedDot >= onboardingContentList.length - 1) {
      context.go(AppScreens.callHub);
      return;
    }
    setState(() {
      _selectedDot++;
    });
    contentAnimationController.animateTo(
      _selectedDot.toDouble(),
      curve: Curves.easeInOut,
    );
  }

  void handleSkipPress() {
    context.go(AppScreens.callHub);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Spacer(flex: 4),
            Center(
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.hardEdge,
              physics: NeverScrollableScrollPhysics(),
              child: AnimatedBuilder(
                animation: contentAnimationController,
                child: Row(
                  children: [
                    for (var i = 0; i < onboardingContentList.length; i++)
                      ContentCard(
                        item: onboardingContentList[i],
                      ),
                  ],
                ),
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(-(contentAnimationController.value * (MediaQuery.of(context).size.width - 18 * 2)), 0),
                    child: child,
                  );
                },
              ),
            ),
            AnimatedDots(
              numOfDots: onboardingContentList.length,
              selectedDot: _selectedDot,
            ),
            Spacer(
              flex: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SecondaryButton(
                  text: "Skip",
                  onPress: handleSkipPress,
                ),
                PrimaryButton(
                  text: "Next",
                  icon: Icons.chevron_right,
                  onPress: handleNextPress,
                )
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
