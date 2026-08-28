import 'dart:io';

void main() {
  final dir = Directory('lib/models');
  final regex = RegExp(r'id: -?\d*(\d{15}),');
  for (var file in dir.listSync()) {
    if (file is File && file.path.endsWith('.g.dart')) {
      var content = file.readAsStringSync();
      var newContent = content.replaceAllMapped(regex, (match) {
        return 'id: ${match.group(1)},';
      });
      file.writeAsStringSync(newContent);
      print('Fixed ${file.path}');
    }
  }
}
