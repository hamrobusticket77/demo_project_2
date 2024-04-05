import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/widget/glass_morphism.dart';
import 'package:krishi_hub/feature/slider/cubit/get_slider_cubit.dart';
import 'package:krishi_hub/feature/slider/model/slider_model.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<GetSliderCubit, CommonState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
            child: BlocBuilder<GetSliderCubit, CommonState>(
          buildWhen: (context, state) {
            if (state is CommonDummyLoading) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            return SizedBox(
              height: 0.2 * MediaQuery.of(context).size.height,
              child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    if (state is! CommonDataFetchSuccess<SliderModel>)
                      CustomNetWorkImage(
                        width: double.infinity,
                        height: 0.2 * MediaQuery.of(context).size.height,
                        boxFit: BoxFit.cover,
                        imageUrl: "",
                      ),
                    if (state is CommonDataFetchSuccess<SliderModel>)
                      ...List.generate(state.data.length, (index) {
                        return Stack(
                          children: [
                            // CustomNetWorkImage(
                            //   width: double.infinity,
                            //   height: 0.2 * MediaQuery.of(context).size.height,
                            //   boxFit: BoxFit.cover,
                            //   imageUrl: (state
                            //           .data[index].media.medias.isNotEmpty)
                            //       ? state.data[index].media.medias.first.path
                            //       : "",
                            // ),
                            CustomCachedNetworkImage(
                              customPlaceHolder: Container(
                                height:
                                    0.2 * MediaQuery.of(context).size.height,
                                width: double.infinity,
                                color: CustomTheme.lightGray,
                              ),
                              width: double.infinity,
                              height: 0.2 * MediaQuery.of(context).size.height,
                              url: (state.data[index].media.medias.isNotEmpty)
                                  ? state.data[index].media.medias.first.path
                                  : "",
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: GlassMorphism(
                                end: 0.1,
                                start: 0.1,
                                borderRadiusBottom: 0,
                                borderRadiusTop: 0,
                                child: Container(
                                  // color:
                                  //     Colors.black.withOpacity(0.4),
                                  padding: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      state.data[index].title,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.titleLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        // fontSize: 11,
                                        color: Colors.white, // Text color
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                  ]),
            );
            // } else {
            //   return SizedBox();
            // }
          },
        ));
      },
    );
  }
}
