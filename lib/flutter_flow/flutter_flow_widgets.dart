import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class FFButtonWidget extends StatelessWidget {
  const FFButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.loading = false,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final FFButtonOptions options;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            text,
            style: options.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
    if (icon != null || iconData != null) {
      textWidget = Flexible(child: textWidget);
      return Container(
        height: options.height,
        width: options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: icon ??
                FaIcon(
                  iconData,
                  size: options.iconSize,
                  color: options.iconColor ?? options.textStyle!.color,
                ),
          ),
          label: textWidget,
          onPressed: loading ? () {} : onPressed,

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(options.color),
            padding: MaterialStateProperty.all(options.padding),
            textStyle: MaterialStateProperty.all(
                TextStyle(color: options.textStyle!.color)),
            elevation: MaterialStateProperty.all(options.elevation),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(options.borderRadius ?? 28),
                side: options.borderSide ?? BorderSide.none,
              ),
            ),
          ),

          // colorBrightness: ThemeData.estimateBrightnessForColor(options.color),

          // disabledColor: options.disabledColor,
          // disabledTextColor: options.disabledTextColor,

          // splashColor: options.splashColor,
        ),
      );
    }

    return Container(
      height: options.height,
      width: options.width,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(options.color),
          padding: MaterialStateProperty.all(options.padding),
          textStyle: MaterialStateProperty.all(
              TextStyle(color: options.textStyle!.color)),
          elevation: MaterialStateProperty.all(options.elevation),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(options.borderRadius ?? 28),
              side: options.borderSide ?? BorderSide.none,
            ),
          ),
        ),

        // colorBrightness: ThemeData.estimateBrightnessForColor(options.color),
        // disabledColor: options.disabledColor,
        // disabledTextColor: options.disabledTextColor,

        child: textWidget,
      ),
    );
  }
}
