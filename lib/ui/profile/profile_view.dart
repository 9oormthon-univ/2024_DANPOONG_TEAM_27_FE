import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileState state = ref.watch(profileViewModelProvider);
    final ProfileViewModel viewModel =
        ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('/tutorial'),
      ),
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
              if (state.loadingProfile == LoadingStatus.success)
                ProfileInfoWidget(
                  day: state.day,
                  gender: state.gender,
                  month: state.month,
                  hour: state.hour,
                  minute: state.minute,
                  unknownTime: state.unknownTime,
                  year: state.year,
                )
              else
                const SizedBox(height: 36.0),
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
