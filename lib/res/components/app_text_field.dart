
import '../paths/paths.dart';

class AppTextField extends StatelessWidget {

  const AppTextField({
    required this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.inputFormatters,
    this.enable = true,
    this.width = 300,
    this.height = 35,
    this.fontSize = 12,
    super.key});


  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool obscureText;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  final double width;
  final double height;
  final double fontSize;



  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        cursorHeight: 12,
        cursorColor: AppColor.primaryColor,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        onChanged: onChanged,
        enabled: enable,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
      ),
    );
  }
}
