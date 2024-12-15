import 'dart:io';

enum Direction {
  up(0, -1, '^'),
  right(1, 0, '>'),
  down(0, 1, 'v'),
  left(-1, 0, '<');

  final int dx;
  final int dy;
  final String value;

  const Direction(this.dx, this.dy, this.value);
}

enum Tile {
  wall('#'),
  empty('.'),
  box('O'),
  leftBox('['),
  rightBox(']'),
  robot('@');

  final String value;

  const Tile(this.value);
}

class Coord {
  int x;
  int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return other is Coord && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return '$x, $y';
  }
}

Future<void> main() async {
  final input = await File('./Day15/day15_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  final (map, robot, directions) = parseInput(input);

  // print('Initial state');
  // printMap(map);

  execute(map, robot, directions);

  return gpsCoords(map);
}

int part2(List<String> input) {
  final (map, robot, directions) = parseInput(input, isPart2: true);

  // print('Initial state');
  // printMap(map);

  execute2(map, robot, directions);
  // printMap(map);

  return gpsCoords(map);
}

(Map<Coord, Tile> map, Coord robot, List<Direction> directions) parseInput(
  List<String> input, {
  bool isPart2 = false,
}) {
  final map = <Coord, Tile>{};
  Coord robot = Coord(-1, -1);

  int y = 0;
  for (; y < input.length; y++) {
    if (input[y].isEmpty) {
      break;
    }

    for (var x = 0; x < input[y].length; x++) {
      final coord = Coord(x * (isPart2 ? 2 : 1), y);
      var tile = Tile.values.firstWhere((tile) => tile.value == input[y][x]);
      if (tile == Tile.robot) {
        robot = coord;
        map[coord] = Tile.robot;
        if (isPart2) {
          map[Coord(coord.x + 1, coord.y)] = Tile.empty;
        }
      } else if (tile == Tile.box && isPart2) {
        map[coord] = Tile.leftBox;
        map[Coord(coord.x + 1, coord.y)] = Tile.rightBox;
      } else {
        map[coord] = tile;
        if (isPart2) {
          map[Coord(coord.x + 1, coord.y)] = tile;
        }
      }
    }
  }

  final directions = input.sublist(y + 1).join().split('').map((direction) {
    return Direction.values.firstWhere((dir) => dir.value == direction);
  }).toList();

  return (map, robot, directions);
}

void execute(Map<Coord, Tile> map, Coord robot, List<Direction> directions) {
  for (var direction in directions) {
    // print('\nMove ${direction.value}');

    final next = Coord(robot.x + direction.dx, robot.y + direction.dy);
    if (map[next] == Tile.wall) {
      // can't move
      // print('can\'t move');
      continue;
    } else if (map[next] == Tile.box) {
      // check if we can push the box into the next empty tile. Boxes can push
      // other boxes
      var nextBox = Coord(next.x + direction.dx, next.y + direction.dy);
      while (true) {
        if (map[nextBox] == Tile.wall) {
          // encountered a wall first. Can't push the box.
          break;
        }
        if (map[nextBox] == Tile.empty) {
          // found an empty tile. Move the box here. This kind of teleports the
          // next pushed box into the empty tile, but the effect is the same as
          // pushing all of the boxes in a row.
          map[nextBox] = Tile.box;
          map[robot] = Tile.empty;
          map[next] = Tile.robot;
          robot = next;
          break;
        }
        nextBox = Coord(nextBox.x + direction.dx, nextBox.y + direction.dy);
      }
    } else if (map[next] == Tile.empty) {
      // move the robot
      map[robot] = Tile.empty;
      robot = next;
      map[robot] = Tile.robot;
    }

    // printMap(map);
  }
}

void execute2(Map<Coord, Tile> map, Coord robot, List<Direction> directions) {
  for (var direction in directions) {
    // print('\nMove ${direction.value}');

    final next = Coord(robot.x + direction.dx, robot.y + direction.dy);
    if (map[next] == Tile.wall) {
      // can't move
      // print('can\'t move');
      continue;
    } else if (map[next] == Tile.leftBox || map[next] == Tile.rightBox) {
      if (direction == Direction.up || direction == Direction.down) {
        if (canPushBoxUpOrDown(map, next, direction)) {
          moveUpOrDown(map, robot, Tile.empty, direction);
          robot = next;
        }
      } else {
        if (canPushBoxLeftOrRight(map, next, direction)) {
          // print('moving ${direction.value}');
          moveLeftOrRight(map, robot, direction);
          robot = next;
        }
      }
    } else if (map[next] == Tile.empty) {
      // move the robot
      map[robot] = Tile.empty;
      robot = next;
      map[robot] = Tile.robot;
    }

    // printMap(map);
  }
}

// Recursive function to push the box up or down. If the box
// can't be pushed, return false. If the box is pushed into another box, check
// if that box can be pushed. If all boxes are pushed, return true.
// When the box is pushed into another box, check that both sides of that box
// can be pushed. If both sides can be pushed, return true.
bool canPushBoxUpOrDown(Map<Coord, Tile> map, Coord next, Direction direction) {
  if (map[next] == Tile.wall) {
    return false;
  } else if (map[next] == Tile.leftBox) {
    final nextInDirection = Coord(next.x + direction.dx, next.y + direction.dy);
    final nextRightInDirection =
        Coord(next.x + direction.dx + 1, next.y + direction.dy);
    return canPushBoxUpOrDown(map, nextInDirection, direction) &&
        canPushBoxUpOrDown(map, nextRightInDirection, direction);
  } else if (map[next] == Tile.rightBox) {
    final nextInDirection = Coord(next.x + direction.dx, next.y + direction.dy);
    final nextLeftInDirection =
        Coord(next.x + direction.dx - 1, next.y + direction.dy);
    return canPushBoxUpOrDown(map, nextInDirection, direction) &&
        canPushBoxUpOrDown(map, nextLeftInDirection, direction);
  } else if (map[next] == Tile.empty) {
    return true;
  }

  return false;
}

bool canPushBoxLeftOrRight(
    Map<Coord, Tile> map, Coord box, Direction direction) {
  final next = Coord(box.x + direction.dx, box.y + direction.dy);
  if (map[next] == Tile.wall) {
    return false;
  } else if (map[next] == Tile.leftBox) {
    return canPushBoxLeftOrRight(map, next, direction);
  } else if (map[next] == Tile.rightBox) {
    return canPushBoxLeftOrRight(map, next, direction);
  } else if (map[next] == Tile.empty) {
    return true;
  }

  return false;
}

void moveLeftOrRight(Map<Coord, Tile> map, Coord robot, Direction direction) {
  var next = robot;
  Tile prevTile = Tile.empty;
  var currentTile = map[next]!;

  while (currentTile != Tile.empty) {
    map[next] = prevTile;
    prevTile = currentTile;
    next = Coord(next.x + direction.dx, next.y + direction.dy);
    currentTile = map[next]!;
  }

  map[next] = prevTile;
}

void moveUpOrDown(
    Map<Coord, Tile> map, Coord coord, Tile prevTile, Direction direction) {
  // Move previous tile to current tile, save a reference to the current tile
  var next = coord;
  var currentTile = map[next]!;
  map[next] = prevTile;
  prevTile = currentTile;

// Find the next tile to move
  next = Coord(next.x + direction.dx, next.y + direction.dy);
  final _maxX = maxX(map);
  final _maxY = maxY(map);
  if (next.x < 0 || next.y < 0 || next.x > _maxX || next.y > _maxY) {
    // print('out of bounds: $next\n Direction: $direction');

    // printMap(map);
    return;
  }

  currentTile = map[next]!;

  if (currentTile == Tile.leftBox) {
    final rightSide = Coord(next.x + 1, next.y);
    moveUpOrDown(map, rightSide, Tile.empty, direction);
    moveUpOrDown(map, next, prevTile, direction);
  } else if (currentTile == Tile.rightBox) {
    final leftSide = Coord(next.x - 1, next.y);
    moveUpOrDown(map, leftSide, Tile.empty, direction);
    moveUpOrDown(map, next, prevTile, direction);
  } else {
    map[next] = prevTile;
  }
}

int gpsCoords(Map<Coord, Tile> map) {
  int sum = 0;

  for (var tile in map.entries) {
    if (tile.value == Tile.box || tile.value == Tile.leftBox) {
      sum += tile.key.x + tile.key.y * 100;
    }
  }

  return sum;
}

void printMap(Map<Coord, Tile> map) {
  final _maxX = maxX(map);
  final _maxY = maxY(map);

  for (var y = 0; y <= _maxY; y++) {
    stdout.write('$y\t');
    for (var x = 0; x <= _maxX; x++) {
      final coord = Coord(x, y);
      final tile = map[coord];
      if (tile == null) {
        stdout.write(' ');
      } else {
        stdout.write(tile.value);
      }
    }
    stdout.writeln();
  }
}

int maxX(Map<Coord, Tile> map) {
  return map.keys.map((coord) => coord.x).reduce((a, b) => a > b ? a : b);
}

int maxY(Map<Coord, Tile> map) {
  return map.keys.map((coord) => coord.y).reduce((a, b) => a > b ? a : b);
}
