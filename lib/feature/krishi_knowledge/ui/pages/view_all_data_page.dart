import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_agriculture_item_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/krishi_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/view_all_data_widget.dart';

class ViewAllDataPage extends StatelessWidget {
  final AgricultureName agricultureName;

  const ViewAllDataPage({
    super.key,
    required this.agricultureName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAgricultureItemCubit(
          krishiRepository: RepositoryProvider.of<KrishiRepository>(context))
        ..getAgricltureItem(agricultureName.id),
      child: const ViewAllDataWidget(),
    );
  }
}
