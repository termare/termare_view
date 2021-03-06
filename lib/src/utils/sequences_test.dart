import 'package:termare_view/src/sequences/csi.dart';
import 'package:termare_view/src/termare_controller.dart';

class SequencesTest {
  static Future<void> testChinese(TermareController controller) async {
    controller.write('${'啊' * 3000}\x08\x08 WWww\n');
  }

  static Future<void> testColorText(TermareController controller) async {
    // 用来测试颜色序列
    controller.write(' \x1B[1;31m红色字\x1B[0m\n');
    controller.write(' \x1B[1;32m绿色字\x1B[0m\n');
    controller.write(' \x1B[1;33m黄色字\x1B[0m\n');
    controller.write(' \x1B[1;34m蓝色字\x1B[0m\n');
    controller.write(' \x1B[1;35m紫色字\x1B[0m\n');
    controller.write(' \x1B[1;36m天蓝字\x1B[0m\n');
    controller.write(' \x1B[1;37m白色字\x1B[0m\n');
    //
    controller.write(' \x1B[40;37m黑底白字\x1B[0m\n');
    controller.write(' \x1B[41;37m红底白字\x1B[0m\n');
    controller.write(' \x1B[42;37m绿底白字\x1B[0m\n');
    controller.write(' \x1B[43;37m黄底白字\x1B[0m\n');
    controller.write(' \x1B[44;37m蓝底白字\x1B[0m\n');
    controller.write(' \x1B[45;37m紫底白字\x1B[0m\n');
    controller.write(' \x1B[46;37m天蓝底白字\x1B[0m\n');
    controller.write(' \x1B[47;30m白底黑字\x1B[0m\n');
  }

  static Future<void> testMang(TermareController controller) async {
    final List<String> list = [
      '⣿',
      '⣷',
      '⣯',
      '⣟',
      '⡿',
      '⣿',
      '⢿',
      '⣻',
      '⣽',
      '⣾'
    ];
    for (final String str in list) {
      controller.write('$str\b');
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }

  static Future<void> testIsOut(TermareController controller) async {
    // 测试终端自动滚动
    controller.write('\n');
    for (int i = 0; i < 5500; i++) {
      controller.write('${'${i % 10}' * 40}\n');
      controller.autoScroll = true;
      controller.dirty = true;
      controller.notifyListeners();
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    controller.write('${'b' * 40}\n');
    controller.write('${'c' * 40}\n');
  }

  static String _spiltLine(String title) {
    return '${'-' * ((60 - title.length) ~/ 2)} $title ${'-' * ((60 - title.length) ~/ 2)}\n';
  }

  static String getTestChar(String rawChar, String char) {
    return '\x1b[32m➜\x1b[0m' + rawChar + '    \x1b[35m➜\x1b[0m' + char + '\n';
  }

  static void testC0(TermareController controller) {
    print(_spiltLine('C0 TEST START'));
    controller.write(_spiltLine('C0 TEST START'));
    controller.write(getTestChar(r'Null\x00', 'Null\x00'));
    controller.write(getTestChar(r'bell\x07', 'bell\x07'));
    controller.write(
      getTestChar(r'Backspace Tea\x08st', 'Backspace Tea\x08st'),
    );
    controller.write(
      getTestChar(r'Horizontal\x09Tabulation', 'Horizontal\x09Tabulation'),
    );
    controller.write(
      getTestChar(r'Line Feed\x0a*', 'Line Feed\x0a*'),
    );
    controller.write(
      getTestChar(r'Line Feed\x0b*', 'Line Feed\x0b*'),
    );
    controller.write(
      getTestChar(r'Line Feed\x0c*', 'Line Feed\x0c*'),
    );
    controller.write(
      getTestChar(
          r'tmp tmp tmp\x0dCarriage Return', 'tmp tmp tmp\x0dCarriage Return'),
    );
    controller.write(
      getTestChar(r'Shift Out \x0e', 'Shift Out \x0e'),
    );
    controller.write(
      getTestChar(r'Shift In \x0f', 'Shift In \x0f'),
    );
    controller.write(
      getTestChar(r'Escape \x1b', 'Escape \x1b '),
    );
    controller.write(_spiltLine('C0 TEST END'));
    print(_spiltLine('C0 TEST END'));
  }

  static void testDECSEL(TermareController controller) {
    controller.write('\n');
    controller.write('Backspace Teaa\x08\x1b[k\x08\x1b[kst\n');
  }

  static void testC1(TermareController controller) {
    print(_spiltLine('C1 TEST START'));
    controller.write(_spiltLine('C1 TEST START'));
    controller.write(
      getTestChar(r'Index\x84*', 'Index\x84*'),
    );
    controller.write(
      getTestChar(r'Next Line\x85*', 'Next Line\x85*'),
    );
    controller.write(
      getTestChar(
        r'Horizontal\x88 Tabulation Set',
        'Horizontal\x88 Tabulation Set',
      ),
    );
    controller.write(
      getTestChar(r'Device Control String\x90', 'Device Control String\x90'),
    );
    controller.write(
      getTestChar(
        r'Control Sequence Introducer\x9b',
        'Control Sequence Introducer\x9b ',
      ),
    );
    controller.write(
      getTestChar(
        r'String Terminator\x9c',
        'String Terminator\x9c',
      ),
    );
    controller.write(
      getTestChar(
        r'Operating System Command\x9d ',
        'Operating System Command\x9d0;termare\x07 ',
      ),
    );
    controller.write(
      getTestChar(
        r'Privacy Message\x9e',
        'Privacy Message\x9e',
      ),
    );
    controller.write(
      getTestChar(
        r'Application Program Command\x9f',
        'Application Program Command\x9f',
      ),
    );
    controller.write(_spiltLine('C1 TEST END'));
    print(_spiltLine('C1 TEST END'));
  }

  static void testESC(TermareController controller) {
    print(_spiltLine('ESC TEST START'));
    controller.write(_spiltLine('ESC TEST START'));
    controller.write(getTestChar(
      r'\x1b[31m\x1b7',
      '\x1b[41;37m\x1b7 hello\x1b[0mdefault textAttributes',
    ));
    controller.write(getTestChar(r'\x1b8\x1b[0m\n', '\x1b8back\x1b[0m\n'));
    controller.write(getTestChar(r'\x1bD', '\x1bD'));
    controller.write(getTestChar(r'\x1bE', '\x1bE'));
    controller.write(getTestChar(r'\x1bH', '\x1bH'));
    controller.write(getTestChar(r'\x1bM', '\x1bM'));
    controller.write(getTestChar(r'\x1bP', '\x1bP'));
    controller.write(getTestChar(r'\x1b[', '\x1b[ '));
    controller.write(getTestChar(r'\x1b]', '\x1b] '));
    controller.write(getTestChar(r'\x1b^', '\x1b^'));
    controller.write(getTestChar(r'\x1b_', '\x1b_'));
    // controller.write(getTestChar(r'bell\x07', 'bell\x07'));
    // controller.write(
    //   getTestChar(r'Backspace Tea\x08st', 'Backspace Tea\x08st'),
    // );
    // controller.write(
    //   getTestChar(r'Horizontal\x09Tabulation', 'Horizontal\x09Tabulation'),
    // );
    // controller.write(
    //   getTestChar(r'Line Feed\x0a', 'Line Feed\x0a'),
    // );
    // controller.write(
    //   getTestChar(r'Line Feed\x0b', 'Line Feed\x0b'),
    // );
    // controller.write(
    //   getTestChar(r'Line Feed\x0c', 'Line Feed\x0c'),
    // );
    // controller.write(
    //   getTestChar(
    //       r'tmp tmp tmp\x0dCarriage Return', 'tmp tmp tmp\x0dCarriage Return'),
    // );
    // controller.write(
    //   getTestChar(r'Shift Out \x0e', 'Shift Out \x0e'),
    // );
    // controller.write(
    //   getTestChar(r'Shift In \x0f', 'Shift In \x0f'),
    // );
    // controller.write(
    //   getTestChar(r'Escape \x1b', 'Escape \x1b '),
    // );
    controller.write(_spiltLine('ESC TEST END'));
    print(_spiltLine('ESC TEST END'));
  }

  static void testOSC(TermareController controller) {
    // controller.write('\x1b\x5d0;termare \x07set title to termare\n');
    controller.write('\x9d0;termare\x07set title to termare\n');
  }

  static void testCSI(TermareController controller) {
    // csiInput('2${csiSeqChars[11]}');
    final List<String> csiSeqChars = List.from(csiSeqHandlerMap.keys);
    void csiInput(String sequence) {
      controller.write('\x1b[$sequence');
    }

    void write(String data) {
      controller.write(data);
    }

    csiInput('2${csiSeqChars[11]}');
    write('123\b\b');
    csiInput('3${csiSeqChars[0]}');
    write('.\n');
    write('123');
    csiInput('${csiSeqChars[1]}');
    csiInput('2${csiSeqChars[2]}');
    csiInput('2${csiSeqChars[3]}');
    csiInput('2${csiSeqChars[4]}');
    csiInput('2${csiSeqChars[5]}');
    csiInput('2${csiSeqChars[6]}');
    csiInput('2${csiSeqChars[7]}');
    write('456');

    csiInput('1;1${csiSeqChars[8]}');
    write('\n\n\n');

    csiInput('1${csiSeqChars[9]}');
    write('12345\b\b\b');
    // csiInput('1;1${csiSeqChars[8]}');
    // csiInput('?1${csiSeqChars[10]}');
    // csiInput('?2${csiSeqChars[10]}');

    // csiInput('${csiSeqChars[11]}');
    // csiInput('1${csiSeqChars[11]}');
    // csiInput('2${csiSeqChars[11]}');
    csiInput('3${csiSeqChars[12]}');

    write('12345678\b\b\b');
    csiInput('2${csiSeqChars[14]}');
    // csiInput('1${csiSeqChars[16]}678');
    // write('\n\n\n1234\b\x1b[Z67899');
    // csiInput('1${csiSeqChars[19]}');
    // csiInput('1${csiSeqChars[20]}');
    // write('\n\n123');
    // csiInput('3${csiSeqChars[21]}456');
    // csiInput('2${csiSeqChars[23]}456');
    // csiInput('2${csiSeqChars[24]}456');
    // // csiInput('?2${csiSeqChars[10]}');
    // csiInput('1;1${csiSeqChars[25]}456');
    // csiInput('10;1${csiSeqChars[25]}456');
    // // csiInput('?25${csiSeqChars[27]}456');
    // // csiInput('?25${csiSeqChars[28]}456');
    // write('\n\n123\b\b\b');
    // csiInput('${csiSeqChars[14]}');
  }

  static void test256Color(TermareController controller) {
    for (int i = 0; i < 256; i++) {
      controller.write('\x1b[48;5;$i\m$i     \x1b[0m');
    }
  }
}
