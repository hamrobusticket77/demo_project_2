// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:krishi_hub/common/app/theme.dart';
// import 'package:krishi_hub/common/constant/locale_keys.dart';
// import 'package:krishi_hub/common/utils/form_validator.dart';
// import 'package:krishi_hub/common/utils/size_utils.dart';
// import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
// import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
// import 'package:krishi_hub/feature/demand/model/demand_param_model.dart';
// import 'package:krishi_hub/feature/project/model/seed_category_model.dart';
// import 'package:krishi_hub/feature/project/ui/widget/seed_category_dialog.dart';
// import 'package:krishi_hub/feature/project/ui/widget/seed_name_dialog.dart';

// Future addDemandDialog(
//     {required BuildContext context,
//     DemandDetailsParamModel? demandDetails}) async {
//   return showDialog(
//       context: context,
//       builder: ((context) => AddDemandDetailsDialog(
//             demandDetails: demandDetails,
//           )));
// }

// class AddDemandDetailsDialog extends StatefulWidget {
//   final DemandDetailsParamModel? demandDetails;
//   const AddDemandDetailsDialog({super.key, this.demandDetails});

//   @override
//   State<AddDemandDetailsDialog> createState() => _AddDemandDetailsDialogState();
// }

// class _AddDemandDetailsDialogState extends State<AddDemandDetailsDialog> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   TextEditingController seedCategory = TextEditingController();
//   TextEditingController seedName = TextEditingController();
//   TextEditingController demandQuantity = TextEditingController();

//   DemandDetailsParamModel demandDetails = DemandDetailsParamModel(
//       seedCategory: SeedCategoryModel(id: "", name: "", seed: []),
//       seed: Seed(id: "", name: ""),
//       demandQuantity: 0);

//   @override
//   void initState() {
//     loadInitialData();
//     super.initState();
//   }

//   loadInitialData() {
//     if (widget.demandDetails != null) {
//       seedCategory.text = widget.demandDetails!.seedCategory.name;
//       seedName.text = widget.demandDetails!.seed.name;

//       demandQuantity.text = widget.demandDetails!.demandQuantity.toString();

//       seedCategoryModel = widget.demandDetails!.seedCategory;

//       seed = widget.demandDetails!.seed;
//       setState(() {});
//     }
//   }

//   SeedCategoryModel? seedCategoryModel;
//   Seed? seed;

//   @override
//   void dispose() {
//     seedCategory.dispose();
//     seedName.dispose();
//     demandQuantity.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         insetPadding: EdgeInsets.symmetric(
//             horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 20.hp),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(LocaleKeys.adddemanddetails.tr(),
//                       textAlign: TextAlign.center,
//                       style: textTheme.titleLarge!
//                           .copyWith(fontWeight: FontWeight.bold)),
//                   SizedBox(height: 20.hp),
//                   CustomTextField(
//                     controller: seedCategory,
//                     labelText: LocaleKeys.seedCategory.tr(),
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       return FormValidator.validateFieldNotEmpty(
//                           value, LocaleKeys.seedCategory.tr());
//                     },
//                     isReadOnly: true,
//                     onTap: () {
//                       seedCategoryDialog(
//                           context: context,
//                           onChange: (value) {
//                             seedCategoryModel = value;
//                             seedCategory.text = value.name;
//                             seed = null;
//                             seedName.clear();
//                           });
//                     },
//                   ),
//                   CustomTextField(
//                     controller: seedName,
//                     labelText: LocaleKeys.seedname.tr(),
//                     textInputAction: TextInputAction.next,
//                     validator: (value) {
//                       return FormValidator.validateFieldNotEmpty(
//                           value, LocaleKeys.seedname.tr());
//                     },
//                     isReadOnly: true,
//                     onTap: () {
//                       seedNameDialog(
//                           seedList: seedCategoryModel?.seed ?? [],
//                           context: context,
//                           onChange: (value) {
//                             seed = value;
//                             // seedName.text = value.name;
//                           });
//                     },
//                   ),
//                   CustomTextField(
//                     controller: demandQuantity,
//                     labelText: LocaleKeys.demandquantity.tr(),
//                     textInputType: TextInputType.number,
//                     textInputFormatterList: [
//                       FilteringTextInputFormatter.digitsOnly
//                     ],
//                     validator: (value) {
//                       return FormValidator.validateFieldNotEmpty(
//                           value, LocaleKeys.demandquantity.tr());
//                     },
//                   ),
//                   SizedBox(height: 20.hp),
//                   SizedBox(
//                     width: 100.wp,
//                     height: 30.hp,
//                     child: CustomRoundedButtom(
//                       title: widget.demandDetails == null ? "add" : "update",
//                       fontSize: 10,
//                       padding: const EdgeInsets.all(1),
//                       fontWeight: FontWeight.w400,
//                       onPressed: () async {
//                         if (formKey.currentState!.validate()) {
//                           FocusScope.of(context).unfocus();

//                           demandDetails = demandDetails.copyWith(
//                               seedCategory: seedCategoryModel,
//                               seed: seed,
//                               demandQuantity: int.parse(demandQuantity.text));
//                           await Future.delayed(const Duration(milliseconds: 50))
//                               .whenComplete(() {
//                             Navigator.pop(context, demandDetails);
//                           });
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
