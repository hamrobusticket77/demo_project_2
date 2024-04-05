import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/agriculture_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/agriculture_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/agriculture_paln_form_widget.dart';

class AgriculturePlanFormPage extends StatelessWidget {
  final AgriculturePlanModel? agriculturelistModel;
  const AgriculturePlanFormPage({
    super.key,
    this.agriculturelistModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgricultureCubit(
          agricultureRepository:
              RepositoryProvider.of<AgricultureRepository>(context)),
      child:
          AgriculturePlanFormWidget(agriculturelistModel: agriculturelistModel),
    );
  }
}
