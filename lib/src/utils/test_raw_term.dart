import 'dart:io';

void main() {
  // print('Application Program Command\x9fApplication Program Command');
  for (int i = 0; i < 256; i++) {
    stdout.write('\x1b[48;5;$i\m$i     \x1b[0m');
  }
  // print('123\x1b[2G ');
}
