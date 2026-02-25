import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spex/core/helpers/colors/dark_colors.dart';
import 'package:spex/core/helpers/colors/light_colors.dart';
import 'package:spex/core/helpers/constants/constants.dart';
import 'package:spex/core/helpers/extentions/extentions.dart';
import 'package:spex/core/helpers/fontSelection/font_selection.dart';
import 'package:spex/main.dart';

class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget({
    super.key,
    required this.textFormController,
    this.text,
    this.suffixIconWidget,
    this.isValidator,
    this.enabled,
    this.isLTR,
    this.prefix,
    this.isPhoneNumber = false,
    this.suffixOnPressed,
    this.isPassword = false,
    this.suffixIcon,
    this.textWidth,
    this.textSize,
    this.onChanged,
    this.isDatePicker,
    this.onPressedDate,
    this.readOnly,
    this.isDigit,
    this.isDigitDot,
    this.onEditingComplete,
    this.textHeight,
    this.textFormHeight,
    this.fontWeightIndex,
    this.hintText,
    this.textAlign,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIconSize,
    this.prefixIconSize,
    this.prefixOnPressed,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.contentTextColor,
    this.focusBorderColor,
    this.maxLength,
    this.selectionColor,
    this.focusNode,
    this.nextFocusNode,
    this.maxLines,
    this.inputFormatters,
    this.isColumn,
    this.validator,
    this.keyboardType,
    this.borderRadius,
  });

  final TextEditingController textFormController;
  final String? text;
  final bool? isValidator;
  final bool? enabled;
  final bool? isDigit;
  final bool? isDigitDot;
  final bool? readOnly;
  final void Function()? suffixOnPressed;
  final void Function()? prefixOnPressed;
  final void Function()? onPressedDate;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final double? suffixIconSize;
  final IconData? prefixIcon;
  final Widget? prefix;
  final double? prefixIconSize;
  final bool? isDatePicker;
  final double? textWidth;
  final double? textHeight;
  final double? textFormHeight;
  final double? textSize;
  final void Function(String)? onChanged;
  final Function(String?)? validator;
  final void Function()? onEditingComplete;
  final int? fontWeightIndex;
  final String? hintText;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? textColor;
  final Color? contentTextColor;
  final int? maxLength;
  final Color? selectionColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isColumn;
  final bool? isLTR;
  final double? borderRadius;
  bool isPassword;
  bool isPhoneNumber;
  TextInputType? keyboardType;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionColor: widget.selectionColor ?? Colors.blueGrey,
        ),
      ),
      child: widget.isColumn == true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widgetText(),
                ),
                widgetTextFormField(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgetText(),
                Flexible(child: widgetTextFormField()),
              ],
            ),
    );
  }

  widgetText() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.textWidth,
      height: widget.textHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text ?? "",
            style: TextStyle(
              fontSize:
                  (widget.textSize ??
                  (context.locale.languageCode == 'ar' ? 14 : 12)),
              fontWeight: fontWeightSelection(
                fontWeightIndex: widget.fontWeightIndex,
              ),
              fontFamily: fontSelection(),
              color:
                  widget.textColor ??
                  (isDark
                      ? AppColorsDark.appTextColor
                      : AppColorsLight.appTextColor),
            ),
          ),
          if (context.locale.languageCode == 'ar') const SizedBox(height: 3),
        ],
      ),
    );
  }

  widgetTextFormField() {
    return SizedBox(
      height: widget.textFormHeight ?? 55,
      child: TextFormField(
        // autofocus: true,
        maxLength: widget.maxLength,
        focusNode: widget.focusNode ?? focusNode,
        textAlign: widget.textAlign ?? TextAlign.start,
        controller: widget.textFormController,
        readOnly: widget.readOnly ?? false,
        maxLines: widget.maxLines ?? 1,
        keyboardType: widget.keyboardType,
        style: TextStyle(
          fontSize: (widget.textSize ?? 14),
          fontWeight: fontWeightSelection(
            fontWeightIndex: widget.fontWeightIndex,
          ),
          fontFamily: fontSelection(),
          color:
              widget.contentTextColor ??
              (isDark
                  ? AppColorsDark.appTextColor
                  : AppColorsLight.appTextColor),
        ),
        enabled: widget.enabled ?? true,
        inputFormatters:
            widget.inputFormatters ??
            <TextInputFormatter>[
              if (widget.isDigit == true)
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              else if (widget.isDigitDot == true)
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.?\d{0,4}')),
            ],
        validator: widget.validator != null
            ? (value) {
                return widget.validator!(value);
              }
            : (value) {
                if (widget.isValidator == true) {
                  if (!validateTextField(value!)) {
                    return "";
                  }
                }
                return null;
              },
        onTapOutside: (onTapOutside) {
          focusNode.unfocus();
        },
        onEditingComplete: () {
          if (widget.maxLength != null) {
            if (widget.textFormController.text.length == widget.maxLength!) {
              FocusScope.of(context).nextFocus();
              widget.textFormController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: widget.textFormController.text.length,
              );
            }
          } else {
            if (widget.nextFocusNode != null) {
              widget.nextFocusNode!.requestFocus();
            } else {
              (widget.focusNode ?? focusNode).unfocus();
            }
          }
        },
        onChanged:
            widget.onChanged ??
            (value) {
              if (widget.maxLength != null) {
                if (value.length == widget.maxLength!) {
                  FocusScope.of(context).nextFocus();
                  widget.textFormController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: widget.textFormController.text.length,
                  );
                }
              }
            },
        onTap: () {
          (widget.focusNode ?? focusNode).addListener(() {
            if ((widget.focusNode ?? focusNode).hasFocus) {
              widget.textFormController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: widget.textFormController.text.length,
              );
            }
          });
        },
        decoration: InputDecoration(
          counterText: widget.maxLength != null ? '' : null,
          // errorStyle: const TextStyle(height: 0 , fontSize: 0),
          filled: true,
          fillColor: widget.fillColor ?? Colors.grey[300],
          contentPadding: widget.contentPadding ?? EdgeInsets.zero,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: widget.focusBorderColor != null
                ? BorderSide(color: widget.focusBorderColor!, width: 1.2)
                : widget.borderColor != null
                ? BorderSide(color: widget.borderColor!, width: 1.2)
                : BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: widget.borderColor != null
                ? BorderSide(color: widget.borderColor!, width: 1.2)
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: widget.borderColor != null
                ? BorderSide(color: widget.borderColor!, width: 1.2)
                : BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: widget.borderColor != null
                ? BorderSide(color: widget.borderColor!, width: 1.2)
                : BorderSide.none,
          ),
          suffixIcon: widget.isDatePicker == true
              ? IconButton(
                  padding: EdgeInsets.zero,
                  alignment: AlignmentDirectional.centerEnd,
                  icon: Icon(
                    Icons.date_range,
                    size: widget.suffixIconSize ?? 24,
                  ),
                  onPressed: widget.onPressedDate,
                )
              : widget.suffixIcon != null
              ? IconButton(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  alignment: AlignmentDirectional.center,
                  icon: Icon(
                    widget.suffixIcon,
                    size: widget.suffixIconSize ?? 24,
                  ),
                  onPressed: widget.suffixOnPressed,
                )
              : widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                      widget.isPassword = true;
                    });
                  },
                  icon: Icon(
                    !obscureText ? Icons.visibility : Icons.visibility_off,
                    color: isDark
                        ? AppColorsDark.appSecondTextColor
                        : AppColorsLight.appSecondTextColor,
                    size: widget.suffixIconSize ?? 24,
                  ),
                )
              : widget.suffixIconWidget,
          suffixIconColor: widget.suffixOnPressed != null
              ? AppColorsLight.mainColor
              : Colors.grey,
          prefixIcon: widget.prefixIcon != null
              ? IconButton(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  alignment: AlignmentDirectional.center,
                  icon: Icon(
                    widget.prefixIcon,
                    size: widget.prefixIconSize ?? 24,
                  ),
                  onPressed: widget.prefixOnPressed,
                )
              : widget.prefix,
          prefixIconColor: widget.prefixOnPressed != null
              ? AppColorsLight.mainColor
              : Colors.grey,
          hintMaxLines: 1,
          hintText: widget.hintText ?? '',

          hintStyle: TextStyle(
            color: isDark
                ? AppColorsDark.appSecondTextColor
                : AppColorsLight.appSecondTextColor,
            fontSize: widget.textSize ?? 14,
            fontFamily: fontSelection(),
            fontWeight: fontWeightSelection(
              fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            ),
          ),
        ),
        obscureText: widget.isPassword ? obscureText : false,
      ),
    );
  }
}

bool validateTextField(String value) {
  if (value.isEmpty) {
    return false;
  } else {
    return true;
  }
}
