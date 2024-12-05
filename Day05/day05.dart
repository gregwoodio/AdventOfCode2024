import 'dart:io';

Future<void> main() async {
  final input = await File('./Day05/day05_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  final Map<int, List<int>> followingPages = {};

  late int line;
  for (line = 0; input[line] != ''; line++) {
    final parts = input[line].split('|');
    final page = int.parse(parts[0]);
    final followingPage = int.parse(parts[1]);
    if (followingPages.containsKey(page)) {
      followingPages[page]!.add(followingPage);
    } else {
      followingPages[page] = [followingPage];
    }
  }

  int sum = 0;
  line++;

  for (; line < input.length; line++) {
    final pages = input[line].split(',').map(int.parse).toList();
    bool valid = true;
    for (var i = 0; i < pages.length; i++) {
      final page = pages[i];
      if (followingPages.containsKey(page)) {
        if (!followingPages[page]!.every((followingPage) =>
            pages.indexOf(followingPage) > i ||
            pages.indexOf(followingPage) == -1)) {
          valid = false;
          break;
        }
      }
    }

    if (valid) {
      sum += pages[pages.length ~/ 2];
    }
  }

  return sum;
}

int part2(List<String> input) {
  return 0;
}
