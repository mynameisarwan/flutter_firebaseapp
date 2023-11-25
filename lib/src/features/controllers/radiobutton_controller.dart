import 'package:flutter/material.dart';

class RadioButtonController extends StatelessWidget {
  final List<String> statuslist;
  final String? selectedvalue;
  final Function(String?)? onchage;
  const RadioButtonController({
    super.key,
    required this.statuslist,
    required this.selectedvalue,
    required this.onchage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var status in statuslist) ...{
          RadioListTile<String>(
            title: Text(
              status,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            value: status,
            groupValue: selectedvalue,
            onChanged: onchage,
          ),
          const SizedBox(
            height: 10,
          ),
        }
      ],
    );
  }
}


// class RadioButtonController {
//   static List<Widget> radiobutton(
//     List<String> statuslist,
//     String? selectedvalue,
//     Function(String?)? onchage,
//   ) =>
//       [
//         Text('text : $selectedvalue'),
//         for (var status in statuslist) ...{
//           RadioListTile<String>(
//             title: Text(
//               status,
//               style: const TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             value: status,
//             groupValue: selectedvalue,
//             onChanged: onchage,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//         }
//       ];
// }
