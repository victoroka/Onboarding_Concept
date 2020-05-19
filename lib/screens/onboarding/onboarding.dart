import 'dart:math';
import 'package:flutter/material.dart';
import 'package:onboarding_concept/constants.dart';
import 'package:onboarding_concept/screens/login/login.dart';
import 'package:onboarding_concept/screens/onboarding/pages/community/index.dart';
import 'package:onboarding_concept/screens/onboarding/pages/education/education_dark_card_content.dart';
import 'package:onboarding_concept/screens/onboarding/pages/education/education_light_card_content.dart';
import 'package:onboarding_concept/screens/onboarding/pages/education/index.dart';
import 'package:onboarding_concept/screens/onboarding/pages/onboarding_page.dart';
import 'package:onboarding_concept/screens/onboarding/pages/work/index.dart';
import 'package:onboarding_concept/screens/onboarding/widgets/header.dart';
import 'package:onboarding_concept/screens/onboarding/widgets/next_page_button.dart';
import 'package:onboarding_concept/screens/onboarding/widgets/onboarding_page_indicator.dart';

class Onboarding extends StatefulWidget {
  final double screenHeight;

  const Onboarding({
    @required this.screenHeight,
  }) : assert(screenHeight != null);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  AnimationController _cardsAnimationController;
  AnimationController _pageIndicatorAnimationController;

  Animation<Offset> _slideAnimationLightCard;
  Animation<Offset> _slideAnimationDarkCard;
  Animation<double> _pageIndicatorAnimation;

  int _current_page = 1;

  bool get isFirstPage => _current_page == 1;

  void initState() {
    super.initState();
    _cardsAnimationController = AnimationController(
      vsync: this,
      duration: kCardAnimationDuration,
    );

    _pageIndicatorAnimationController = AnimationController(
      vsync: this,
      duration: kButtonAnimationDuration,
    );

    _setCardsSlideOutAnimation();
    _setPageIndicatorAnimation();
  }

  @override
  void dispose() {
    _cardsAnimationController.dispose();
    _pageIndicatorAnimationController.dispose();
    super.dispose();
  }

  Widget _getPage() {
    switch (_current_page) {
      case 1:
        return OnboardingPage(
          number: 1,
          lightCardChild: CommunityLightCardContent(),
          darkCardChild: CommunityDarkCardContent(),
          textColumn: CommunityTextColumn(),
          lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
        );
      case 2:
        return OnboardingPage(
          number: 2,
          lightCardChild: EducationLightCardContent(),
          darkCardChild: EducationDarkCardContent(),
          textColumn: EducationTextColumn(),
          lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
        );
      case 3:
        return OnboardingPage(
          number: 3,
          lightCardChild: WorkLightCardContent(),
          darkCardChild: WorkDarkCardContent(),
          textColumn: WorkTextColumn(),
          lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
        );
      default:
        throw Exception('Page with number $_current_page does not exist.');
    }
  }

  void _setCardsSlideInAnimation() {
    setState(() {
      _slideAnimationLightCard = Tween<Offset>(
        begin: Offset(3.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOut,
      ));
      _slideAnimationDarkCard = Tween<Offset>(
        begin: Offset(1.5, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOut,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setCardsSlideOutAnimation() {
    setState(() {
      _slideAnimationLightCard = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-3.0, 0.0),
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeIn,
      ));
      _slideAnimationDarkCard = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-1.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeIn,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
    var multiplicator = isClockwiseAnimation ? 2 : -2;

    setState(() {
      _pageIndicatorAnimation = Tween(
        begin: 0.0,
        end: multiplicator * pi,
      ).animate(
        CurvedAnimation(
          parent: _pageIndicatorAnimationController,
          curve: Curves.easeIn,
        ),
      );
      _pageIndicatorAnimationController.reset();
    });
  }

  void _goToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Login(),
      ),
    );
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _current_page = nextPageNumber;
    });
  }

  Future<void> _nextPage() async {
    switch (_current_page) {
      case 1:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          await _cardsAnimationController.forward();
          _setNextPage(2);
          _setCardsSlideInAnimation();
          await _cardsAnimationController.forward();
          _setCardsSlideOutAnimation();
          _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 2:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          await _cardsAnimationController.forward();
          _setNextPage(3);
          _setCardsSlideInAnimation();
          await _cardsAnimationController.forward();
        }
        break;
      case 3:
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          _goToLogin();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingL),
          child: Column(
            children: <Widget>[
              Header(
                onSkip: _goToLogin,
              ),
              Expanded(
                child: _getPage(),
              ),
              AnimatedBuilder(
                animation: _pageIndicatorAnimation,
                child: NextPageButton(
                  onPressed: _nextPage,
                ),
                builder: (_, Widget child) {
                  return OnboardingPageIndicator(
                    angle: _pageIndicatorAnimation.value,
                    currentPage: _current_page,
                    child: child,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
