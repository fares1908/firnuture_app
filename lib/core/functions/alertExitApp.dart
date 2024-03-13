import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title:  'Warning',
      middleText:"Do you really want to exit the application",
      actions: [
        ElevatedButton(
          style: const ButtonStyle(

          ),
            onPressed: () {
              exit(0);
            },
            child: const Text(
               ' confirm'
            )),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'cancel'
          ),
        )
      ]);
  return Future.value(true);
}
