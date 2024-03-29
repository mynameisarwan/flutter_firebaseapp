import 'package:flutter/material.dart';

Text textAlignFormTemplate({
  required String textlabe,
  required bool isbold,
  required double size,
  required Color color,
  required TextAlign textAlign,
}) {
  return Text(
    textlabe,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isbold ? FontWeight.bold : FontWeight.w300,
    ),
    textAlign: textAlign,
  );
}

Text textFormTemplate(
  String textlabe,
  bool isbold,
  double size,
  Color color,
) {
  return Text(
    textlabe,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isbold ? FontWeight.bold : FontWeight.w300,
    ),
  );
}

Image logoWidget(String path) {
  return Image.asset(
    path,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
  );
}

Image profileImage(
  String path,
  double width,
  double height,
) {
  return Image.asset(
    path,
    fit: BoxFit.fitWidth,
    width: width,
    height: height,
  );
}

TextFormField textFieldTemplFormOnChange(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  bool readOnly,
  void Function(String)? onChanged,
) {
  return TextFormField(
    onChanged: onChanged,
    controller: controller,
    readOnly: readOnly,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

TextFormField textFieldTemplForm(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  bool readOnly,
) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

TextFormField textFieldTemplFormTap(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  bool readonly,
  void Function()? onTap,
) {
  return TextFormField(
    controller: controller,
    readOnly: readonly,
    onTap: onTap,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Colors.amber[900]!,
          width: 2.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

TextFormField textFieldCalendarTemplForm(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  void Function()? onTab,
) {
  return TextFormField(
    controller: controller,
    readOnly: true,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    onTap: onTab,
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

String? verification(String? inputValue) {
  if (inputValue!.isEmpty) {
    return 'Empty Field';
  }
  return null;
}

TextFormField textFieldTemplFormWithNotif(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  String? Function(String?)? validator,
  bool readOnly,
) {
  return TextFormField(
    readOnly: readOnly,
    validator: validator,
    controller: controller,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

TextFormField textFieldTemplFormWithNotifTap(
  TextEditingController controller,
  String labelText,
  IconData icon,
  TextInputType inputType,
  String? Function(String?)? validator,
  bool readOnly,
  void Function()? onTap,
) {
  return TextFormField(
    readOnly: readOnly,
    validator: validator,
    controller: controller,
    onTap: onTap,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.white.withOpacity(0.7),
        weight: 10,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(10),
          right: Radius.circular(10),
        ),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 140, 0),
          width: 1.0,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: Color.fromARGB(255, 255, 213, 0),
          width: 2.0,
        ),
      ),
    ),
  );
}

TextField textFieldTemplLogin(
  String text,
  IconData icon,
  bool isPassword,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(
      color: Colors.white.withOpacity(0.9),
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white70),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
  BuildContext context,
  bool isLogin,
  Function onTab,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTab();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogin ? 'Login' : 'Sign Up',
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}
