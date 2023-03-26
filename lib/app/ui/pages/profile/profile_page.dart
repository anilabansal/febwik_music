import 'package:flutter/material.dart';

import '../../../config/dimensions.dart';
import '../../../config/widgets/background/custom_background.dart';
import '../../../config/widgets/small_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SmallText(
              text: 'ProfilePage is working',
              size: Dimensions.font18,
            ),
          ),
        ),
      ),
    );
  }
}
