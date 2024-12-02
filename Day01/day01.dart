import 'dart:io';

Future<void> main() async {
  final input = await File('Day01/day01_input.txt').readAsLines();

  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  final List<int> left = [];
  final List<int> right = [];

  for (var line in input) {
    /// Regex for getting the two numbers from the input
    final matches = RegExp(r'\d+').allMatches(line);
    final parts =
        matches.map((match) => match.group(0)).cast<String>().toList();

    left.add(int.parse(parts[0]));
    right.add(int.parse(parts[1]));
  }

  left.sort();
  right.sort();

  int sum = 0;
  for (var i = 0; i < left.length; i++) {
    sum += (left[i] - right[i]).abs();
  }

  return sum;
}

int part2(List<String> input) {
  final List<int> left = [];
  final Map<int, int> right = {};

  for (var line in input) {
    final matches = RegExp(r'\d+').allMatches(line);
    final parts =
        matches.map((match) => match.group(0)).cast<String>().toList();

    left.add(int.parse(parts[0]));
    final rightNum = int.parse(parts[1]);
    if (right.containsKey(rightNum)) {
      right[rightNum] = right[rightNum]! + 1;
    } else {
      right[rightNum] = 1;
    }
  }

  left.sort();

  int sum = 0;
  for (var i = 0; i < left.length; i++) {
    sum += left[i] * (right[left[i]] ?? 0);
  }

  return sum;
}
