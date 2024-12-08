import 'dart:io';

import 'package:collection/collection.dart';

class Coord {
  final int x;
  final int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return other is Coord && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

Future<void> main() async {
  final input = await File('./Day08/day08_input.txt').readAsLines();
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
  int height = input.length;
  int width = input[0].length;

  Map<String, Set<Coord>> antennae = {};

  // Find all antennae
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (input[y][x] != '.') {
        if (antennae.containsKey(input[y][x])) {
          antennae[input[y][x]]!.add(Coord(x, y));
        } else {
          antennae[input[y][x]] = {Coord(x, y)};
        }
      }
    }
  }

  // Find antinodes
  Set<Coord> antinodes = {};
  for (var key in antennae.keys) {
    for (var coord in antennae[key]!) {
      final otherAntennae = antennae[key]!.where((element) => element != coord);
      for (var otherAntenna in otherAntennae) {
        final diff = Coord(otherAntenna.x - coord.x, otherAntenna.y - coord.y);

        if (!isPartTwo) {
          final c1 = Coord(coord.x - diff.x, coord.y - diff.y);
          if (inBounds(c1, width, height)) {
            antinodes.add(c1);
          }

          final c2 = Coord(otherAntenna.x + diff.x, otherAntenna.y + diff.y);
          if (inBounds(c2, width, height)) {
            antinodes.add(c2);
          }
        } else {
          Coord c = Coord(coord.x, coord.y);

          while (inBounds(c, width, height)) {
            antinodes.add(c);
            c = Coord(c.x - diff.x, c.y - diff.y);
          }

          c = Coord(otherAntenna.x, otherAntenna.y);
          while (inBounds(c, width, height)) {
            antinodes.add(c);
            c = Coord(c.x + diff.x, c.y + diff.y);
          }
        }
      }
    }
  }

  // print board
  // for (var row = 0; row < height; row++) {
  //   for (var col = 0; col < width; col++) {
  //     final antennaEntry = antennae.entries.firstWhereOrNull(
  //         (element) => element.value.contains(Coord(col, row)));
  //     if (antennaEntry != null) {
  //       stdout.write(antennaEntry.key);
  //     } else if (antinodes.contains(Coord(col, row))) {
  //       stdout.write('#');
  //     } else {
  //       stdout.write('.');
  //     }
  //   }
  //   stdout.writeln();
  // }

  return antinodes.length;
}

bool inBounds(Coord coord, int width, int height) {
  return coord.x >= 0 && coord.y >= 0 && coord.x < width && coord.y < height;
}
