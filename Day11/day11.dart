import 'dart:io';

Future<void> main() async {
  final input = await File('./Day11/day11_input.txt').readAsLines();
  final line = input[0].split(' ').map(int.parse).toList();
  print('Part 1: ${part1(line)}');
  print('Part 2: ${part2(line)}');
}

int part1(List<int> line) {
  return solve(line);
}

int part2(List<int> line) {
  // return solve(line, 75);
  return 0;
}

int solve(List<int> line, [int iterations = 25]) {
  for (var i = 0; i < iterations; i++) {
    line = blink(line);
  }

  return line.length;
}

List<int> blink(List<int> line) {
  List<int> newLine = [];

  for (var i = 0; i < line.length; i++) {
    if (line[i] == 0) {
      newLine.add(1);
    } else if (hasEvenDigits(line[i])) {
      var numAsString = line[i].toString();
      var part1 = int.parse(numAsString.substring(0, numAsString.length ~/ 2));
      var part2 = int.parse(numAsString.substring(numAsString.length ~/ 2));
      newLine.add(part1);
      newLine.add(part2);
    } else {
      newLine.add(line[i] * 2024);
    }
  }

  return newLine;
}

/// Returns true if the number has an even number of digits.
bool hasEvenDigits(int number) {
  return number.toString().length % 2 == 0;
}
