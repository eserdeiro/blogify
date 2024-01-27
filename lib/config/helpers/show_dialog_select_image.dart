import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

Future showDialogSelectImage(
  BuildContext context,
  Function() selectPhoto,
  Function() takePhoto,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Choose a option'),
      actions: [
        CustomElevatedButton(
          text: 'Select photo',
          onPressed: selectPhoto,
        ),
        CustomElevatedButton(
          text: 'Take photo',
          onPressed: takePhoto,
        ),
      ],
    ),
  );
}
