import 'package:enable_hire_user/theme/styles.dart';
import 'package:enable_hire_user/utils/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class MyTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  Widget? prefixIconData;
  Widget? suffix;
  Function()? onTap;
  bool? readOnly;
  bool hasTitle;
  bool hasPrefix;
  String? title;
  TextInputType? keyboardType;
  int? maxLines = 1;
  void Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;
  bool isRequired;
  String? Function(String?)? validator;
  FocusNode? focusNode;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIconData,
    this.suffix,
    this.onTap,
    this.readOnly,
    this.maxLines,
    this.title,
    this.hasTitle = false,
    this.hasPrefix = false,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.isRequired = false,
    this.validator,
    this.focusNode,

  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hasTitle
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      title ?? "",
                      style: Styles.mediumText(context, ref),
                    ),
                    isRequired
                        ? Text(
                            "*",
                            style: Styles.mediumText(context,ref)
                                .copyWith(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            : const SizedBox(),
        TextFormField(
          focusNode:focusNode ,
          validator: validator,
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          keyboardType: keyboardType,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          maxLines: maxLines,
          readOnly: readOnly ?? false,
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontFamily: Strings.appFont),
          cursorColor: Styles.primary,
          controller: controller,
          onTap: onTap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: prefixIconData == null ? 0 : 10, vertical: 15),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            prefixIconConstraints:
                BoxConstraints.tight(Size(!hasPrefix ? 10 : 45, 45)),
            suffixIcon: suffix ?? const SizedBox(),
            prefixIcon: Padding(
                padding: EdgeInsets.all(prefixIconData == null ? 0 : 12.0),
                child: prefixIconData),
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w400,
            ),
            errorStyle: Styles.smallText(context,ref)
                .copyWith(color: Colors.redAccent, fontWeight: FontWeight.w400),
            errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Styles.primary),
            ),
            enabledBorder: OutlineInputBorder(
                gapPadding: 0,
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
