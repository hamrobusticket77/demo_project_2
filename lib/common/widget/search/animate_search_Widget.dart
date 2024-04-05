import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';

class AnimatedSearchBar extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final Icon? prefixIcon;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;
  final Function()? onTapSuffixButton;
  final void Function(String)? onChanged;
  final String hintText;

  const AnimatedSearchBar({
    Key? key,
    required this.onTapSuffixButton,
    required this.hintText,

    /// The width cannot be null
    required this.width,
    required this.searchBarOpen,
    required this.onChanged,

    /// The textController cannot be null
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.height = 60,

    /// choose your custom color
    this.color = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.textFieldColor = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.searchIconColor = Colors.black,

    /// choose your custom color for the search when it is expanded
    this.textFieldIconColor = Colors.black,
    this.textInputAction = TextInputAction.done,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// The onSubmitted cannot be null
    required this.onSubmitted,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// enable/disable the box shadow decoration
    this.boxShadow = true,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
  }) : super(key: key);

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

/// * use this variable to check current text from OnChange
String textFieldValue = '';

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final txt = theme.textTheme;
    return Container(
      // color: Colors.red,
      height: widget.height,
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: widget.height,
        width: (toggle == 0) ? 100.0 : MediaQuery.of(context).size.width,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: toggle == 1 ? widget.textFieldColor : widget.color,
          // borderRadius: BorderRadius.circular(30.0),
          boxShadow: !widget.boxShadow
              ? null
              : [
                  const BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10.0,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              right: 10.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: widget.color,
                  ),
                  child: AnimatedBuilder(
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 1.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                    child: CustomIconButton(
                      backgroundColor: CustomTheme.white,
                      onPressed: () {
                        try {
                          widget.onSuffixTap();

                          if (textFieldValue == '') {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });

                            ///reverse == close
                            _con.reverse();
                          }

                          widget.controller.clear();
                          textFieldValue = '';

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      icon: widget.suffixIcon ?? Icons.close,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 15.0 : 15.0,
              curve: Curves.easeOut,
              // top: 11.0,
              // right: 0,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width * widget.width,
                  child: TextFormField(
                    style: txt.bodyLarge,
                    controller: widget.controller,
                    cursorColor: Theme.of(context).primaryColor,
                    onFieldSubmitted: widget.onSubmitted,
                    textInputAction: TextInputAction.search,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      suffix: InkWell(
                          onTap: widget.onTapSuffixButton,
                          child: Text(
                            LocaleKeys.clear.tr(),
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: theme.primaryColor),
                          )),
                      hintText: widget.hintText,
                      prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CommonSvgWidget(
                            svgName: Assets.search,
                            color: CustomTheme.grey,
                          )),
                      // hintStyle: theme.textTheme.bodyLarge!.copyWith(
                      //     color: CustomTheme.grey, fontWeight: FontWeight.w400),
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: CustomTheme.grey,
                                fontWeight: FontWeight.w400,
                              ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: CustomTheme.midGrayColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: CustomTheme.midGrayColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (toggle == 0)
              AnimatedPositioned(
                duration:
                    Duration(milliseconds: widget.animationDurationInMilli),
                right: 10,
                child: toggle != 0
                    ? SizedBox()
                    : CustomIconButton(
                        backgroundColor: CustomTheme.white,
                        icon: Icons.search,
                        onPressed: () {
                          setState(() {
                            if (toggle == 0) {
                              toggle = 1;
                              if (widget.autoFocus) {
                                FocusScope.of(context).requestFocus(focusNode);
                              }
                              _con.forward();
                            } else {
                              toggle = 0;
                              if (widget.autoFocus) {
                                unfocusKeyboard();
                              }
                              _con.reverse();
                            }
                          });
                          widget.searchBarOpen(toggle);
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
