import 'package:flutter/material.dart';

import '../../routes/routes.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(
          currentRouteName: Routes.profile.name,
        ),
      );
}
