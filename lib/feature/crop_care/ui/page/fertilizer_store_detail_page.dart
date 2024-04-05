import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_fertilierstoreDetail.dart';

import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/fertilizer_store_detail_widget.dart';

class FertilizerStoreDetailPage extends StatelessWidget {
  final FertilizerStoreModel fertilizerStoreModel;
  const FertilizerStoreDetailPage(
      {super.key, required this.fertilizerStoreModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFertilizerStoreDetailCubit(
          cropCareRepository: RepositoryProvider.of(context))
        ..getFertilizerStoreDetailCubit(id: fertilizerStoreModel.id),
      child: const FertilizerStoreDetail(),
    );
  }
}
