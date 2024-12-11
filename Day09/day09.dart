import 'dart:io';

class Block {
  int? id;
  int length;
  bool isFile;

  Block({
    this.id,
    required this.length,
    required this.isFile,
  });
}

Future<void> main() async {
  final input = await File('./Day09/day09_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  return checksum(fragment(expand(input[0])));
}

int part2(List<String> input) {
  return checksum2(defragment(expand2(input[0])));
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

List<Block> expand2(String input) {
  List<Block> output = [];
  int id = 0;
  bool isFile = true;

  for (var i = 0; i < input.length; i++) {
    var value = int.parse(input[i]);

    if (value > 0) {
      output.add(Block(
        id: isFile ? id : null,
        length: value,
        isFile: isFile,
      ));
    }

    if (isFile) {
      id++;
    }
    isFile = !isFile;
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

List<Block> defragment(List<Block> input) {
  /// last non-null block
  int last = input.length - 1;

  /// first null spot
  int first = 0;

  void findLast() {
    for (; last >= 0; last--) {
      if (input[last].id != null) {
        break;
      }
    }
  }

  void findFirst() {
    for (; first < input.length; first++) {
      if (!input[first].isFile) {
        break;
      }
    }
  }

  findLast();
  findFirst();

  while (last > 0) {
    if (input[last].length <= input[first].length) {
      // remove block from the end
      var block = input.removeAt(last);

      // insert block in the empty spot
      input.insert(first, block);
      if (input[first + 1].length > input[last].length) {
        // split block
        input[first + 1].length -= input[last].length;
      } else {
        // remove block
        input.removeAt(first + 1);
        last--;
      }

      findLast();
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

int checksum2(List<Block> input) {
  int sum = 0;
  for (var i = 0; i < input.length; i++) {
    if (input[i].id != null) {
      sum += input[i].id! * i;
    }
  }

  return sum;
}
