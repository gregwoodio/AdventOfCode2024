import 'dart:io';
import 'dart:math';

Future<void> main() async {
  final input = await File('./Day07/day07_input.txt').readAsLines();
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
    List<String> parts = line.split(':');
    int target = int.parse(parts[0]);

    List<int> operands = parts[1].trim().split(' ').map(int.parse).toList();

    final possibleOps = possibleOperators(operands.length - 1, isPartTwo);

    for (var operators in possibleOps) {
      int result = operands[0];
      for (var i = 1; i < operands.length; i++) {
        if (operators[i - 1] == '+') {
          result += operands[i];
        } else if (operators[i - 1] == '*') {
          result *= operands[i];
        } else if (operators[i - 1] == '||') {
          result = (result * pow(10, operands[i].toString().length)).toInt() +
              operands[i];
        }

        if (result > target) {
          break;
        }
      }

      if (result == target) {
        sum += target;
        break;
      }
    }
  }

  return sum;
}

/// Returns a list of all possible operators ('+' or '*') of length [length].
/// For example, possibleOperators(2) returns [['+', '+'], ['+', '*'], ['*', '+'], ['*', '*']].
/// If [isPartTwo] is true, it also includes the '||' operator. So possibleOperators(2) would return [['+', '+'], ['+', '*'], ['+', '||'], ['*', '+'], ['*', '*'], ['*', '||'], ['||', '+'], ['||', '*'], ['||', '||']].
List<List<String>> possibleOperators(int length, [bool isPartTwo = false]) {
  if (length == 1) {
    return [
      ['+'],
      ['*'],
      if (isPartTwo) ['||'],
    ];
  }

  List<List<String>> result = [];
  for (var operator in ['+', '*', if (isPartTwo) '||']) {
    for (var subOperators in possibleOperators(length - 1, isPartTwo)) {
      result.add([operator, ...subOperators]);
    }
  }

  return result;
}
