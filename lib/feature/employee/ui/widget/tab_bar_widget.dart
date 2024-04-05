import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class TabBarWidget extends StatefulWidget {
  final ValueNotifier<int> selectedIndex;
  final List<String> items;
  final void Function(int)? onChanged;
  final EdgeInsets? margin;

  final bool showBorder;
  final FontWeight fontWeight;
  const TabBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    this.onChanged,
    this.margin,
    this.fontWeight = FontWeight.w700,
    this.showBorder = true,
  }) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.lightGray,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: widget.margin,
      padding: EdgeInsets.symmetric(horizontal: 5.wp, vertical: 5.hp),
      child: Row(
        children: List.generate(
          widget.items.length,
          (index) {
            return Expanded(
              child: Container(
                padding: widget.showBorder == false
                    ? EdgeInsets.zero
                    : EdgeInsets.only(left: index == 0 ? 0 : 12.wp),
                child: InkWell(
                  onTap: () {
                    widget.selectedIndex.value = index;
                    if (widget.onChanged != null) {
                      widget.onChanged!(index);
                    }
                  },
                  child: ValueListenableBuilder<int>(
                    valueListenable: widget.selectedIndex,
                    builder: (context, currentIndex, _) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 4),
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Theme.of(context).primaryColor
                                    : CustomTheme.lighterGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                widget.items[index],
                                style: textTheme.titleLarge!.copyWith(
                                  fontWeight: widget.fontWeight,
                                  color: currentIndex == index
                                      ? CustomTheme.white
                                      : CustomTheme.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
