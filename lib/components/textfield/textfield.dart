import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/responsiveness/responsive.dart';
import 'package:shared/theme/colors.dart';
import 'package:shared/utils/icons.dart';

import '../../responsiveness/shared_font_style.dart';

class SharedTextfield extends StatefulWidget {
  const SharedTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.onFieldSubmitted,
    this.isObscureText = false,
    this.label,
    this.enable = true,
    this.hasLabel = false,
    this.suffix,
    this.formatter,
    this.onChanged,
    this.validator,
    this.onEditingComplete,
    this.inputType = TextInputType.emailAddress,
    this.inputAction = TextInputAction.done,
    this.maxLength,
    this.radius = 10,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String hint;
  final Widget? suffix;
  final FormFieldValidator? validator;
  final String? label;
  final bool isObscureText;
  final bool enable;
  final bool hasLabel;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final double radius;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  final Function(String value)? onFieldSubmitted;

  @override
  State<SharedTextfield> createState() => _SharedTextfieldState();
}

class _SharedTextfieldState extends State<SharedTextfield> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isObscureText;
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    final hasSuffix = widget.isObscureText;
    EdgeInsets contentPadding = EdgeInsets.only(
      top: hasError
          ? Responsive.getSize(18)
          : hasSuffix
          ? Responsive.getSize(8)
          : Responsive.getSize(0),
      left: Responsive.getSize(6),
    );
    EdgeInsets suffixPadding = EdgeInsets.only(
      top: hasError ? Responsive.getSize(18) : Responsive.getSize(0),
      left: Responsive.getSize(6),
    );
    Widget? handledSuffix;
    if (widget.isObscureText) {
      handledSuffix = Padding(
        padding: suffixPadding,
        child: InkWell(
          onTap: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: Icon(isObscure ? SharedIcons.visibleOff : SharedIcons.visible),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: EdgeInsets.only(left: Responsive.getSize(2.0)),
            child: Text(widget.label!, style: SharedFontStyle.titleBold),
          ),
          SizedBox(height: Responsive.getSize(10)),
        ],
        Container(
          alignment: Alignment.center,
          height: Responsive.getSize(44.0 * widget.maxLines!),
          decoration: BoxDecoration(
            border: Border.all(color: primaryFocusColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          ),
          width: double.infinity,
          child: TextFormField(
            onEditingComplete: widget.onEditingComplete,
            enabled: widget.enable,
            textInputAction: widget.inputAction,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: SharedFontStyle.bodyLargeBold.copyWith(
                color: primaryFocusColor,
              ),
              border: InputBorder.none,
              labelStyle: SharedFontStyle.bodyLargeBold,
              suffixIcon: handledSuffix,
              contentPadding: contentPadding,
            ),
            keyboardType: widget.inputType,
            obscureText: isObscure,
            inputFormatters: widget.formatter,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            validator: (value) {
              final isValid = widget.validator?.call(value);
              if (isValid != null) {
                setState(() {
                  hasError = true;
                });
              } else {
                setState(() {
                  hasError = false;
                });
              }
              return isValid;
            },
            onChanged: widget.onChanged,
            maxLength: widget.maxLength,
          ),
        ),
      ],
    );
  }
}
