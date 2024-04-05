import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_recordid_cubit.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';

class DoctorDetailPage extends StatelessWidget {
  final DoctorRecordModel doctorRecordModel;
  const DoctorDetailPage({super.key, required this.doctorRecordModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDoctorRecordByid(
          cropCareRepository: RepositoryProvider.of(context))
        ..getDoctorRecordByid(id: doctorRecordModel.id),
      child: const DoctorRecordDetail(),
    );
  }
}
