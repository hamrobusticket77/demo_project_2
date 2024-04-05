import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/utils/internet_checker.dart';
import 'package:krishi_hub/feature/chat/resource/all_chat_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_doctor_record_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_fertilizer_store_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_seed_store_repository.dart';
import 'package:krishi_hub/feature/crop_care/resources/crop_care_repository.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_repository.dart';
import 'package:krishi_hub/feature/employee/resource/all_electiverepresentive_repository.dart';
import 'package:krishi_hub/feature/expertise/resources/all_expertise_repository.dart';
import 'package:krishi_hub/feature/expertise/resources/expertise_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_agriculture_knowledge_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_disease_report_repository.dart';
import 'package:krishi_hub/feature/market_price/resources/all_current_market_price_repository.dart';
import 'package:krishi_hub/feature/chat/resource/all_question_repository.dart';
import 'package:krishi_hub/feature/market_price/resources/all_market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';
import 'package:krishi_hub/feature/news/resource/all_reference_content_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_phone_book_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_sub_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_repository.dart';
import 'package:krishi_hub/feature/weather/resources/weather_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/all_agriculture_plan_repository.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/calender/resource/calender_repository.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';
import 'package:krishi_hub/feature/contact/resources/contactus_repository.dart';
import 'package:krishi_hub/feature/demand/resource/all_applied_demand_repository.dart';
import 'package:krishi_hub/feature/demand/resource/all_demand_repository.dart';
import 'package:krishi_hub/feature/demand/resource/demand_repository.dart';
import 'package:krishi_hub/feature/downloads/resources/all_download_repository.dart';
import 'package:krishi_hub/feature/downloads/resources/download_repository.dart';
import 'package:krishi_hub/feature/employee/resource/all_employee_repository.dart';
import 'package:krishi_hub/feature/employee/resource/employee_repository.dart';
import 'package:krishi_hub/feature/faq/resources/all_faq_repository.dart';
import 'package:krishi_hub/feature/faq/resources/faq_repository.dart';
import 'package:krishi_hub/feature/feedback/resource/all_feedback_repository.dart';
import 'package:krishi_hub/feature/feedback/resource/feedback_repository.dart';
import 'package:krishi_hub/feature/home/resource/home_repository.dart';
import 'package:krishi_hub/feature/images/resources/all_images_repository.dart';
import 'package:krishi_hub/feature/images/resources/images_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_krishi_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';
import 'package:krishi_hub/feature/media/resource/media_repository.dart';
import 'package:krishi_hub/feature/notification/resource/all_notification_repository.dart';
import 'package:krishi_hub/feature/notification/resource/notification_repository.dart';
import 'package:krishi_hub/feature/office_setup/resources/all_answer_question.dart';
import 'package:krishi_hub/feature/office_setup/resources/all_office_center_repository.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';
import 'package:krishi_hub/feature/organization_structure/resources/all_organzation_repository.dart';
import 'package:krishi_hub/feature/organization_structure/resources/organization_repository.dart';
import 'package:krishi_hub/feature/product/resource/all_product_repository.dart';
import 'package:krishi_hub/feature/product/resource/product_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_fiscal_year_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_plan_Service_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_program_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_project_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_seed_category_repository.dart';
import 'package:krishi_hub/feature/project/resource/project_repository.dart';
import 'package:krishi_hub/feature/slider/resource/all_slider_repository.dart';
import 'package:krishi_hub/feature/slider/resource/slider_repository.dart';
import 'package:krishi_hub/feature/traning/resources/all_training_repository.dart';
import 'package:krishi_hub/feature/traning/resources/traning_repository.dart';
import 'package:krishi_hub/feature/video/resource/all_video_repository.dart';
import 'package:krishi_hub/feature/video/resource/video_repository.dart';
import 'package:krishi_hub/feature/vission/resource/all_mission_repository.dart';
import 'package:krishi_hub/feature/vission/resource/vision_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

import '../../feature/news/resource/all_news_repository.dart';
import '../../feature/news/resource/news_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryWrapper(
      {super.key, required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
          lazy: true,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(
            baseUrl: RepositoryProvider.of<Env>(context).baseUrl,
          ),
          lazy: true,
        ),
        RepositoryProvider<AuthRepository>(
          create: ((context) => AuthRepository(
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                env: RepositoryProvider.of<Env>(context),
              )..initial()),
          lazy: true,
        ),
        RepositoryProvider<SocketRepository>(
          lazy: true,
          create: (context) => SocketRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            internetCheck: RepositoryProvider.of<InternetCheck>(context),
          ),
        ),
        RepositoryProvider(
          lazy: true,
          create: ((context) => MediaRepository(
                env: env,
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              )),
        ),
        RepositoryProvider(
          create: (context) => AllNewsRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => AllReferenceContentRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => NewsRepository(
              env: env,
              apiProvider: RepositoryProvider.of<ApiProvider>(context),
              allnewsRepository:
                  RepositoryProvider.of<AllNewsRepository>(context),
              allReferenceContentRepository:
                  RepositoryProvider.of<AllReferenceContentRepository>(
                      context)),
        ),
        RepositoryProvider(
          create: (context) => AllDownloadRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => DownloadRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allDownloadRepository:
                RepositoryProvider.of<AllDownloadRepository>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => AllMissionRepository(),
          lazy: true,
        ),
        RepositoryProvider(
            lazy: true,
            create: (context) => MissionRepository(
                  env: env,
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                  allMissionRepository:
                      RepositoryProvider.of<AllMissionRepository>(context),
                )),
        RepositoryProvider(
          create: (context) => AllElectiveRepresentiveRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => AllEmployeeRepository(),
          lazy: true,
        ),
        RepositoryProvider(
            lazy: true,
            create: (context) => EmployeeRepository(
                  env: env,
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                  allElectiveRepresentiveRepository:
                      RepositoryProvider.of<AllElectiveRepresentiveRepository>(
                          context),
                  allEmployeeRepository:
                      RepositoryProvider.of<AllEmployeeRepository>(context),
                )),
        RepositoryProvider(
          create: (context) => AllTraningRepositiry(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => TrainingRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allTraningRepository:
                RepositoryProvider.of<AllTraningRepositiry>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => AllFaqRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => FAQRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allfaqRepository: RepositoryProvider.of<AllFaqRepository>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => AllCallCenterRepositoy(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => AllAnswerQuestionRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => CallCenterRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allCallCenterRepository:
                RepositoryProvider.of<AllCallCenterRepositoy>(context),
            allanswerquestionRepository:
                RepositoryProvider.of<AllAnswerQuestionRepository>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => AllImagesRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => ImagesRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allimagesRepository:
                RepositoryProvider.of<AllImagesRepository>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllOrginazationRepository()),
        RepositoryProvider(
          create: (context) => OrganizationRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allorganizationRepository:
                RepositoryProvider.of<AllOrginazationRepository>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllFeedbackRepository()),
        RepositoryProvider(
          create: (context) => FeedbackRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allFeedbackRepository:
                RepositoryProvider.of<AllFeedbackRepository>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllKrishiRepository()),
        RepositoryProvider(
          create: (context) => AllDiseaseReportRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AllAgricultureKnowledgeRepository(),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => KrishiRepository(
              env: env,
              apiProvider: RepositoryProvider.of<ApiProvider>(context),
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              allkrishiRepository:
                  RepositoryProvider.of<AllKrishiRepository>(context),
              mediaRepository: RepositoryProvider.of<MediaRepository>(context),
              allDiseaseReportRepository:
                  RepositoryProvider.of<AllDiseaseReportRepository>(context),
              allAgricultureKnowledgeRepository:
                  RepositoryProvider.of<AllAgricultureKnowledgeRepository>(
                      context)),
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllVideoRepository()),
        RepositoryProvider(
          lazy: true,
          create: (context) => VideoRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allvideoRepository:
                RepositoryProvider.of<AllVideoRepository>(context),
          ),
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllSliderRepository()),
        RepositoryProvider(
            lazy: true,
            create: (context) => SliderRepository(
                  env: env,
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                  allsliderRepository:
                      RepositoryProvider.of<AllSliderRepository>(context),
                )),
        RepositoryProvider(
            lazy: true,
            create: (context) => ContactUsRepository(
                  env: env,
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                )),
        // RepositoryProvider(
        //   lazy: true,
        //   create: ((context) => AuthRepository(
        //         env: RepositoryProvider.of<Env>(context),
        //         apiProvider: RepositoryProvider.of<ApiProvider>(context),
        //       )),
        // ),
        RepositoryProvider(
            lazy: true, create: (context) => AllFiscalYearRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllProjectRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllProgramRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllSeedCategoryRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllPlanServiceRepository()),
        RepositoryProvider(
            lazy: true,
            create: (context) => ProjectRepository(
                env: RepositoryProvider.of<Env>(context),
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                allFiscalYearRepository:
                    RepositoryProvider.of<AllFiscalYearRepository>(context),
                allProgramRepository:
                    RepositoryProvider.of<AllProgramRepository>(context),
                allProjectRepository:
                    RepositoryProvider.of<AllProjectRepository>(context),
                allSeedCategoryRepository:
                    RepositoryProvider.of<AllSeedCategoryRepository>(context),
                allPlanRepository:
                    RepositoryProvider.of<AllPlanServiceRepository>(context))),
        RepositoryProvider(
            lazy: true, create: (context) => AllDemandListRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllAppliedDemendRepository()),
        RepositoryProvider(
          lazy: true,
          create: ((context) => DemandRepository(
                env: env,
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                alldemandlistRepository:
                    RepositoryProvider.of<AllDemandListRepository>(context),
                allAppliedDemendRepository:
                    RepositoryProvider.of<AllAppliedDemendRepository>(context),
              )),
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllNotificationRepository()),
        RepositoryProvider(
            lazy: true,
            create: (context) => NotificationRepository(
                internetCheck: RepositoryProvider.of<InternetCheck>(context),
                env: env,
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                allNotificationRepository:
                    RepositoryProvider.of<AllNotificationRepository>(context))),
        RepositoryProvider(
            lazy: true,
            create: (context) => HomeRepository(
                  env: env,
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                )),
        RepositoryProvider(
            lazy: true, create: (context) => AllProductRepository()),
        RepositoryProvider(
            lazy: true,
            create: (context) => ProductRepository(
                env: env,
                apiProvider: RepositoryProvider.of<ApiProvider>(context),
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                mediaRepository:
                    RepositoryProvider.of<MediaRepository>(context),
                allProductRepository:
                    RepositoryProvider.of<AllProductRepository>(context))),
        RepositoryProvider(
            lazy: true, create: (context) => AllCalenderRepository()),
        RepositoryProvider(
          lazy: true,
          create: (context) => CalenderRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allCalenderRepository:
                RepositoryProvider.of<AllCalenderRepository>(context),
          ),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => WeatherRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          ),
        ),
        RepositoryProvider(
            lazy: true, create: (context) => AllChatRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllQuestionRepository()),
        RepositoryProvider(
            lazy: true, create: (context) => AllCurrentMarketPriceRepository()),

        RepositoryProvider(
            lazy: true, create: (context) => AllMarketPriceRepository()),
        RepositoryProvider(
          create: (context) => MarketPriceRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            allCurrentMarketPriceRepository:
                RepositoryProvider.of<AllCurrentMarketPriceRepository>(context),
            allMarketPriceRepository:
                RepositoryProvider.of<AllMarketPriceRepository>(context),
          ),
        ),
        RepositoryProvider(create: (context) => AllPhoneBookRepository()),
        RepositoryProvider(
          create: (context) => AllOfficeRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => AllSubOfficeRepository(),
          lazy: true,
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => PhoneBookRepository(
              env: env,
              apiProvider: RepositoryProvider.of<ApiProvider>(context),
              authRepository: RepositoryProvider.of<AuthRepository>(context),
              allPhoneBookRepository:
                  RepositoryProvider.of<AllPhoneBookRepository>(context),
              allOfficeRepository:
                  RepositoryProvider.of<AllOfficeRepository>(context),
              allSubOfficeRepository:
                  RepositoryProvider.of<AllSubOfficeRepository>(context)),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AllDoctorRecordRepository(),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AllFertilizerStoreRepository(),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AllSeedstoreRepository(),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => CropCareRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allDoctorRecordRepository:
                RepositoryProvider.of<AllDoctorRecordRepository>(context),
            allFertilizerStoreRepository:
                RepositoryProvider.of<AllFertilizerStoreRepository>(context),
            allSeedstoreRepository:
                RepositoryProvider.of<AllSeedstoreRepository>(context),
          ),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => CropRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AllAgricultureRepository(),
        ),
        RepositoryProvider(
          lazy: true,
          create: (context) => AgricultureRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            mediaRepository: RepositoryProvider.of<MediaRepository>(context),
            allAgricultureRepository:
                RepositoryProvider.of<AllAgricultureRepository>(context),
          ),
        ),

        /// expertise
        RepositoryProvider(
          lazy: true,
          create: (context) => AllExpertiseRepository(),
        ),
        RepositoryProvider(
          create: (context) => ExpertiseRepository(
            env: env,
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            allExpertiseRepository:
                RepositoryProvider.of<AllExpertiseRepository>(context),
          ),
        )
      ],
      child: child,
    );
  }
}
