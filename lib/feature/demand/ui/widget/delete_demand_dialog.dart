import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/feature/demand/cubit/delete_demand_cubit.dart';

Future deleteDemandDialog(
    {required BuildContext context, required Function() onPressed}) {
  return showDialog(
      context: context,
      builder: (context) => DeleteDemandDialogWidget(
            onPressed: onPressed,
          ));
}

class DeleteDemandDialogWidget extends StatelessWidget {
  final Function() onPressed;

  const DeleteDemandDialogWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.wp))),
      title: Text(LocaleKeys.subsidyDelete.tr(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold)),
      content: Text(
        LocaleKeys.areYouSureWantToDelete.tr(),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              LocaleKeys.cancel.tr(),
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            )),
        SizedBox(width: 10.hp),
        SizedBox(
          width: 130,
          height: 34,
          child: BlocListener<DeleteDemand, CommonState>(
            listener: (context, state) {
              if (state is CommonError) {
                CustomToast.error(message: state.message);
              }
              if (state is CommonSuccess) {
                Navigator.pop(context, true);
                CustomToast.success(
                    message: LocaleKeys.subsidyDeleteSuccessfully.tr());
              }
            },
            child: BlocBuilder<DeleteDemand, CommonState>(
              builder: (context, state) {
                return CustomRoundedButton(
                  title: LocaleKeys.confirm.tr(),
                  isLoading: (state is CommonLoading) ? true : false,
                  onPressed: () {
                    if (state is! CommonLoading) {
                      onPressed();
                    }
                  },
                  fontSize: 12,
                  padding: EdgeInsets.zero,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
