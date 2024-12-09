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
  return checksum(defragment(expand(input[0])));
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

List<int?> defragment(List<int?> input) {
  /// last non-null spot, and the first spot ahead of it with a matching id
  int last2 = input.length - 1;
  int last1 = last2 - 1;

  /// first null spot, and last spot behind it that is the end of a contiguous
  /// stretch of null values.
  int first1 = 0;
  int first2 = 1;

  void findLast() {
    for (; last2 >= 0; last2--) {
      if (input[last2] != null) {
        break;
      }
    }

    for (last1 = last2; last1 >= 0 && input[last1] == input[last2]; last1--) {}
  }

  void findFirst() {
    for (; first1 < input.length; first1++) {
      if (input[first1] == null) {
        break;
      }
    }

    for (first2 = first1;
        first2 < input.length && input[first2] == null;
        first2++) {}
  }

  findLast();
  findFirst();

  while (last1 > 0) {
    int fileLength = last2 - last1 + 1;
    int spaceLength = first2 - first1;

    if (fileLength <= spaceLength) {
      for (var i = 0; i < fileLength; i++) {
        input[first1 + i] = input[last1 + i];
        input[last1 + i] = null;
      }

      findLast();
      first1 = 0;
      first2 = 1;
      findFirst();
    } else {
      findFirst();
    }
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
