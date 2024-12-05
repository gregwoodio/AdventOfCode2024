import 'dart:io';

enum Direction {
  up(0, -1),
  upRight(1, -1),
  right(1, 0),
  downRight(1, 1),
  down(0, 1),
  downLeft(-1, 1),
  left(-1, 0),
  upLeft(-1, -1);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);
}

Future<void> main() async {
  final input = await File('Day04\\day04_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  int sum = 0;

  final target = 'XMAS';

  for (var row = 0; row < input.length; row++) {
    for (var col = 0; col < input[row].length; col++) {
      final char = input[row][col];

      if (char == target[0]) {
        // We found an 'X' at this position
        // Check each direction for the next character in 'XMAS'
        for (var dir in Direction.values) {
          var x = col;
          var y = row;
          var i = 1;

          while (true) {
            x += dir.dx;
            y += dir.dy;

            if (x < 0 || x >= input[row].length || y < 0 || y >= input.length) {
              // out of bounds
              break;
            }

            if (input[y][x] != target[i]) {
              // wrong character
              break;
            }

            i++;

            if (i == target.length) {
              // found 'XMAS'
              sum++;
              break;
            }
          }
        }
      }
    }
  }

  return sum;
}

int part2(List<String> input) {
  int sum = 0;

  for (var row = 0; row < input.length; row++) {
    for (var col = 0; col < input[row].length; col++) {
      final char = input[row][col];

      if (char == 'A') {
        var x1 = col + Direction.upLeft.dx;
        var y1 = row + Direction.upLeft.dy;
        var x2 = col + Direction.downRight.dx;
        var y2 = row + Direction.downRight.dx;
        var x3 = col + Direction.upRight.dx;
        var y3 = row + Direction.upRight.dy;
        var x4 = col + Direction.downLeft.dx;
        var y4 = row + Direction.downLeft.dy;

        if (x1 < 0 || x1 >= input[row].length || y1 < 0 || y1 >= input.length) {
          // out of bounds
          continue;
        }

        if (x2 < 0 || x2 >= input[row].length || y2 < 0 || y2 >= input.length) {
          // out of bounds
          continue;
        }

        if (x3 < 0 || x3 >= input[row].length || y3 < 0 || y3 >= input.length) {
          // out of bounds
          continue;
        }

        if (x4 < 0 || x4 >= input[row].length || y4 < 0 || y4 >= input.length) {
          // out of bounds
          continue;
        }

        if ((input[y1][x1] == 'M' && input[y2][x2] == 'S') &&
                (input[y3][x3] == 'M' && input[y4][x4] == 'S') ||
            (input[y1][x1] == 'S' && input[y2][x2] == 'M') &&
                (input[y3][x3] == 'S' && input[y4][x4] == 'M') ||
            (input[y1][x1] == 'M' && input[y2][x2] == 'S') &&
                (input[y3][x3] == 'S' && input[y4][x4] == 'M') ||
            (input[y1][x1] == 'S' && input[y2][x2] == 'M') &&
                (input[y3][x3] == 'M' && input[y4][x4] == 'S')) {
          sum++;
        }
      }
    }
  }

  return sum;
}
