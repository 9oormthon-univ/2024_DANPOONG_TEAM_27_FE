import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../service/app/app_service.dart';
import '../../service/my_info/my_info_service.dart';
import '../../service/my_info/my_info_state.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../home/widget/mission_complete_dialog.dart';
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
      ref.read(profileViewModelProvider.notifier).initProfileView();
      // ..getCurrentDate()
      // ..getProfile()
      // ..getCompleteGoalList()
      // ..getSpotList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyInfoState infoState = ref.watch(myInfoServiceProvider);
    final ProfileState state = ref.watch(profileViewModelProvider);
    final ProfileViewModel viewModel =
        ref.read(profileViewModelProvider.notifier);
    final AppService appService = ref.read(appServiceProvider.notifier);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.profile.name,
      ),
      backgroundColor: LuckitColors.background,
      body: state.loadingGraph == LoadingStatus.loading
          ? Center(
              child: Lottie.asset(Assets.loading),
            )
          : Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 50.0),
                          if (state.loadingProfile == LoadingStatus.success)
                            ProfileInfoWidget(
                              name: infoState.userName,
                              day: infoState.day,
                              gender: infoState.gender,
                              month: infoState.month,
                              hour: infoState.hour,
                              minute: infoState.minute,
                              unknownTime: infoState.unknownTime,
                              year: infoState.year,
                            )
                          else
                            const SizedBox(height: 36.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 260,
                                  child: (state.loadingGraph ==
                                          LoadingStatus.success)
                                      ? const ProfileGraphWidget()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: LuckitColors.main,
                                          ),
                                        ),
                                ),
                                ProfileDescriptionTextWidget(
                                  count: state.completeGoal.length,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                              ProfileGoalArchivingWidget(
                            onTap: () => viewModel.toggleGoalArchiving(
                              tapIndex: index,
                            ),
                            goalModel: state.completeGoal[index],
                          ),
                          childCount: state.completeGoal.length,
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 24.0),
                    ),
                  ],
                ),
                // 더보기 버튼
                Positioned(
                  top: 50,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: LuckitColors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => viewModel.toggleProfileButtons(
                            isCurrentOpen: state.isProfileButtonsOpen,
                          ),
                          child: SvgPicture.asset(
                            Assets.verticalDots,
                            colorFilter: const ColorFilter.mode(
                              LuckitColors.gray80,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Visibility(
                          visible: state.isProfileButtonsOpen,
                          child: Container(
                            margin: const EdgeInsets.only(right: 4.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: LuckitColors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color:
                                        LuckitColors.shadow2.withOpacity(0.15),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child: Column(
                              children: <Widget>[
                                ProfileButtonWidget(
                                  iconPath: Assets.edit,
                                  color: LuckitColors.gray80,
                                  label: '정보수정',
                                  onTap: () =>
                                      context.pushNamed(Routes.edit.name),
                                ),
                                const SizedBox(height: 16.0),
                                ProfileButtonWidget(
                                  iconPath: Assets.logout,
                                  color: LuckitColors.error,
                                  label: '로그아웃',
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        MissionCompleteDialog(
                                      descriptionText: null,
                                      mainText: '로그아웃 하시겠습니까?',
                                      missionTitle: null,
                                      onComplete: appService.signOut,
                                      rightButtonColor: LuckitColors.error,
                                      rightButtonLabel: '로그아웃',
                                    ),
                                  ),
                                  width: 9.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class ProfileButtonWidget extends StatelessWidget {
  final String iconPath;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final double? width;

  const ProfileButtonWidget({
    required this.iconPath,
    required this.color,
    required this.label,
    required this.onTap,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: LuckitColors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                ),
                width: 16.0,
                height: 16.0,
              ),
              SizedBox(width: width ?? 8.0),
              Text(
                label,
                style: LuckitTypos.suitR10.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
}
