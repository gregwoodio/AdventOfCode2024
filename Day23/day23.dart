import 'dart:io';

import 'package:collection/collection.dart';

Future<void> main() async {
  final input = await File('./Day23/day23_input.txt').readAsLines();
  print(part1(input));
  print(part2(input));
}

int part1(List<String> input) {
  Map<String, Set<String>> groups = {};

  for (var line in input) {
    var parts = line.split('-');
    var a = parts[0];
    var b = parts[1];

    if (!groups.containsKey(a)) {
      groups[a] = {};
    }
    groups[a]!.add(b);

    if (!groups.containsKey(b)) {
      groups[b] = {};
    }
    groups[b]!.add(a);
  }

  Set<Set<String>> groupsOfThree = {};
  for (var key in groups.keys) {
    var group = groups[key]!;
    for (var node in group) {
      if (groups.containsKey(node)) {
        var group2 = groups[node]!;
        for (var node2 in group2) {
          if (group.contains(node2)) {
            final groupOfThree = {key, node, node2};
            if (!groupsOfThree
                .any((g) => SetEquality().equals(g, groupOfThree))) {
              groupsOfThree.add({key, node, node2});
            }
          }
        }
      }
    }
  }

  // Count all groups that contain a node starting with the letter t
  int sum = 0;
  for (var group in groupsOfThree) {
    if (group.any((element) => element.startsWith('t'))) {
      sum++;
    }
  }

  return sum;
}

int part2(List<String> input) {
  return 0;
}
