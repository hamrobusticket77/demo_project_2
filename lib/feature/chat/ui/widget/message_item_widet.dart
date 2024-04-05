import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/time_utils.dart';
import 'package:krishi_hub/feature/chat/model/old_message.dart';

class MessageItemWidget extends StatefulWidget {
  final OldMessage data;

  const MessageItemWidget({super.key, required this.data});

  @override
  State<MessageItemWidget> createState() => _MessageItemWidgetState();
}

class _MessageItemWidgetState extends State<MessageItemWidget> {
  bool showTime = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: widget.data.isFarmer
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (widget.data.isFarmer)
              const Expanded(flex: 2, child: SizedBox()),
            Flexible(
              flex: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    showTime = !showTime;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.all(0.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.data.isFarmer
                          ? Theme.of(context).primaryColor
                          : CustomTheme.white,
                    ),
                    child: Text(
                      widget.data.message,
                      textAlign: widget.data.isFarmer
                          ? TextAlign.end
                          : TextAlign.start,
                      style: textTheme.headlineSmall!.copyWith(
                        color: widget.data.isFarmer
                            ? CustomTheme.white
                            : CustomTheme.black,
                      ),
                    )),
              ),
            ),
            if (!widget.data.isFarmer)
              const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
        // if (showTime)
        AnimatedContainer(
          height: !showTime ? 0 : null,
          duration: const Duration(milliseconds: 800),
          child: Row(
            children: [
              if (widget.data.isFarmer) const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  DateTimeUtils.getChatMesageDate(widget.data.createdAt),
                  style: textTheme.bodySmall!.copyWith(
                    color: CustomTheme.grey,
                  ),
                ),
              ),
              if (!widget.data.isFarmer) const Expanded(child: SizedBox()),
            ],
          ),
        ),
        SizedBox(height: 8.hp),
      ],
    );
  }
}
