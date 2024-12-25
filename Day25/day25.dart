import 'dart:io';

Future<void> main() async {
  final input = await File('./Day25/day25_input.txt').readAsLines();
  print(part1(input));
  print(part2(input));
}

int part1(List<String> input) {
  final Set<List<int>> keys = {};
  final Set<List<int>> locks = {};

  int start = 0;
  for (var end = 0; start < input.length; end++) {
    if (end < input.length && input[end].isNotEmpty) {
      continue;
    }

    if (input[start] == '#####') {
      // locks
      List<int> pins = [];
      for (var i = 0; i < 5; i++) {
        int count = 0;
        for (var j = start + 1; j < end; j++) {
          if (input[j][i] == '#') {
            count++;
          } else {
            break;
          }
        }
        pins.add(count);
      }
      locks.add(pins);
    } else if (input[start] == '.....') {
      // keys
      List<int> pins = [];
      for (var i = 0; i < 5; i++) {
        int count = 0;
        for (var j = end - 2; j > start; j--) {
          if (input[j][i] == '#') {
            count++;
          } else {
            break;
          }
        }
        pins.add(count);
      }
      keys.add(pins);
    }

    start = end + 1;
  }

  int sum = 0;

  // for (var key in keys) {
  //   final pins = key.split(',').map((e) => int.parse(e)).toList();
  //   // invert pins to find a matching lock
  //   final invertedPins = pins.map((e) => 5 - e).toList();
  //   if (locks.contains(invertedPins.join(','))) {
  //     sum += 1;
  //   }
  // }
  for (var key in keys) {
    for (var lock in locks) {
      bool fits = true;
      for (var i = 0; i < 5; i++) {
        if (key[i] + lock[i] > 5) {
          fits = false;
          break;
        }
      }

      if (fits) {
        sum += 1;
      }
    }
  }

  return sum;
}

int part2(List<String> input) {
  return 0;
}
