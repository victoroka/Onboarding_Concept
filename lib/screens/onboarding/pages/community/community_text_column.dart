import 'package:flutter/material.dart';
import 'package:onboarding_concept/screens/onboarding/widgets/text_column.dart';

class CommunityTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Community',
      text: 'Some cool text about the community page goes here, \nas part of the layout!',
    );
  }
}
