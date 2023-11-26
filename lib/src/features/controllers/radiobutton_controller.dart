import 'package:flutter/material.dart';

class RadioButtonController extends StatefulWidget {
  final List<String> statuslist;
  final String? selectedvalue;
  final Function(String?) getselectedvalue;
  const RadioButtonController({
    super.key,
    required this.statuslist,
    required this.selectedvalue,
    required this.getselectedvalue,
  });

  @override
  State<RadioButtonController> createState() => _RadioButtonControllerState();
}

class _RadioButtonControllerState extends State<RadioButtonController> {
  String? selectedvalue;
  @override
  void initState() {
    super.initState();
    selectedvalue = widget.selectedvalue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var status in widget.statuslist) ...{
          RadioListTile<String>(
            value: status,
            groupValue: selectedvalue,
            title: Text(
              status,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            onChanged: (val) {
              widget.getselectedvalue(val);
              setState(
                () {
                  selectedvalue = val;
                },
              );
            },
            toggleable: true,
            selected: true,
          ),
          const SizedBox(
            height: 10,
          ),
        },
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
