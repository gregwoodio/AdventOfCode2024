import 'dart:io';

Future<void> main() async {
  final input = await File('Day03\\day03_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  int sum = 0;

  final regex = RegExp(r'mul\((\d{0,3}),(\d{0,3})\)');
  for (var line in input) {
    final matches = regex.allMatches(line);
    for (var match in matches) {
      final a = int.parse(match.group(1) ?? '');
      final b = int.parse(match.group(2) ?? '');
      sum += a * b;
    }
  }

  return sum;
}

int part2(List<String> input) {
  int sum = 0;
  bool enabled = true;

  final regex = RegExp(r"mul\((\d{0,3}),(\d{0,3})\)|don't\(\)|do\(\)");
  for (var line in input) {
    final matches = regex.allMatches(line);
    for (var match in matches) {
      if (match.group(0) == 'don\'t()') {
        enabled = false;
      } else if (match.group(0) == 'do()') {
        enabled = true;
      } else if (enabled) {
        final a = int.parse(match.group(1) ?? '');
        final b = int.parse(match.group(2) ?? '');
        sum += a * b;
      }
    }
  }

  return sum;
}
