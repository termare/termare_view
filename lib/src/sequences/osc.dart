import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:termare_view/src/painter/model/position.dart';
import 'package:termare_view/termare_view.dart';

bool Function(List<int>, List<int>) eq = const ListEquality<int>().equals;

class Osc {
  static String curSeq = '';
  static bool handle(TermareController controller, List<int> utf8CodeUnits) {
    final String currentChar = utf8.decode(utf8CodeUnits);
    print(utf8CodeUnits);
    if (eq(utf8CodeUnits, [0x07])) {
      print('Osc handle curSeq -> $curSeq');
      // 执行此次序列
      // 执行完清空
      curSeq = '';
      controller.oscStart = false;
      if (controller.verbose) {
        controller.log('$red OSC < Set window title and icon name >');
      }
    } else {
      curSeq += currentChar;
    }
    return true;
    // TODO 有三种，没写完

    // log('line.substring($i)->${data.substring(i).split('\n').first}');
    // final int charWordindex = data.substring(i).indexOf(
    //       String.fromCharCode(7),
    //     );
    // if (charWordindex == -1) {
    //   return true;
    // }
    // String header = '';
    // header = data.substring(i, i + charWordindex);
    // log('osc -> $header');
    // i += header.length;
  }
}