import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

import 'app/theme.dart';

class UserTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? image;
  final Function()? onTap;
  final bool isSelected;

  const UserTypeCard(
      {super.key,
      required this.title,
      required this.subtitle,
      this.image,
      required this.icon,
      this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.hp),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
              height: 70.hp,
              decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : CustomTheme.lightGray),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(children: [
                SizedBox(
                  width: 10.wp,
                ),
                if (image == null)
                  Icon(icon,
                      size: 40, color: Theme.of(context).colorScheme.tertiary),
                if (image != null)
                  Text(
                    image ?? "",
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (subtitle.isNotEmpty)
                        Text(
                          subtitle,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal),
                        ),
                    ],
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : CustomTheme.lightGray,
                  size: 24,
                ),
                SizedBox(
                  width: 20.wp,
                ),
              ])),
        ),
      ),
    );
  }
}
