import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/user_listener.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/loading_overlay.dart';
import 'package:krishi_hub/common/widget/logout_widget.dart';
import 'package:krishi_hub/feature/auth/cubit/logout_cubit.dart';
import 'package:krishi_hub/feature/auth/ui/page/user_delete_page.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/privacy_policy/ui/page/privacy_policy_page.dart';
import 'package:krishi_hub/feature/profile/ui/widget/profile_detail_widget.dart';
import 'package:krishi_hub/feature/profile/ui/widget/rounded_listtile_card.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<LogoutCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
        if (state is CommonStateSuccess) {
          NavigationService.popUntil(routeName: Routes.dashboardPage);
        }
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        color: CustomTheme.grey,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: CustomScrollView(
          slivers: [
            SliverPinnedHeader(
              child: CustomAppBar(
                title: LocaleKeys.profile.tr(),
                leadingIcon: const SizedBox(),
              ),
            ),
            SliverToBoxAdapter(
              child: UserListener(builder: (context, user) {
                if (user != null) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            NavigationService.push(
                                target: const ProfileDetailsWidget());
                          },
                          child: Container(
                            color: CustomTheme.white,
                            padding: EdgeInsets.all(10.hp),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CustomNetWorkImage(
                                                  imageUrl: user.profileMedia
                                                          .medias.isNotEmpty
                                                      ? user.profileMedia
                                                          .medias[0].path
                                                      : "",
                                                  boxFit: BoxFit.cover,
                                                  width: 85.wp,
                                                  height: 85.wp,
                                                  placeHolder:
                                                      Assets.userPlaceHolder,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.wp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 14.hp),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              LocaleKeys.welcome.tr(),
                                              style: textTheme.headlineSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            SizedBox(height: 8.hp),
                                            Text(
                                              FullNameUtils.getFullName(
                                                firstName: user.firstName,
                                                lastName: user.lastName,
                                                middleName: user.middleName,
                                              ),
                                              style: textTheme.titleLarge,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.hp),
                        Column(
                          children: [
                            RoundedListTileCardNew(
                              title: LocaleKeys.aboutus.tr(),
                              iconPath: Assets.about_us,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.officesetup);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.ourmission.tr(),
                              iconPath: Assets.mission,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.missionandvission);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.notification.tr(),
                              iconPath: Assets.bell,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.notificationPage);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.contactus.tr(),
                              iconPath: Assets.contact,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.contactListPage);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.setting.tr(),
                              iconPath: Assets.setting2,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.settingPage);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.faq.tr(),
                              iconPath: Assets.question,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.faq);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.organizationstructure.tr(),
                              iconPath: Assets.structure,
                              onPressed: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.organizationsrtucture);
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.privacyPolicy.tr(),
                              iconPath: Assets.privacy,
                              onPressed: () {
                                // Handle privacy policy button tap.

                                NavigationService.push(
                                    target: const PrivacyPolicyPage());
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.accountDeleteTitle.tr(),
                              iconPath: Assets.deleteAccount,
                              onPressed: () {
                                NavigationService.push(
                                    target: const UserDeletePage());
                              },
                            ),
                            RoundedListTileCardNew(
                              title: LocaleKeys.logout.tr().capitalize(),
                              iconPath: Assets.logout2,
                              onPressed: () {
                                showLogoutAlertDialog(
                                    context: context,
                                    onPressed: () {
                                      context.read<LogoutCubit>().logout();
                                    });
                              },
                            ),
                            SizedBox(
                              height: 30.hp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }),
            )
          ],
        ),
      ),
    );
  }
}
