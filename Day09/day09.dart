import 'dart:io';

Future<void> main() async {
  final input = await File('./Day09/day09_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  return checksum(fragment(expand(input[0])));
}

int part2(List<String> input) {
  return 0;
}

List<int?> expand(String input) {
  List<int?> output = [];
  int id = 0;
  bool isFile = true;

  for (var i = 0; i < input.length; i++) {
    var value = int.parse(input[i]);
    for (var j = 0; j < value; j++) {
      if (isFile) {
        output.add(id);
      } else {
        output.add(null);
      }
    }

    isFile = !isFile;
    if (isFile) {
      id++;
    }
  }

  return output;
}

List<int?> fragment(List<int?> input) {
  /// last non-null spot
  int last = input.length - 1;

  /// first null spot
  int first = 0;

  void findLastAndFirst() {
    for (; last >= 0; last--) {
      if (input[last] != null) {
        break;
      }
    }

    for (; first < input.length; first++) {
      if (input[first] == null) {
        break;
      }
    }
  }

  findLastAndFirst();

  while (first < last) {
    input[first] = input[last];
    input[last] = null;

    findLastAndFirst();
  }

  return input;
}

int checksum(List<int?> input) {
  int sum = 0;
  for (var i = 0; i < input.length; i++) {
    if (input[i] != null) {
      sum += input[i]! * i;
    }
  }

  return sum;
}
