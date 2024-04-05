import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/permission_handler_utils.dart';
import 'package:krishi_hub/common/utils/user_listener.dart';
import 'package:krishi_hub/feature/auth/cubit/logout_cubit.dart';
import 'package:krishi_hub/feature/auth/ui/page/login_page.dart';
import 'package:krishi_hub/feature/chat/ui/page/chat_list_page.dart';
import 'package:krishi_hub/feature/home/ui/widget/home_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_home_krishi_cubit.dart';
import 'package:krishi_hub/feature/news/cubit/get_news_cubit.dart';
import 'package:krishi_hub/feature/news/cubit/get_scrollable_news.dart';
import 'package:krishi_hub/feature/notification/resource/notification_repository.dart';
import 'package:krishi_hub/feature/office_setup/cubit/get_officesetup_cubit.dart';
import 'package:krishi_hub/feature/profile/ui/widget/profile_widget.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/slider/cubit/get_slider_cubit.dart';
import 'package:krishi_hub/feature/video/cubit/get_video_cubit.dart';

import 'dashborad_bottom_bar.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget>
    with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    PermissionHandlerUtils.notificationPermission();
    WidgetsBinding.instance.addObserver(this);
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      // DownloadTask status = data[1];
      int progress = data[2];

      setState(() {});

      if (progress == 100) {
        CustomToast.success(message: "Download Success");
      }
    });

    NotificationRepository repo =
        RepositoryProvider.of<NotificationRepository>(context);

    FlutterDownloader.registerCallback(downloadCallback);
    fetchHomeData();

    Future.sync(() async {
      if (repo.appOpenNotification) {
        await Future.delayed(const Duration(milliseconds: 200));
        repo.setAppOpenNotification(false);
        NavigationService.pushNamed(routeName: Routes.notificationPage);
      }
    });
    super.initState();
  }

  fetchHomeData() async {
    Future.sync(() {
      context.read<GetScrollableNews>().getScrollableNews();
      context.read<GetSliderCubit>().getSlider();
      // context.read<GetKrishiCubit>().getKrishi();
      context.read<GetHomeKrishiCubit>().getHomeKrisiKnowledge();
      context.read<GetVideoCubit>().getVideos();
      context.read<GetNewsCubit>().getNews();
      context.read<GetOfficeSetupCubit>().getOfficeSetup();
      context.read<ReferenceContentCubit>().getReferenceContent();
    });
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');

    if (send != null) {
      send.send([id, status, progress]);
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: DashBoardBottomBar(
          pageController: _pageController,
          selectedIndex: _selectedIndex,
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              if (_selectedIndex.value != index) {
                _selectedIndex.value = index;
                setState(() {});
              }
            },
            children: [
              const HomeWidget(),
              UserListener(
                builder: (context, user) {
                  if (user == null) {
                    return const LoginPage();
                  } else {
                    return BlocListener<LogoutCubit, CommonState>(
                        listener: (context, state) {},
                        child: const ChatListPage());
                  }
                },
              ),
              UserListener(builder: (context, user) {
                if (user == null) {
                  return const LoginPage();
                } else {
                  return BlocListener<LogoutCubit, CommonState>(
                      listener: (context, state) {},
                      child: const ProfileWidget());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
