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
  return 0;
}

(Map<Coord, Tile> map, Coord robot, List<Direction> directions) parseInput(
    List<String> input) {
  final map = <Coord, Tile>{};
  Coord robot = Coord(-1, -1);

  int y = 0;
  for (; y < input.length; y++) {
    if (input[y].isEmpty) {
      break;
    }

    for (var x = 0; x < input[y].length; x++) {
      final coord = Coord(x, y);
      final tile = Tile.values.firstWhere((tile) => tile.value == input[y][x]);
      if (tile == Tile.robot) {
        robot = coord;
      }
      map[coord] = tile;
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

int gpsCoords(Map<Coord, Tile> map) {
  int sum = 0;

  for (var tile in map.entries) {
    if (tile.value == Tile.box) {
      sum += tile.key.x + tile.key.y * 100;
    }
  }

  return sum;
}

void printMap(Map<Coord, Tile> map) {
  final maxX = map.keys.map((coord) => coord.x).reduce((a, b) => a > b ? a : b);
  final maxY = map.keys.map((coord) => coord.y).reduce((a, b) => a > b ? a : b);

  for (var y = 0; y <= maxY; y++) {
    for (var x = 0; x <= maxX; x++) {
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
