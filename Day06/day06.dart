import 'dart:io';

enum Direction {
  up(0, -1),
  right(1, 0),
  down(0, 1),
  left(-1, 0);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);
}

class Position {
  int x;
  int y;

  Position(this.x, this.y);

  @override
  bool operator ==(other) => other is Position && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class PositionWithFacing {
  Position position;
  Direction facing;

  PositionWithFacing(this.position, this.facing);

  @override
  bool operator ==(other) =>
      other is PositionWithFacing &&
      position == other.position &&
      facing == other.facing;

  @override
  int get hashCode => position.hashCode ^ facing.hashCode;
}

Future<void> main() async {
  final input = await File('./Day06/day06_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  Set<Position> visited = {};
  Direction facing = Direction.up;

  int height = input.length;
  int width = input[0].length;

  late Position guardPos;
  Set<Position> obstacles = {};

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (input[y][x] == '^') {
        guardPos = Position(x, y);
      } else if (input[y][x] == '#') {
        obstacles.add(Position(x, y));
      }
    }
  }

  visited.add(guardPos);

  while (true) {
    Position nextPos = Position(guardPos.x + facing.dx, guardPos.y + facing.dy);

    if (obstacles.contains(nextPos)) {
      facing = Direction.values[(facing.index + 1) % Direction.values.length];
    } else {
      guardPos = nextPos;
    }

    if (guardPos.x < 0 ||
        guardPos.x >= width ||
        guardPos.y < 0 ||
        guardPos.y >= height) {
      break;
    }

    visited.add(guardPos);
  }

  return visited.length;
}

// got 455, too low.
int part2(List<String> input) {
  Direction facing = Direction.up;

  int height = input.length;
  int width = input[0].length;

  late Position guardPos;
  Set<Position> obstacles = {};

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (input[y][x] == '^') {
        guardPos = Position(x, y);
      } else if (input[y][x] == '#') {
        obstacles.add(Position(x, y));
      }
    }
  }

  final initialGuardPos = guardPos;
  Set<Position> possibleObstacles = {};

// brute force check every possible position for a loop
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final newObstacle = Position(x, y);
      if (obstacles.contains(newObstacle)) {
        continue;
      }
      if (initialGuardPos == newObstacle) {
        continue;
      }

      Set<PositionWithFacing> visited = {};
      visited.add(PositionWithFacing(guardPos, facing));
      final iterationObstacles = {...obstacles, newObstacle};

      while (true) {
        Position nextPos =
            Position(guardPos.x + facing.dx, guardPos.y + facing.dy);

        if (iterationObstacles.contains(nextPos)) {
          facing =
              Direction.values[(facing.index + 1) % Direction.values.length];
        } else {
          guardPos = nextPos;
        }

        if (guardPos.x < 0 ||
            guardPos.x >= width ||
            guardPos.y < 0 ||
            guardPos.y >= height) {
          // out of bounds
          break;
        }

        if (visited.contains(PositionWithFacing(guardPos, facing))) {
          possibleObstacles.add(newObstacle);
          break;
        }

        visited.add(PositionWithFacing(guardPos, facing));
      }

      // reset
      guardPos = initialGuardPos;
      facing = Direction.up;
    }
  }

  return possibleObstacles.length;
}
