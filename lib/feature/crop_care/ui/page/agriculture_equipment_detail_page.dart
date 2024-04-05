import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_agriclture_equipment_detail_cubit.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/agriculture_equipment_detail.dart';

class AgricultureEquipmentDetailPage extends StatelessWidget {
  final DoctorRecordModel doctorRecordModel;
  const AgricultureEquipmentDetailPage(
      {super.key, required this.doctorRecordModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAgricultureEquipmentDetailCubit(
          cropCareRepository: RepositoryProvider.of(context))
        ..getAgricultureEquipmentDetail(id: doctorRecordModel.id),
      child: const AgricultureEquipmentDetail(),
    );
  }
}
