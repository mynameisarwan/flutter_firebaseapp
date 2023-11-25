import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DropDownSourceController extends GetxController {
  DropDownSourceController({required this.dropdowndatalist});

  final Rx<String?> selectedString = "Candidate".obs;
  final List<String> dropdowndatalist;
}
