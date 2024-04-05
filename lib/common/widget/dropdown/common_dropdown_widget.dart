import 'package:flutter/material.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';

import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';

class CommonDropDownWidget extends StatefulWidget {
  final Function(CommonDropDownType value) onChange;
  final List<CommonDropDownType> dropDownList;
  final String hintText;

  final CommonDropDownType? selectedDropDown;

  const CommonDropDownWidget({
    super.key,
    required this.dropDownList,
    required this.onChange,
    this.selectedDropDown,
    required this.hintText,
  });

  @override
  State<CommonDropDownWidget> createState() => _CommonDropDownWidgetState();
}

class _CommonDropDownWidgetState<T> extends State<CommonDropDownWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.selectedDropDown != null) {
      selectedDropDown = widget.selectedDropDown!;
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(CommonDropDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dropDownList != widget.dropDownList) {
      debugPrint("new");
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {});

    super.didChangeDependencies();
  }

  CommonDropDownType? selectedDropDown;

  List<CommonDropDownType> dropDownList = [];
  @override
  Widget build(BuildContext context) {
    selectedDropDown = widget.selectedDropDown;
    dropDownList = widget.dropDownList;
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<CommonDropDownType>(
      borderRadius: BorderRadius.circular(10),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 5),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedDropDown = value;
            widget.onChange(value);
          });
        }
      },
      hint: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          widget.selectedDropDown != null
              ? CheckLocal.check(MultiLanguage(
                  en: widget.selectedDropDown!.en,
                  ne: widget.selectedDropDown!.ne))
              : widget.hintText,
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      selectedItemBuilder: (context) {
        return List.generate(dropDownList.length, (index) {
          return DropdownMenuItem(
            value: dropDownList[index],
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                CheckLocal.check(
                  MultiLanguage(
                    en: dropDownList[index].en,
                    ne: dropDownList[index].ne,
                  ),
                ),
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          );
        });
      },
      items: (dropDownList.isEmpty)
          ? [
              DropdownMenuItem(
                  // alignment: Alignment.center,
                  value: CommonDropDownType.all(),
                  child: Text(
                    CheckLocal.check(
                      MultiLanguage(
                        en: CommonDropDownType.all().en,
                        ne: CommonDropDownType.all().ne,
                      ),
                    ),
                    style: textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ))
            ]
          : List.generate(dropDownList.length, (index) {
              return DropdownMenuItem(
                value: dropDownList[index],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    CheckLocal.check(
                      MultiLanguage(
                        en: dropDownList[index].en,
                        ne: dropDownList[index].ne,
                      ),
                    ),
                    style: textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }),
    );
  }
}
