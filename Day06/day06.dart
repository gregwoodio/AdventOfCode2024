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
  Set<PositionWithFacing> visited = {};
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

  visited.add(PositionWithFacing(guardPos, facing));

  Set<Position> possibleObstacles = {};

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

    visited.add(PositionWithFacing(guardPos, facing));
    final guardsRight =
        Direction.values[(facing.index + 1) % Direction.values.length];

    if (visited.contains(PositionWithFacing(guardPos, guardsRight))) {
      // We can create a loop for the guard by checking if the guard has visited
      // this position, but facing to their right. If so, we can add a possible
      // obstacle in front of the guard, forcing them to turn right and end up
      // on an old path.
      possibleObstacles
          .add(Position(guardPos.x + facing.dx, guardPos.y + facing.dy));
    } else {
      // scan down to the right of the guard. If we find a visited position
      // in the same facing before an obstacle, add the space in front of the
      // guard as a possible obstacle
      var i = 1;
      while (true) {
        var nextPos = Position(
            guardPos.x + guardsRight.dx * i, guardPos.y + guardsRight.dy * i);
        if (nextPos.x < 0 ||
            nextPos.x >= width ||
            nextPos.y < 0 ||
            nextPos.y >= height) {
          break;
        }

        if (obstacles.contains(nextPos)) {
          break;
        }

        if (visited.contains(PositionWithFacing(nextPos, guardsRight))) {
          possibleObstacles
              .add(Position(guardPos.x + facing.dx, guardPos.y + facing.dy));
          break;
        }

        i++;
      }
    }
  }

  for (var obs in possibleObstacles) {
    print('Possible obstacle: ${obs.x}, ${obs.y}');
  }

  return possibleObstacles.length;
}
