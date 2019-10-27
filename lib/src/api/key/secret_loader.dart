import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rapatory/src/api/key/secret.dart';

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath, (jsonString) async {
      final secret = Secret.fromJson(json.decode(jsonString));
      return secret;
    });
  }
}