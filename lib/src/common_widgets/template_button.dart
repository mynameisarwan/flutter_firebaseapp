import 'package:flutter/material.dart';

class ButtonTemplate extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;
  const ButtonTemplate({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              // states.contains(MaterialState.pressed)
              //     ? const Color.fromARGB(255, 249, 87, 0)
              //     : Colors.white;
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(255, 249, 87, 0);
              }
              // if (states.contains(MaterialState.hovered)) {
              //   return const Color.fromARGB(255, 249, 87, 0);
              // }
              return Colors.white;
            },
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10.0),
                right: Radius.circular(10.0),
              ),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
