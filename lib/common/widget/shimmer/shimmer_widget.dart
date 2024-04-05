import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShrimmerContainer extends StatelessWidget {
  final double height;
  final double? width;
  final double bottomMargin;
  final double borderRadius;
  final double rightMargin;
  final double leftMargin;

  const ShrimmerContainer({
    super.key,
    this.borderRadius = 4,
    required this.bottomMargin,
    required this.height,
    required this.width,
    this.rightMargin = 0,
    this.leftMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final _isDarkMode = UiUtils.isDarkTheme(_theme);

    return Container(
      margin: EdgeInsets.only(
          bottom: bottomMargin, right: rightMargin, left: leftMargin),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: CustomTheme.lightGray,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ListViewPlaceHolder extends StatelessWidget {
  final int numberofItem;
  final double? itemHeight;
  final double horizontalPadding;
  const ListViewPlaceHolder(
      {super.key,
      this.itemHeight,
      this.numberofItem = 10,
      this.horizontalPadding = 15});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: CustomTheme.lightGray,
        highlightColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              children: List.generate(
            numberofItem,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ShrimmerContainer(
                bottomMargin: 0,
                leftMargin: horizontalPadding.wp,
                height: itemHeight ?? 55.wp,
                width: MediaQuery.of(context).size.width,
                borderRadius: 10,
                rightMargin: horizontalPadding.wp,
              ),
            ),
          )),
        ));
  }
}

class ImageLoader extends StatelessWidget {
  final double height;
  final double width;

  const ImageLoader({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: CustomTheme.lightGray,
        highlightColor: Colors.white,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ShrimmerContainer(
                bottomMargin: 0,
                // leftMargin: 15,
                height: height,
                width: width,
                borderRadius: 100,
                rightMargin: 0.wp),
          ),
        ));
  }
}

class GridViewPlaceHolder extends StatelessWidget {
  final int length;
  final double vertialPadding;
  final double itemHeight;
  final int itemInRow;
  final double itemBorderRadius;
  const GridViewPlaceHolder(
      {super.key,
      this.length = 3,
      this.vertialPadding = 10,
      this.itemHeight = 90,
      this.itemInRow = 2,
      this.itemBorderRadius = 10});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: CustomTheme.lightGray,
        highlightColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: vertialPadding.hp),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        itemInRow,
                        (index) => Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ShrimmerContainer(
                                  bottomMargin: 0,
                                  height: itemHeight.hp,
                                  width: MediaQuery.of(context).size.width,
                                  borderRadius: itemBorderRadius,
                                ),
                              ),
                              SizedBox(width: index != itemInRow - 1 ? 10 : 0),
                            ],
                          ),
                        ),
                      )

                      // [
                      //   Expanded(
                      //     child: ShrimmerContainer(
                      //       bottomMargin: 0,
                      //       height: itemHeight.hp,
                      //       width: MediaQuery.of(context).size.width,
                      //       borderRadius: 10.wp,
                      //     ),
                      //   ),
                      //   SizedBox(width: 10.wp),
                      //   Expanded(
                      //     child: ShrimmerContainer(
                      //       bottomMargin: 0,
                      //       height: itemHeight.hp,
                      //       width: MediaQuery.of(context).size.width,
                      //       borderRadius: 10.wp,
                      //     ),
                      //   ),
                      // ],
                      ),
                ),
              )),
        ));
  }
}

class ContentPlaceHolder extends StatelessWidget {
  const ContentPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomTheme.lightGray,
      highlightColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(children: [
          ShrimmerContainer(
              bottomMargin: 0,
              leftMargin: 15,
              height: 40.wp,
              width: MediaQuery.of(context).size.width,
              borderRadius: 10.wp,
              rightMargin: 15.wp),
          SizedBox(height: 14.hp),
          ShrimmerContainer(
              bottomMargin: 0,
              leftMargin: 15,
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width,
              borderRadius: 10,
              rightMargin: 15.wp),
        ]),
      ),
    );
  }
}
