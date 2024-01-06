import 'package:flutter/material.dart';

Future<void> dialogConfBuilder(
  BuildContext context,
  void Function()? onPressed,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        icon: const Icon(
          Icons.warning_amber_rounded,
          size: 64,
          weight: 100,
        ),
        iconColor: Colors.red,
        title: const Text('The Data Will be Deleted, Are you sure?'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 24,
          color: Colors.black,
        ),
        actions: [
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 249, 87, 0);
                  }
                  return Colors.white;
                },
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return const Color.fromARGB(255, 249, 87, 0);
                },
              ),
            ),
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color.fromARGB(255, 3, 232, 79);
                  }
                  return Colors.white;
                },
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return const Color.fromARGB(255, 3, 232, 79);
                },
              ),
            ),
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}
