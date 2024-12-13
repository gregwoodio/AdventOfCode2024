import 'dart:io';
import 'dart:math';

class ClawGame {
  final int aButtonDX;
  final int aButtonDY;
  final int bButtonDX;
  final int bButtonDY;
  final int prizeX;
  final int prizeY;

  ClawGame({
    required this.aButtonDX,
    required this.aButtonDY,
    required this.bButtonDX,
    required this.bButtonDY,
    required this.prizeX,
    required this.prizeY,
  });

  // Find the lowest cost to get the prize. Pushing a button costs 3, pushing b
  // costs 1. The claw moves aButtonDX and aButtonDY on button A, and bButtonDX
  // and bButtonDY on button B. The prize is found at prizeX and prizeY. If it
  // is not possible to get the prize, return -1.
  int solve() {
    int lowestCost = 2147483647;
    final int aCost = 3;
    final int bCost = 1;

    int x = 0;
    int y = 0;

    /// Find the maximum number of pushes for each button that can be made to go
    /// past the prize. Max 100.
    int maxAPushes = min(max(prizeX ~/ aButtonDX, prizeY ~/ aButtonDY), 100);
    int maxBPushes = min(max(prizeX ~/ bButtonDX, prizeY ~/ bButtonDY), 100);

    for (var aPushes = maxAPushes; aPushes >= 0; aPushes--) {
      for (var bPushes = 0; bPushes <= maxBPushes; bPushes++) {
        x = aButtonDX * aPushes + bButtonDX * bPushes;
        y = aButtonDY * aPushes + bButtonDY * bPushes;

        if (x == prizeX && y == prizeY) {
          lowestCost = min(lowestCost, aPushes * aCost + bPushes * bCost);
        }
      }
    }

    return lowestCost == 2147483647 ? -1 : lowestCost;
  }
}

Future<void> main() async {
  final input = await File('./Day13/day13_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  int sum = 0;
  for (var i = 0; i < input.length; i += 4) {
    final clawGame = parse(input.sublist(i, i + 3));
    final solution = clawGame.solve();
    if (solution != -1) {
      sum += solution;
    }
  }
  return sum;
}

int part2(List<String> input) {
  return 0;
}

ClawGame parse(List<String> input) {
  final buttonRegex =
      RegExp(r'Button (?<button>A|B): X\+(?<dx>\d+), Y\+(?<dy>\d+)');
  final prizeRegex = RegExp(r'Prize: X=(?<prizeX>\d+), Y=(?<prizeY>\d+)');

  int aButtonDX = 0;
  int aButtonDY = 0;
  int bButtonDX = 0;
  int bButtonDY = 0;
  int prizeX = 0;
  int prizeY = 0;

  final aButtonMatch = buttonRegex.firstMatch(input[0]);
  if (aButtonMatch != null) {
    aButtonDX = int.parse(aButtonMatch.namedGroup('dx')!);
    aButtonDY = int.parse(aButtonMatch.namedGroup('dy')!);
  }

  final bButtonMatch = buttonRegex.firstMatch(input[1]);
  if (bButtonMatch != null) {
    bButtonDX = int.parse(bButtonMatch.namedGroup('dx')!);
    bButtonDY = int.parse(bButtonMatch.namedGroup('dy')!);
  }

  final prizeMatch = prizeRegex.firstMatch(input[2]);
  if (prizeMatch != null) {
    prizeX = int.parse(prizeMatch.namedGroup('prizeX')!);
    prizeY = int.parse(prizeMatch.namedGroup('prizeY')!);
  }

  return ClawGame(
    aButtonDX: aButtonDX,
    aButtonDY: aButtonDY,
    bButtonDX: bButtonDX,
    bButtonDY: bButtonDY,
    prizeX: prizeX,
    prizeY: prizeY,
  );
}
