import 'dart:io';
import 'dart:ui';
import 'package:dart_pty/dart_pty.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:termare/src/termare_view.dart';
import 'painter/termare_painter.dart';
import 'termare_controller.dart';
import 'theme/term_theme.dart';
import 'utils/keyboard_handler.dart';

class TermarePty extends StatefulWidget {
  const TermarePty({
    Key key,
    this.controller,
    this.autoFocus = false,
  }) : super(key: key);
  final TermareController controller;
  final bool autoFocus;
  @override
  _TermarePtyState createState() => _TermarePtyState();
}

class _TermarePtyState extends State<TermarePty> with TickerProviderStateMixin {
  TermareController controller;
  double curOffset = 0;
  double lastLetterOffset = 0;
  int textSelectionOffset = 0;
  UnixPtyC unixPtyC;

  @override
  void initState() {
    super.initState();

    final Size size = window.physicalSize;
    print(size);
    print(window.devicePixelRatio);
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    // 行数
    final int row = screenHeight ~/ TermareStyles.termux.letterHeight;
    // 列数
    final int column = screenWidth ~/ TermareStyles.termux.letterWidth;
    print('< row : $row column : $column>');
    controller = widget.controller ??
        TermareController(
          environment: {
            'TERM': 'screen-256color',
            'PATH': '/data/data/com.nightmare/files/usr/bin:' +
                Platform.environment['PATH'],
          },
          rowLength: row - 2,
          columnLength: column - 2,
        );
    unixPtyC = UnixPtyC(environment: controller.environment);
    init();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback(_onAfterRendering);
    super.didChangeDependencies();
  }

  void _onAfterRendering(Duration timeStamp) {
    print('$this 刷新 ${MediaQuery.of(context).viewInsets}');
  }

  Future<void> init() async {
    if (widget.autoFocus) {
      SystemChannels.textInput.invokeMethod<void>('TextInput.show');
    }
    while (mounted) {
      final String cur = unixPtyC.read();
      // print(('cur->$cur'));
      if (cur.isNotEmpty) {
        controller.currentRead = cur;
        if (cur.contains('Audio')) {
          // print('等回去');
          print(cur);
        }
        controller.write(cur);
        controller.autoScroll = true;
        controller.notifyListeners();
        await Future<void>.delayed(const Duration(milliseconds: 10));
      } else {
        await Future<void>.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        final String text = (await Clipboard.getData('text/plain')).text;
        unixPtyC.write(text);
      },
      child: TermareView(
        keyboardInput: (String data) {
          unixPtyC.write(data);
        },
        controller: controller,
      ),
    );
  }
}