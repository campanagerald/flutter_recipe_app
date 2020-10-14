import 'package:flutter/material.dart';

enum DeviceScreenType {
  Mobile,
  Tablet,
  Desktop,
}

class ScreenInformation {
  final DeviceScreenType deviceScreenType;
  final Size size;
  final Orientation orientation;

  ScreenInformation({
    @required this.deviceScreenType,
    @required this.size,
    @required this.orientation,
  });
}

DeviceScreenType _getDeviceScreenType(MediaQueryData mediaQueryData) {
  final deviceWidth = mediaQueryData.size.shortestSide;

  if (deviceWidth > 1112) return DeviceScreenType.Desktop;

  if (deviceWidth > 834) return DeviceScreenType.Tablet;

  return DeviceScreenType.Mobile;
}

ScreenInformation screenInformation(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);

  return ScreenInformation(
    deviceScreenType: _getDeviceScreenType(mediaQuery),
    size: mediaQuery.size,
    orientation: mediaQuery.orientation,
  );
}
