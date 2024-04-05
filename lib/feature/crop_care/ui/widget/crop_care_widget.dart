import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/agriculture_euipement_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/doctor_record_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/fertilizer_store_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/insurance_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/seed_store_page.dart';
import 'package:krishi_hub/feature/crop_care/utils/crop_utils.dart';
import 'package:krishi_hub/feature/expertise/ui/page/expertise_page.dart';
import 'package:krishi_hub/feature/market_price/ui/pages/wholesaller_price.dart';

class CropCareWidget extends StatefulWidget {
  const CropCareWidget({Key? key}) : super(key: key);

  @override
  State<CropCareWidget> createState() => _CropCareWidgetState();
}

class _CropCareWidgetState extends State<CropCareWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(vsync: this, length: 7); // Set length to 5 for 5 tabs
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        extendBody: true,
        appBar: CustomAppBar(
          title: LocaleKeys.expertAndShopContact.tr(),
          bottom: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: CustomTheme.grey,
            indicatorColor: Theme.of(context).primaryColor,
            controller: _tabController,
            tabs: [
              Tab(
                icon: SvgPicture.asset(
                  Assets.doctor,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 0),
                ),
                text: LocaleKeys.doctorAndExpert.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.fertilizer,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 1),
                ),
                text: LocaleKeys.fertilizerStore.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.seed,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 2),
                ),
                text: LocaleKeys.seedStore.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.seed,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 3),
                ),
                text: LocaleKeys.insuranceDetail.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.seed,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 4),
                ),
                text: LocaleKeys.agricultureEquipment.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.seed,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 5),
                ),
                text: LocaleKeys.wholeSaler.tr(),
              ),
              Tab(
                icon: SvgPicture.asset(
                  Assets.seed,
                  width: 20,
                  height: 20,
                  colorFilter: CropUtils.getColor(_tabController, 6),
                ),
                text: LocaleKeys.expertis.tr(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            DoctorRecordPage(),
            FertilizerStorePage(),
            SeedStorePage(),
            InsurancePage(),
            AgricultureEquipementPage(),
            WholeSallerPrice(),
            ExpertisePage(),
          ],
        ),
      ),
    );
  }
}
