import 'dart:convert';

import 'package:termare/src/termare_controller.dart';

class SequencesTest {
  static void testC0(TermareController controller) {
    controller.out += '\n';
    controller.out += 'bell test\x07\n';
    controller.out += 'Backspace Teaa\x08\x08st\n';
    controller.out += 'Horizontal\x09Tabulation\n';
    // 因为\x0a转换成string就是\n，所以不会被序列单独检测到
    controller.out += 'Line Feed\x0a\n';
    controller.out += 'Line Feed\x0b\n';
    controller.out += 'Line Feed\x0c\n';
    controller.out += '${'a' * 47}\x0dbbb\n';
    // controller.out += 'Last login: Fri Nov 20 08:16:19 on console 啊';
    controller.out += utf8.decode([
      27,
      91,
      48,
      49,
      59,
      51,
      52,
      109,
      97,
      99,
      99,
      116,
      27,
      91,
      48,
      109,
    ]);
  }
}
