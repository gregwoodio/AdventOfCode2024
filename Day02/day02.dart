import 'dart:io';

Future<void> main() async {
  final input = await File('Day02\\day02_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  return solve(input);
}

int part2(List<String> input) {
  return solve(input, isPartTwo: true);
}

int solve(
  List<String> input, {
  bool isPartTwo = false,
}) {
  int sum = 0;

  for (var line in input) {
    final levels = line.split(' ').map(int.parse).toList();
    bool valid = isReportSafe(levels);
    if (valid) {
      sum++;
    } else if (isPartTwo) {
      final dampenedReports = List.generate(levels.length, (index) {
        final newLevels = [...levels];
        newLevels.removeAt(index);
        return newLevels;
      });

      for (var dampenedReport in dampenedReports) {
        if (isReportSafe(dampenedReport)) {
          sum++;
          break;
        }
      }
    }
  }

  return sum;
}

bool isReportSafe(List<int> levels) {
  final initialIsIncreasing = levels[0] < levels[1];

  for (var i = 0; i < levels.length - 1; i++) {
    final diff = (levels[i] - levels[i + 1]).abs();

    if (initialIsIncreasing != levels[i] < levels[i + 1] ||
        diff < 1 ||
        diff > 3) {
      return false;
    }
  }

  return true;
}
