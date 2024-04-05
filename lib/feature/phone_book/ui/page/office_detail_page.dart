import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_office_detail_cubit.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/office_detail_widget.dart';

class OfficeDetailPage extends StatelessWidget {
  final OfficeModel officeModel;
  const OfficeDetailPage({super.key, required this.officeModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetOfficeDetailCubit(
          phoneBookRepository: RepositoryProvider.of(context))
        ..getOfficeDetail(id: officeModel.id),
      child: const OfficeDetailWidget(),
    );
  }
}
