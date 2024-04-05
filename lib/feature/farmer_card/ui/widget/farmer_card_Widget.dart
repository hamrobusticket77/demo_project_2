import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/feature/farmer_card/ui/widget/text_Widget.dart';

class FarmerCardWidget extends StatefulWidget {
  const FarmerCardWidget({super.key});

  @override
  State<FarmerCardWidget> createState() => _FarmerCardWidgetState();
}

class _FarmerCardWidgetState extends State<FarmerCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: CustomTheme.white,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.appIcon,
                      width: 60,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Phidim Municipality",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomTheme.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: CustomTheme.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Center(
                              child: Text(
                                "Identify",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: CustomTheme.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: "Farmer Name", subTitle: "Ram"),
                      TextWidget(title: "Age", subTitle: "26"),
                      TextWidget(title: "Gender", subTitle: "Other"),
                      TextWidget(
                          title: "Contact Number", subTitle: "9826540705"),
                      TextWidget(title: "Address", subTitle: "Kathmandu"),
                      TextWidget(
                        title: "CitizenShip Number",
                        subTitle: "1234567890",
                      ),
                      TextWidget(
                        title: "CitizenShip Issued District",
                        subTitle: "Kathmandu",
                      ),
                      TextWidget(
                        title: "Farmer Category",
                        subTitle: "",
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Image.asset(
                      Assets.appIcon,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
