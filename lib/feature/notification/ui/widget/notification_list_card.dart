import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/feature/demand/ui/page/demand_details_page.dart';
import 'package:krishi_hub/feature/notification/constant/notification_type.dart';

import 'package:krishi_hub/feature/notification/model/notification_model.dart';
import 'package:krishi_hub/feature/traning/ui/pages/training_details_page.dart';

class NotificationListCard extends StatefulWidget {
  final NotificationCardModel data;
  const NotificationListCard({
    super.key,
    required this.data,
  });

  @override
  State<NotificationListCard> createState() => _NotificationListCardState();
}

class _NotificationListCardState extends State<NotificationListCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      // color: CustomTheme.black,
      padding: EdgeInsets.symmetric(
        vertical: 8.hp,
        horizontal: CustomTheme.symmetricHozPadding.wp,
      ),
      child: InkWell(
        onTap: () {
          debugPrint(widget.data.serviceName);
          // context
          //     .read<UpdateNotificationCubit>()
          //     .updateNotification(id: widget.data.id);
          if (widget.data.serviceName.toLowerCase() ==
              NotificationTypes.demand) {
            NavigationService.push(
                target: DemandDetailsPage(
              id: widget.data.demand?.id ?? "",
            ));
          } else if (widget.data.serviceName.toLowerCase() ==
              NotificationTypes.training) {
            NavigationService.push(
                target:
                    TrainingDetailsPage(id: widget.data.training?.id ?? ""));
          }
        },
        child: InkWell(
          child: Material(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              // height: 75,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.solid,
                      color: CustomTheme.lightGray,
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      spreadRadius: 1,
                    ),
                  ],
                  color: widget.data.isRead
                      ? CustomTheme.lighterGrey
                      : CustomTheme.skyBlue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(6)),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //   ),
                      //   width: 50,
                      //   height: 50,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: CustomTheme.secondayColor.withOpacity(0.1),
                      //       shape: BoxShape.circle,
                      //     ),
                      //     padding: EdgeInsets.all(10.wp),
                      //     child: CommonSvgWidget(
                      //         svgName:
                      //             NotificationTypes.getNotficationIconByType(
                      //                 widget.data.title)),
                      //   ),
                      // ),
                      SizedBox(width: 10.hp),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.hp),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.data.body,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,

                                    // overflow: TextOverflow.ellipsis,
                                    style: textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 11,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      color: CustomTheme.skyBlue,
                      child: Text(
                        DateFormatterUtils.convertAdIntoBs(
                            widget.data.publishedDate),
                        style: const TextStyle(
                            color: CustomTheme.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 9),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
