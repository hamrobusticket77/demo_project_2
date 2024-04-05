import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';


import '../../../../common/image/custom_network_image.dart';
import '../../model/organization_model.dart';

class OrganizationCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  final OrganizationStructureModel organizationModel;

  const OrganizationCard({
    super.key,
    required this.organizationModel,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        // height: height,
        width: width,
        child: CustomNetWorkImage(
          imageUrl: (organizationModel.media.medias.isNotEmpty)
              ? organizationModel.media.medias.first.path
              : "",
          boxFit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
