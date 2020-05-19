import 'package:flutter/material.dart';
import 'package:onboarding_concept/constants.dart';
import 'package:onboarding_concept/screens/login/widgets/custom_button.dart';
import 'package:onboarding_concept/screens/login/widgets/custom_text_field.dart';
import 'package:onboarding_concept/screens/login/widgets/fade_slide_transition.dart';

class LoginForm extends StatelessWidget {
  final Animation<double> animation;

  const LoginForm({
    @required this.animation,
  }) : assert(animation != null);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: CustomTextField(
              label: 'username or email',
              icon: Icons.person,
              obscureText: true,
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: space,
            child: CustomTextField(
              label: 'password',
              icon: Icons.lock,
              obscureText: true,
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: space * 2,
            child: CustomButton(
              color: kBlue,
              textColor: kWhite,
              text: 'Login to continue',
              onPressed: () {},
            ),
          ),
          SizedBox(height: space * 2),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: space * 3,
            child: CustomButton(
              color: kWhite,
              textColor: kBlack.withOpacity(0.5),
              text: 'Continue with Google',
              image: Image(
                image: AssetImage(kGoogleLogoPath),
                height: 48.0,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: space * 4,
            child: CustomButton(
              color: kBlack,
              textColor: kWhite,
              text: 'Create a Bubble Account',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
