import 'dart:io';

class Pos {
  int x;
  int y;

  Pos(this.x, this.y);
}

class Robot {
  Pos pos;
  Pos vel;
  int height;
  int width;

  Robot({
    required this.pos,
    required this.vel,
    required this.height,
    required this.width,
  });

  void move() {
    pos.x += vel.x;
    if (pos.x < 0) {
      pos.x += width;
    } else if (pos.x >= width) {
      pos.x -= width;
    }

    pos.y += vel.y;
    if (pos.y < 0) {
      pos.y += height;
    } else if (pos.y >= height) {
      pos.y -= height;
    }
  }
}

Future<void> main() async {
  final input = await File('./Day14/day14_input.txt').readAsLines();
  print('Part 1: ${part1(input, 101, 103)}');
  print('Part 2: ${part2(input, 101, 103)}');
}

int part1(List<String> input, int width, int height) {
  final robots = parse(input, width, height);

  for (var i = 0; i < 100; i++) {
    for (var robot in robots) {
      robot.move();
    }
  }

  printBoard(robots, height, width);

  return safetyIndex(robots, height, width);
}

int part2(List<String> input, int width, int height) {
  final robots = parse(input, width, height);

  int ticks = 0;

  while (true) {
    ticks++;

    for (var robot in robots) {
      robot.move();
    }

    writeBoard(robots, height, width, ticks);

    if (ticks > 10000) {
      print('Too many ticks');
      break;
    }

    // Ctrl+F :)
  }

  return ticks;
}

List<Robot> parse(List<String> input, int width, int height) {
  final robots = <Robot>[];
  final regex =
      RegExp(r"p=(?<px>\d+),(?<py>\d+) v=(?<vx>-?\d+),(?<vy>-?(\d+))");
  for (var line in input) {
    final match = regex.firstMatch(line);
    if (match != null) {
      final px = int.parse(match.namedGroup('px')!);
      final py = int.parse(match.namedGroup('py')!);
      final vx = int.parse(match.namedGroup('vx')!);
      final vy = int.parse(match.namedGroup('vy')!);
      robots.add(Robot(
        pos: Pos(px, py),
        vel: Pos(vx, vy),
        height: height,
        width: width,
      ));
    }
  }
  return robots;
}

int safetyIndex(List<Robot> robots, int height, int width) {
  List<int> quadrants = List.filled(4, 0); // NW, NE, SW, SE

  for (var robot in robots) {
    if (robot.pos.x < width ~/ 2) {
      if (robot.pos.y < height ~/ 2) {
        quadrants[0]++;
      } else if (robot.pos.y > height ~/ 2) {
        quadrants[2]++;
      }
    } else if (robot.pos.x > width ~/ 2) {
      if (robot.pos.y < height ~/ 2) {
        quadrants[1]++;
      } else if (robot.pos.y > height ~/ 2) {
        quadrants[3]++;
      }
    } else {}
  }

  return quadrants.reduce((a, b) => a * b);
}

void printBoard(List<Robot> robots, int height, int width) {
  final board = List.generate(height, (_) => List.filled(width, 0));

  for (var robot in robots) {
    board[robot.pos.y][robot.pos.x] += 1;
  }

  for (var row in board) {
    print(row.map((e) => e == 0 ? '.' : '$e').join());
  }
}

void writeBoard(List<Robot> robots, int height, int width, int ticks) {
  final board = List.generate(height, (_) => List.filled(width, 0));

  for (var robot in robots) {
    board[robot.pos.y][robot.pos.x] += 1;
  }

  final file = File('Day14/day14_output.txt');
  file.writeAsStringSync('\n************************************ $ticks\n',
      mode: FileMode.append);

  for (var row in board) {
    file.writeAsStringSync('${row.map((e) => e == 0 ? '.' : '$e').join()}\n',
        mode: FileMode.append);
  }

  file.writeAsStringSync('\n', mode: FileMode.append, flush: true);
}

// bool checkColumnFilled(List<Robot> robots, int column, int height) {
//   List<bool> everyYFilled = List.filled(height, false);

//   for (var robot in robots) {
//     if (robot.pos.x == column) {
//       everyYFilled[robot.pos.y] = true;
//     }
//   }

//   return everyYFilled.every((element) => element);
// }
