import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customPopup({
  required BuildContext context,
  required void Function()? onPressedDelete,
  required String title,
  required String content,
  String? cancel,
  String? yes,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              // Close the dialog without deleting anything
              Navigator.of(context).pop();
            },
            child: Text(
              cancel ?? 'Cancel',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true, // Indicates destructive action (delete)
            onPressed: onPressedDelete,
            child: Text(
              yes ?? 'Delete',
              style: const TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      );
    },
  );
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: const Text('Confirm Delete'),
  //       content: const Text('Are you sure you want to delete?'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             // Close the dialog without deleting anything
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         const Spacer(),
  //         ElevatedButton(
  //           onPressed: onPressedDelete,
  //           child: const Text('Delete'),
  //         ),
  //       ],
  //     );
  //   },
  // );
}
