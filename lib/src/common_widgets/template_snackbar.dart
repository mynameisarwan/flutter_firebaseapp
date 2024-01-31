import 'package:flutter/material.dart';

SnackBar showSnackBar(String msg) {
  return SnackBar(
    content: Text(msg),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
