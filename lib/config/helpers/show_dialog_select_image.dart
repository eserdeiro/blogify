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
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: const Text('Choose an option'),
        content: SizedBox(
          width: size.width * 0.8,
          height: size.width * 0.25,
          child: Column(
            children: [
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
          ),
        ),
      );
    },
  );
}
