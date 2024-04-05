import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static launchFile(File file) async {
    String filePath = file.absolute.path;
    final Uri uri = Uri.file(filePath);

    if (!File(uri.path).existsSync()) {
      throw Exception('$uri does not exist!');
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $uri';
    }
  }

  static launchEmail(String email) async {
    String email0 = Uri.encodeComponent(email);
    Uri mail = Uri.parse("mailto:$email0");
    if (await launchUrl(mail)) {
      debugPrint("email app opened");
    } else {
      debugPrint("email app is not opened");
    }
  }

  static launchPhone(String phoneNumber) async {
    Uri phone = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phone)) {
      await launchUrl(phone);
    } else {
      debugPrint("contact app is not opened");
    }
  }

  static launchCustomUrl(String url) async {
    String tempUrl = url;
    if (!url.contains("https://")) {
      tempUrl = "https://$url";
    }
    Uri urlValue = Uri.parse(tempUrl);
    await launchUrl(
      urlValue,
    );
    if (await canLaunchUrl(
      urlValue,
    )) {
    } else {
      debugPrint("contact app is not opened");
    }
  }
}
