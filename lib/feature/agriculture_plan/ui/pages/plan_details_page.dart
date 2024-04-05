import 'package:flutter/widgets.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/plan_details_widget.dart';

class PlanDetailsPage extends StatelessWidget {
  final AgriculturePlanModel agriculturePlanModel;
  const PlanDetailsPage({super.key, required this.agriculturePlanModel});

  @override
  Widget build(BuildContext context) {
    return PlanDetailsWidget(
      agriculturePlanModel: agriculturePlanModel,
    );
  }
}
