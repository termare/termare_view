
# flutter_terminal

Flutter重写的标准终端模拟器

其实现方法参照termux在Android的实现 

使用Flutter框架重写它的UI部分 

并重写了termux的C语言部分

## 开始使用
在example下有一个多终端的简单例子

## 现有项目集成
### 添加依赖
```
    flutter_terminal:
        git:
          url: git://github.com/Nightmare-MY/flutter_terminal.git
```

### 添加so库

目前我还没能够让此这个包能够直接被项目集成，所以你需要将prebuilt下对应平台的动态库复制到程序能获取到的地方。

[prebuilt]()
> android项目直接将对应设备的libterm.so放按libs文件夹即可

### 导入包
```dart
import 'package:flutter_terminal/flutter_terminal.dart';
```
### 更改so库路径
> 集成到安卓无需更改，只需要添加so库
```
NitermController.libPath=''
```
> 放在当前项目能获取到的地方

### 注意！！！

- 目前这个包还在测试阶段，里面还有大量的print输出，也请不要集成到现有的项目。

## 为何要用Flutter重写而不是安卓原生？

除了个人的一系列想法之外，完全是由于Flutter的跨平台性，

termux与Android-Terminal-Emulater的UI实现是通过java编写

终端的创建与子进程的执行完全由jni完成

它们最终只能运行于安卓设备上

而其实这种创建虚拟终端的思想几乎是能用于任何UNIX平台的设备，也就是还有Macos，Linux

## 为何它的表现并不如原始的安卓模拟器

它截止目前只能识别一些带颜色的输出，原始的安卓模拟器带有一整套终端虚拟机的控制序列，
Flutter当前作为很优秀的跨平台框架，我想也能用它来重写一套新的终端序列，从安卓前几代终端模拟器来看，
这可能是一个比较漫长的过程，而我的时间并不太多，但我会尽量尝试重写。


# 帮助开发？

## Terminal resources

- [XTerm control sequences](http://invisible-island.net/xterm/ctlseqs/ctlseqs.html)
- [vt100.net](http://vt100.net/)
- [Terminal codes (ANSI and terminfo equivalents)](http://wiki.bash-hackers.org/scripting/terminalcodes)

## Terminal emulators

- VTE (libvte): Terminal emulator widget for GTK+, mainly used in gnome-terminal.
  [Source](https://github.com/GNOME/vte), [Open Issues](https://bugzilla.gnome.org/buglist.cgi?quicksearch=product%3A%22vte%22+),
  and [All (including closed) issues](https://bugzilla.gnome.org/buglist.cgi?bug_status=RESOLVED&bug_status=VERIFIED&chfield=resolution&chfieldfrom=-2000d&chfieldvalue=FIXED&product=vte&resolution=FIXED).

- iTerm 2: OS X terminal application. [Source](https://github.com/gnachman/iTerm2),
  [Issues](https://gitlab.com/gnachman/iterm2/issues) and [Documentation](http://www.iterm2.com/documentation.html)
  (which includes [iTerm2 proprietary escape codes](http://www.iterm2.com/documentation-escape-codes.html)).

- Konsole: KDE terminal application. [Source](https://projects.kde.org/projects/kde/applications/konsole/repository),
  in particular [tests](https://projects.kde.org/projects/kde/applications/konsole/repository/revisions/master/show/tests),
  [Bugs](https://bugs.kde.org/buglist.cgi?bug_severity=critical&bug_severity=grave&bug_severity=major&bug_severity=crash&bug_severity=normal&bug_severity=minor&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&product=konsole)
  and [Wishes](https://bugs.kde.org/buglist.cgi?bug_severity=wishlist&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&product=konsole).

- hterm: JavaScript terminal implementation from Chromium. [Source](https://github.com/chromium/hterm),
  including [tests](https://github.com/chromium/hterm/blob/master/js/hterm_vt_tests.js),
  and [Google group](https://groups.google.com/a/chromium.org/forum/#!forum/chromium-hterm).

- xterm: The grandfather of terminal emulators.
  [Source](http://invisible-island.net/datafiles/release/xterm.tar.gz).

- Connectbot: Android SSH client. [Source](https://github.com/connectbot/connectbot)

- Android Terminal Emulator: Android terminal app which Termux terminal handling
  is based on. Inactive. [Source](https://github.com/jackpal/Android-Terminal-Emulator).

- termux: Android terminal and Linux environment - app repository.
 [Source](https://github.com/termux/termux-app).
