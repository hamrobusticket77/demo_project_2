import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/office_setup_listner.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';

import 'package:krishi_hub/feature/office_setup/cubit/get_officesetup_cubit.dart';
import 'package:krishi_hub/feature/office_setup/ui/widget/office_setup_card.dart';

class CallCenterWidget extends StatefulWidget {
  const CallCenterWidget({super.key});

  @override
  State<CallCenterWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<CallCenterWidget> {
  @override
  void initState() {
    context.read<GetOfficeSetupCubit>().getOfficeSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.aboutus.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OfficeSetUpListner(builder: (context, value) {
              if (value != null) {
                return CallCenterCard(
                  officeSetupModel: value,
                );
              } else {
                return const SizedBox();
              }
            }),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
