import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomStatusBar extends StatelessWidget {
  final Color backgroundColor;
  final Brightness iconBrightness;

  const CustomStatusBar({
    Key? key,
    this.backgroundColor = const Color(0xFF1E5C4E),
    this.iconBrightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set system status bar style to match app header
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness:
        iconBrightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );

    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: MediaQuery.of(context).padding.top,
    );
  }
}

/// Wraps any scaffold with the correct status bar color overlay
class StatusBarWrapper extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness iconBrightness;

  const StatusBarWrapper({
    Key? key,
    required this.child,
    this.statusBarColor = const Color(0xFF1E5C4E),
    this.iconBrightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness:
        iconBrightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: iconBrightness,
      ),
      child: child,
    );
  }
}