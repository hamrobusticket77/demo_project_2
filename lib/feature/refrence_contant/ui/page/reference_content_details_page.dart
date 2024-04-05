import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/get_reference_cubit_id.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/widget/reference_content_details_widget.dart';

class ReferenceContentDetailsPage extends StatelessWidget {
  final ReferenceContentModel data;
  const ReferenceContentDetailsPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetReferenceCubitId(newsRepository: RepositoryProvider.of(context))
            ..getReferenceContentByid(id: data.id),
      child: ReferenceContentDetailsWidget(data: data),
    );
  }
}
