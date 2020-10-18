import 'package:flutter/material.dart';

class PasswordModel {
  final String websiteName;
  final String websiteUserId;
  final String websitePassword;

  PasswordModel({
    @required this.websiteName,
    this.websiteUserId,
    this.websitePassword,
  });
}
