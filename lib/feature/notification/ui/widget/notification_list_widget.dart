import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/user_listener.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/auth/ui/page/login_page.dart';
import 'package:krishi_hub/feature/notification/cubit/get_notification_cubit.dart';
import 'package:krishi_hub/feature/notification/cubit/update_notification_cubit.dart';
import 'package:krishi_hub/feature/notification/resource/all_notification_repository.dart';
import 'package:krishi_hub/feature/notification/ui/widget/login_dialog.dart';
import 'package:krishi_hub/feature/notification/ui/widget/notification_list_card.dart';
import 'package:krishi_hub/feature/notification/utils/notification_utils.dart';

class NotificationListWidget extends StatefulWidget {
  const NotificationListWidget({super.key});

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final bloc = context.read<GetNotificationCubit>();
    if (RepositoryProvider.of<AuthRepository>(context).isLoggedIn.value) {
      // if (bloc.state is! CommonDataFetchSuccess) {
      // }
      bloc.getNotification();

      NotificationUtils.clearNotificationCount();
    } else {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        loginDialog(
            context: context,
            onPressed: () {
              NavigationService.push(
                      target: const LoginPage(loginFromOtherPage: true))
                  .then((value) {
                if (value != null && value == true) {
                  bloc.getNotification();
                }
              });
            });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notification =
        RepositoryProvider.of<AllNotificationRepository>(context);
    return BlocListener<UpdateNotificationCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccess) {
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.notification.tr(),
          onBackPressed: () {
            NavigationService.pop();
          },
          // showBackButton: false,
        ),
        body:
            SingleChildScrollView(child: UserListener(builder: (context, user) {
          if (user != null) {
            return BlocConsumer<GetNotificationCubit, CommonState>(
                listener: (context, state) {
              if (state is CommonDataFetchSuccess) {
                _isLoadMoreActive = false;
              }
            }, buildWhen: (context, state) {
              if (state is CommonDummyLoading) {
                return false;
              }
              return true;
            }, builder: (context, state) {
              if (state is CommonLoading) {
                return ListViewPlaceHolder(
                  itemHeight: 75.hp,
                );
              } else if (state is CommonError) {
                return CommonErrorWidget(message: state.message);
              } else if (state is CommonNoData) {
                return const CommonNoDataWidget();
              } else if (state is CommonDataFetchSuccess<String>) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels >
                        scrollNotification.metrics.maxScrollExtent / 2) {
                      if (!_isLoadMoreActive &&
                          _scrollController.position.userScrollDirection ==
                              ScrollDirection.reverse) {
                        _isLoadMoreActive = true;
                        context
                            .read<GetNotificationCubit>()
                            .loadMoreNotification();
                      }
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: List.generate(
                        state.data.length,
                        (index) {
                          if (notification.getNotification[state.data[index]] !=
                              null) {
                            return NotificationListCard(
                                data: notification
                                    .getNotification[state.data[index]]!);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            });
          } else {
            return const CommonNoDataWidget();
          }
        })),
      ),
    );
  }
}
