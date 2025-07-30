import 'dart:math';
import 'dart:io';
import 'dart:ffi';

import 'package:desktop/dto/mouse_dto.dart';
import 'package:ffi/ffi.dart';
import 'package:mouse/mouse.dart' as ms;
import 'package:win32/win32.dart';

class MouseControl {
  final MouseDto mouse;

  MouseControl({required this.mouse});

  void moveMouse() {
    print("Current position: ${ms.getPosition()}");

    final axioXCurrent = ms.getPosition().x;
    final axioYCurrent = ms.getPosition().y;

    final targetPosition = Point(
      axioXCurrent + mouse.x * 25,
      axioYCurrent + mouse.y * 25,
    );

    final currentPosition = Point(
      _smoothing(axioXCurrent, targetPosition.x, 0.1),
      _smoothing(axioYCurrent, targetPosition.y, 0.1),
    );

    ms.moveTo(currentPosition);
  }

  double _smoothing(double start, double end, double t) {
    return start + (end - start) * t;
  }

  void rightClick() {
    ms.rightClick();
  }

  void leftClick() {
    ms.click();
  }

  void scrollUp() {
    switch (Platform.operatingSystem) {
      case 'windows':
        _scrollInWindows(true);
      case 'linux':
        print("Scroll up in linux");
      case 'macos':
        print("Scroll up in macos");
      default:
        throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}',
        );
    }
  }

  void scrollDown() {
    switch (Platform.operatingSystem) {
      case 'windows':
        _scrollInWindows(false);
      case 'linux':
        print("Scroll down in linux");
      case 'macos':
        print("Scroll down in macos");
      default:
        throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}',
        );
    }
  }

  void _scrollInWindows(bool up) {
    final input = calloc<INPUT>();
    input.ref.type = INPUT_MOUSE;
    input.ref.mi.dwFlags = MOUSEEVENTF_WHEEL;
    input.ref.mi.mouseData = up ? 120 : -120;

    SendInput(1, input, sizeOf<INPUT>());
    calloc.free(input);
  }
}
