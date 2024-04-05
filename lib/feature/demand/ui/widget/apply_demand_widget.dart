import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/demand/cubit/apply_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/cubit/demand_cubit.dart';
import 'package:krishi_hub/feature/demand/model/apply_demand_param.dart';
import 'package:krishi_hub/feature/demand/model/demand_model.dart';

class ApplyDemandWidget extends StatefulWidget {
  const ApplyDemandWidget({super.key});

  @override
  State<ApplyDemandWidget> createState() => _ApplyDemandWidgetState();
}

class _ApplyDemandWidgetState extends State<ApplyDemandWidget> {
  List<TextEditingController> controllers = [];
  List<ApplyDemandParam> applyDemandParam = [];

  bool _isAlreadyValidate = false;
  bool _isLoading = false;

  void validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DemandCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonStateSuccess<DemandModel>) {
          for (var element in state.data.quantityDetails) {
            controllers.add(TextEditingController());

            applyDemandParam.add(ApplyDemandParam(
              id: element.id,
            ));
          }
        }
      },
      child: BlocListener<ApplyDemandCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading) {
            setState(() {
              _isLoading = true;
            });
          } else {
            _isLoading = false;
            setState(() {});
          }

          if (state is CommonSuccess) {
            CustomToast.success(message: "Demand Applied Sucessfully");
            Navigator.pop(context, true);
          }

          if (state is CommonError) {
            CustomToast.error(message: state.message);
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.applySubsidy.tr(),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding.wp,
                    vertical: CustomTheme.symmetricHozPadding.hp),
                child: BlocBuilder<DemandCubit, CommonState>(
                  builder: (context, state) {
                    if (state is CommonLoading) {
                      return const ListViewPlaceHolder();
                    } else if (state is CommonError) {
                      return CommonErrorWidget(message: state.message);
                    } else if (state is CommonStateSuccess<DemandModel>) {
                      return (state.data.quantityDetails.isNotEmpty)
                          ? Column(
                              children: [
                                ...List.generate(
                                    state.data.quantityDetails.length, (index) {
                                  final data =
                                      state.data.quantityDetails[index];
                                  return CustomTextField(
                                    helperText:
                                        "* ${LocaleKeys.availableSubsidyQuantity.tr()} ${state.data.quantityDetails[index].quantity.toString().toNepali()}",
                                    controller: controllers[index],
                                    labelText: '${LocaleKeys.applyFor.tr(args: [
                                          state.data.quantityDetails[index]
                                              .subCategory.name
                                        ])}',
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {
                                      applyDemandParam[index] =
                                          applyDemandParam[index].copyWith(
                                              appliedQuantity:
                                                  int.parse(value));
                                      validateField();
                                    },
                                    textInputFormatterList: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (controllers[index].text.isNotEmpty &&
                                          int.parse(controllers[index].text) ==
                                              0) {
                                        return "quantity cannot be 0";
                                      } else if (int.parse(
                                              controllers[index].text) >
                                          state.data.quantityDetails[index]
                                              .quantity) {
                                        return "quantity cannot be greater then ${state.data.quantityDetails[index].quantity}";
                                      }
                                      return null;
                                    },
                                  );
                                }),
                                // SizedBox(height: 24.hp),
                                CustomRoundedButton(
                                  title: LocaleKeys.apply.tr(),
                                  isLoading: _isLoading,
                                  onPressed: () {
                                    setState(() {
                                      _isAlreadyValidate = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<ApplyDemandCubit>()
                                          .applyDemand(
                                              demandParam: applyDemandParam);
                                    }
                                  },
                                ),
                              ],
                            )
                          : const CommonNoDataWidget();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
