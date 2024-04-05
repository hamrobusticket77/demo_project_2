import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/getinsurancedirectory_detail_cubit.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/insurance_detail_Widget.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/insurance_widget.dart';

class InsurnceDetailPage extends StatelessWidget {
  final DoctorRecordModel doctorRecordModel;
  const InsurnceDetailPage({super.key, required this.doctorRecordModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInsuranceDirectoryDetailCubit(
          cropCareRepository: RepositoryProvider.of(context))
        ..getInsuranceDirectoryDetailCubit(id: doctorRecordModel.id),
      child: const InsuranceDetailWidget(),
    );
  }
}
