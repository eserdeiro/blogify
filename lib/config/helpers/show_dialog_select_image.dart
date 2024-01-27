import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showDialogSelectImage(
  BuildContext context,
  Future<void> Function() selectPhoto,
    Future<void> Function() takePhoto,
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Choose an option'),
        actions: [
          CustomElevatedButton(
            text: 'Select photo',
            onPressed: () async {
             context.pop();
              await selectPhoto();
            },
          ),
          CustomElevatedButton(
            text: 'Take photo',
            onPressed: () async {
              context.pop();
              await takePhoto();
            },
          ),
        ],
      );
    },
  );
}
