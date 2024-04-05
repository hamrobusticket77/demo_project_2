import 'package:flutter/material.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/disease_page.dart';
import 'package:krishi_hub/feature/weather/ui/pages/weather_page.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/pages/agriculture_pages.dart';
import 'package:krishi_hub/feature/auth/ui/page/login_page.dart';
import 'package:krishi_hub/feature/calender/ui/page/calender_page.dart';
import 'package:krishi_hub/feature/chat/ui/page/chat_list_page.dart';
import 'package:krishi_hub/feature/chat/ui/page/chat_page.dart';
import 'package:krishi_hub/feature/demand/ui/page/demand_list_page.dart';
import 'package:krishi_hub/feature/downloads/ui/pages/dowload_pages.dart';
import 'package:krishi_hub/feature/employee/ui/pages/employee_list.dart';
import 'package:krishi_hub/feature/faq/ui/pages/faq_pages.dart';
import 'package:krishi_hub/feature/feedback/ui/widget/feedback_form.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/krishi_pages.dart';
import 'package:krishi_hub/feature/news/ui/page/new_list_page.dart';
import 'package:krishi_hub/feature/notification/ui/page/notification_list_page.dart';
import 'package:krishi_hub/feature/office_setup/ui/pages/call_center_page.dart';
import 'package:krishi_hub/feature/office_setup/ui/pages/office_setup_page.dart';
import 'package:krishi_hub/feature/product/ui/page/product_form_page.dart';
import 'package:krishi_hub/feature/product/ui/page/product_page.dart';
import 'package:krishi_hub/feature/setting/ui/page/setting_page.dart';
import 'package:krishi_hub/feature/startup/ui/screens/splash_screen.dart';
import 'package:krishi_hub/feature/traning/ui/pages/training_list_page.dart';
import 'package:krishi_hub/feature/video/ui/pages/video_player.dart';
import 'package:page_transition/page_transition.dart';
import '../../feature/contact/ui/pages/contactus_page.dart';
import '../../feature/dashboard/ui/page/dashboard_page.dart';
import '../../feature/images/ui/pages/album_page.dart';
import '../../feature/organization_structure/ui/pages/organization_structure_pages.dart';
import '../../feature/vission/ui/pages/mission_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // route for splash page
      case Routes.root:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );

      // route for dashboard page
      case Routes.dashboardPage:
        return PageTransition(
          child: const DashBoardPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      // login page

      case Routes.login:
        return PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: routeSettings,
        );

      case Routes.officesetup:
        return PageTransition(
          child: const OfficeSetup(),
          type: PageTransitionType.rightToLeft,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      // route for newslist
      case Routes.newsListPage:
        return PageTransition(
          child: const NewsListPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      // route for images
      case Routes.images:
        return PageTransition(
          child: const AlbumPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      //route for setting page
      case Routes.settingPage:
        return PageTransition(
            child: const SettingPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      // route get agricultureplan
      case Routes.agicultureplan:
        return PageTransition(
            child: const AgriculturePlanPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      // routes for organization list
      case Routes.organizationsrtucture:
        return PageTransition(
            child: const OrganizationStructure(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      // demand list
      case Routes.demandlist:
        return PageTransition(
            child: const DemandListPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      //route for feedback post
      case Routes.feedBackPage:
        return PageTransition(
            child: const FeedBackForm(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      // route for youtube video player
      case Routes.videoplayer:
        return PageTransition(
            child: const VideoPlayer(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      // route for contact us form
      case Routes.contactListPage:
        return PageTransition(
            child: const ContactUspage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      // route for krishi knowledge
      case Routes.krishiknowledge:
        return PageTransition(
            child: const KrishiPages(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      // route for employee list
      case Routes.employeelist:
        return PageTransition(
            child: const EmployeeList(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      //download pdf

      case Routes.downloadpdf:
        return PageTransition(
            child: const DownloadPages(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      //faq
      case Routes.faq:
        return PageTransition(
            child: const FaqListPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      // mission and vission page
      case Routes.missionandvission:
        return PageTransition(
            child: const Missionpage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      case Routes.callCenter:
        return PageTransition(
          child: const CallcenterPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );
      // traning list page
      case Routes.tranninglist:
        return PageTransition(
          child: const TrainingListPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: routeSettings,
        );

      case Routes.notificationPage:
        return PageTransition(
            child: const NotificationListPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      case Routes.productPage:
        return PageTransition(
            child: const ProductPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      case Routes.productFormPage:
        return PageTransition(
            child: const ProductFormPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      case Routes.calenderPage:
        return PageTransition(
            child: const CalenderPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      case Routes.chatListPage:
        return PageTransition(
            child: const ChatListPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      case Routes.weatherpage:
        return PageTransition(
            child: const WeatherPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      case Routes.chatPage:
        return PageTransition(
            child: const ChatPage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);
      case Routes.diseasePage:
        return PageTransition(
            child: const DiseasePage(),
            type: PageTransitionType.fade,
            alignment: Alignment.center,
            settings: routeSettings);

      default:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: routeSettings,
          alignment: Alignment.center,
        );
    }
  }
}
