import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/model/media_model.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/model/photos.dart';
import 'package:krishi_hub/common/utils/device_info_utils.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';
import 'package:krishi_hub/feature/demand/model/applied_demand_model.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';
import 'package:krishi_hub/feature/demand/model/farmer_model.dart';
import 'package:krishi_hub/feature/demand/model/quantity_details_model.dart';
import 'package:krishi_hub/feature/downloads/models/downloads_model.dart';
import 'package:krishi_hub/feature/employee/model/elective_representative_model.dart';
import 'package:krishi_hub/feature/employee/model/employee_model.dart';
import 'package:krishi_hub/feature/images/model/image_album_model.dart';
import 'package:krishi_hub/feature/images/model/images_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_type.dart';
import 'package:krishi_hub/feature/news/model/news_model.dart';
import 'package:krishi_hub/feature/office_setup/model/answer_question_model.dart';
import 'package:krishi_hub/feature/office_setup/model/office_setup_model.dart';
import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/project/model/plan_service_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';
import 'package:krishi_hub/feature/project/model/sub_category_model.dart';
import 'package:krishi_hub/feature/slider/model/slider_model.dart';
import 'package:krishi_hub/feature/traning/model/training_model.dart';
import 'package:krishi_hub/feature/video/model/video_model.dart';

class HiveStorage {
  String officeSetup = "office_setup";
  String scrollNews = "scroll_news";
  String sliderImage = "sliderImage";
  String krishiKnowledgeHome = "krishiKnowledgeHome";
  String krishiKnowledgeList = "krishiKnowledgeList";
  String videoList = "videoList";
  String trainingList = "trainingList";
  String trainingDetails = "trainingDetails";
  String demandList = "demandList";
  String newsList = "newsList";
  String knowledgeDetails = "knowledgeDetails";
  String imageList = "imageList";
  String agriculturePlanList = "agriculturePlanList";
  String callCenterList = "callCenterList";
  String productList = "productList";
  String phoneBookList = "phoneBookList";
  String downloadList = "downloadList";
  String doctorExpertList = "doctorExpertList";
  String fertilizerList = "fertilizerList";
  String seedList = "seedList";
  String officialList = "officialList";
  String employeeList = "employeeList";
  String imageAlbum = "imageAlbum";

  static final HiveStorage _hiveServices = HiveStorage._internal();

  factory HiveStorage() {
    return _hiveServices;
  }

  HiveStorage._internal();

  init() async {
    try {
      // register hive model adapter here
      Hive.registerAdapter(PhotosAdapter());

      Hive.registerAdapter(MediaModelAdapter());

      Hive.registerAdapter(OfficeSetupModelAdapter());

      Hive.registerAdapter(SliderModelAdapter());

      Hive.registerAdapter(NewsModelAdapter());

      Hive.registerAdapter(AgricultureNameAdapter());

      Hive.registerAdapter(DetailsAdapter());

      Hive.registerAdapter(ValueAdapter());

      Hive.registerAdapter(DiseaseAdapter());

      Hive.registerAdapter(MultiLanguageAdapter());

      Hive.registerAdapter(CropTypeModelAdapter());

      Hive.registerAdapter(AgricultureModelAdapter());

      Hive.registerAdapter(AgricultureTypeAdapter());

      Hive.registerAdapter(TrainingModelAdapter());

      Hive.registerAdapter(VideoModelAdapter());

      Hive.registerAdapter(PlaylistAdapter());

      Hive.registerAdapter(DemandModelAdapter());

      Hive.registerAdapter(ProjectModelAdapter());

      Hive.registerAdapter(FiscalYearAdapter());

      Hive.registerAdapter(ProgramModelAdapter());

      Hive.registerAdapter(PlanServiceModelAdapter());

      Hive.registerAdapter(QuantityDetailsAdapter());

      Hive.registerAdapter(AppliedDemandModelAdapter());

      Hive.registerAdapter(SubCategoryModelAdapter());

      Hive.registerAdapter(FarmerModelAdapter());

      Hive.registerAdapter(FarmerInfoAdapter());

      Hive.registerAdapter(ImagesModelAdapter());

      Hive.registerAdapter(AlbumAdapter());

      Hive.registerAdapter(AgriculturePlanModelAdapter());

      Hive.registerAdapter(PlanningServiceAdapter());

      Hive.registerAdapter(AnswerQuestionModelAdapter());

      Hive.registerAdapter(FarmerDetailsAdapter());

      Hive.registerAdapter(QuestionAndAnswerAdapter());

      Hive.registerAdapter(ProductModelAdapter());

      Hive.registerAdapter(StatusActivityAdapter());

      Hive.registerAdapter(CropsAdapter());

      // Hive.registerAdapter(PhoneBookModelAdapter());

      // Hive.registerAdapter(OfficeAdapter());

      // Hive.registerAdapter(PhoneNumberAdapter());

      // Hive.registerAdapter(SocialMediaAdapter());

      Hive.registerAdapter(DownloadsModelAdapter());

      // Hive.registerAdapter(DoctorRecordModelAdapter());

      // Hive.registerAdapter(FertilizerStoreModelAdapter());

      // Hive.registerAdapter(ContactPersonAdapter());

      Hive.registerAdapter(EmployeeModelAdapter());

      Hive.registerAdapter(DepartmentAdapter());
      Hive.registerAdapter(ElectiveRepresentiveModelAdapter());

      Hive.registerAdapter(ImageAlbumModelAdapter());

      if (await DeviceInfoUtils.isAppUpdate()) {
        await clearHiveData();
      }

      // open hive boxes here for needed models

      await Hive.openBox<OfficeSetupModel>(officeSetup);

      await Hive.openBox<NewsModel>(scrollNews);

      await Hive.openBox<SliderModel>(sliderImage);

      await Hive.openBox<AgricultureName>(krishiKnowledgeHome);

      await Hive.openBox<AgricultureModel>(krishiKnowledgeList);

      await Hive.openBox<VideoModel>(videoList);

      await Hive.openBox<TrainingModel>(trainingList);

      await Hive.openBox<TrainingModel>(trainingDetails);

      await Hive.openBox<DemandModel>(demandList);

      await Hive.openBox<NewsModel>(newsList);

      await Hive.openBox<AgricultureName>(knowledgeDetails);

      await Hive.openBox<ImagesModel>(imageList);

      await Hive.openBox<AgriculturePlanModel>(agriculturePlanList);

      await Hive.openBox<AnswerQuestionModel>(callCenterList);

      await Hive.openBox<ProductModel>(productList);

      await Hive.openBox<PhoneBookModel>(phoneBookList);

      await Hive.openBox<DownloadsModel>(downloadList);

      await Hive.openBox<DoctorRecordModel>(doctorExpertList);

      await Hive.openBox<FertilizerStoreModel>(fertilizerList);

      await Hive.openBox<FertilizerStoreModel>(seedList);

      await Hive.openBox<EmployeeModel>(employeeList);

      await Hive.openBox<ElectiveRepresentiveModel>(officialList);

      await Hive.openBox<ImageAlbumModel>(imageAlbum);
    } catch (e) {
      Log.e(e);
    }
  }

  Future clearHiveData() async {
    try {
      await Hive.deleteBoxFromDisk(officeSetup);

      await Hive.deleteBoxFromDisk(scrollNews);

      await Hive.deleteBoxFromDisk(sliderImage);

      await Hive.deleteBoxFromDisk(krishiKnowledgeHome);

      await Hive.deleteBoxFromDisk(krishiKnowledgeList);

      await Hive.deleteBoxFromDisk(videoList);

      await Hive.deleteBoxFromDisk(trainingList);

      await Hive.deleteBoxFromDisk(trainingDetails);

      await Hive.deleteBoxFromDisk(demandList);

      await Hive.deleteBoxFromDisk(newsList);

      await Hive.deleteBoxFromDisk(knowledgeDetails);

      await Hive.deleteBoxFromDisk(imageList);

      await Hive.deleteBoxFromDisk(agriculturePlanList);

      await Hive.deleteBoxFromDisk(callCenterList);

      await Hive.deleteBoxFromDisk(productList);

      await Hive.deleteBoxFromDisk(phoneBookList);

      await Hive.deleteBoxFromDisk(downloadList);

      await Hive.deleteBoxFromDisk(doctorExpertList);

      await Hive.deleteBoxFromDisk(fertilizerList);

      await Hive.deleteBoxFromDisk(seedList);

      await Hive.deleteBoxFromDisk(employeeList);

      await Hive.deleteBoxFromDisk(imageAlbum);
    } catch (e) {
      Log.e(e);
    }
  }

  Future<List<T>> getListValues<T>(String storageName) async {
    try {
      final box = await Hive.openBox<T>(storageName);
      return box.values.toList();
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
      return [];
    }
  }

  Future setListValues<T>(String storageName, List<T> values) async {
    try {
      final box = Hive.box<T>(storageName);
      await box.clear();
      await box.addAll(values);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
    }
  }

  Future<T?> getValueById<T>(String storageName, String id) async {
    try {
      final box = await Hive.openBox<T>(storageName);
      return box.get(id);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
      return null;
    }
  }

  Future setValueById<T>(String storageName, T value, String id) async {
    try {
      final box = Hive.box<T>(storageName);
      box.put(id, value);
    } catch (e) {
      if (kDebugMode) {
        Log.e(e);
      }
    }
  }
}
