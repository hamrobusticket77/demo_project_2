import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/office_setup/model/office_setup_model.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_repository.dart';

typedef OfficeSetupListenableBuilder = Widget Function(
    BuildContext, OfficeSetupModel?);

class OfficeSetUpListner extends StatelessWidget {
  const OfficeSetUpListner({super.key, required this.builder});
  final OfficeSetupListenableBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            RepositoryProvider.of<CallCenterRepository>(context).officeSetUp,
        builder: (context, officeSetup, child) =>
            builder(context, officeSetup));
  }
}
