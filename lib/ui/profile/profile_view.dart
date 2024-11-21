import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../common/widgets/rounded_grey_text_widget.dart';
import 'profile_state.dart';
import 'profile_view_model.dart';
import 'widgets/profile_description_text_widget.dart';
import 'widgets/profile_goal_archiving_widget.dart';
import 'widgets/profile_graph_widget.dart';
import 'widgets/profile_info_widget.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final ProfileState state = ref.watch(profileViewModelProvider);
    final ProfileViewModel viewModel = ref.read(profileViewModelProvider.notifier);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(
          currentRouteName: Routes.profile.name,
        ),
        backgroundColor: LuckitColors.background,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 52.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const ProfileInfoWidget(),
                const ProfileGraphWidget(),
                const ProfileDescriptionTextWidget(),
                ProfileGoalArchivingWidget(
                  opened: state.opened,
                  onTap: viewModel.toggleGoalArchiving,
                ),
              ],
            ),
          ),
        ),
      );
  }
}
