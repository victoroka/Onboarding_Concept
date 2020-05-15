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
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _current_page = 1;

  bool get isFirstPage => _current_page == 1;

  Widget _getPage() {
    switch (_current_page) {
      case 1:
        return OnboardingPage(
          number: 1,
          lightCardChild: CommunityLightCardContent(),
          darkCardChild: CommunityDarkCardContent(),
          textColumn: CommunityTextColumn(),
        );
      case 2:
        return OnboardingPage(
          number: 2,
          lightCardChild: EducationLightCardContent(),
          darkCardChild: EducationDarkCardContent(),
          textColumn: EducationTextColumn(),
        );
      case 3:
        return OnboardingPage(
          number: 3,
          lightCardChild: WorkLightCardContent(),
          darkCardChild: WorkDarkCardContent(),
          textColumn: WorkTextColumn(),
        );
      default:
        throw Exception('Page with number $_current_page does not exist.');
    }
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

  void _nextPage() {
    switch (_current_page) {
      case 1:
        _setNextPage(2);
        break;
      case 2:
        _setNextPage(3);
        break;
      case 3:
        _goToLogin();
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
              OnboardingPageIndicator(
                currentPage: _current_page,
                child: NextPageButton(
                  onPressed: _nextPage,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
