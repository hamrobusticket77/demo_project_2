import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  @override
  Widget build(BuildContext context) {
    final env = RepositoryProvider.of<Env>(context);
    return Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.privacyPolicy.tr(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  """
Last Updated: **${env.environment.appUpdateDate}**

PRIVACY POLICY

This Privacy Policy (the “Privacy Policy”) describes the consented information Care pvt Ltd collects via Krishi Portal (“App”) from or about User(s). It also describes how Company may use, share, and handle the information so collected.

Company views protection of User(s) privacy as a very important principle. Company stores and processes User(s) information which defined under the Information Technology Act, 2000, if any, on computers, devices that may be protected by physical as well as reasonable technological security measures and procedures in accordance with Information Technology Act 2000 and Rules there under.

Before using our App, User(s) should review this Privacy Policy and the Terms of Use on our App. By using the App, User(s) are consenting to the collection, processing, use, and disclosure of User(s) Personal Information as set forth in this Privacy Policy. If User(s) do not agree to be bound by this Policy, User(s) are not authorised to, and User(s) may not, access or use our App.

Please read the following statement to learn about our information gathering and dissemination practices.

Note:

Our Privacy Policy is subject to change at any time without notice. To make sure you are aware of any changes, please review this policy periodically.

By visiting this App User(s) agree to be bound by the terms and conditions of this Privacy Policy. If User(s) do not agree please do not use or access our App.

By mere use of the App, User(s) expressly consent to Company’s use and disclosure of User(s) Personal Information in accordance with this Privacy Policy. This Privacy Policy is incorporated into and subject to the Terms of Use.

 Collection of Personally Identifiable Information and other Information:
When User(s) use the App, it collects and stores Personal Information which is provided by User(s) from time to time. Company’s primary goal in doing so is to provide a safe, efficient, smooth and customized experience to the User(s). This allows Company to provide services and features that most likely meet User(s) needs, and to customize App to make User(s) experience safer and easier. More importantly, while doing so we collect personal information from User(s) that we consider necessary for achieving this purpose.

When User(s) use the App, at the first step for downloading the App, it shall request permission to access data stored in User(s) device like photos, mobile user accounts details and contacts, User(s) have choice to answer in “yes” or “no” accordingly User(s) may proceed further for downloading and accessing the information provided in the App.

Once User(s) gives personal information on the App User(s) give us personal information and hence User(s) are not anonymous to Company. Where possible, Company indicates which fields are required and which fields are optional. Company may automatically track certain information about User(s) based upon behaviour on the App. Company may use this information to do internal research on User(s) demographics, interests, and behaviour to better understand, protect and serve our User(s). This information is compiled and analysed on an aggregated basis. This information may include the URL that User(s) just came from (whether this URL is on the App or not), which URL you next go to (whether this URL is on App or not), your computer browser information, and User’s IP address.

If User(s) want to remove contact information from the App lists then write to us at app.inforamationcare@gmail.com
6. Advertisements on App Company uses third-party advertising companies to serve ads when User(s) visit the App. These companies may use information (not including your name, address, email address, or telephone number) about User(s) visits to this and other websites in order to provide advertisements about goods and services of interest to the User(s). 7. Your Consent By using the App and/ or by providing information, User(s) consent to the collection and use of the information that is disclosed on the App or the information created while using the App.in accordance with this privacy policy, including but not limited to consent for sharing information as per this privacy policy.

If Company decides to change its privacy policy, the changes or the revised Privacy Policy will be posted on this page so that User(s) are always aware of what information Company collect, how it is used, and under what circumstances Company discloses it.
""",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
