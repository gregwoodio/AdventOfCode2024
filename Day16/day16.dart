import 'dart:io';

class Coord {
  final int x;
  final int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is Coord) {
      return x == other.x && y == other.y;
    }
    return false;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

enum Direction {
  north,
  east,
  south,
  west,
}

class Space {
  final Coord coord;
  int? cost = 0;
  final bool isEnd;

  // The direction the reindeer was facing when it entered this space.
  Direction? enteredFacing;

  Map<Direction, Space> neighbors = {};

  Space({
    required this.coord,
    this.cost,
    this.enteredFacing,
    this.isEnd = false,
  });
}

Future<void> main() async {
  final input = await File('./Day16/day16_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  final (start, end) = buildMap(input);
  dfs(start);
  return end.cost!;
}

int part2(List<String> input) {
  return 0;
}

/// Builds the map given the input, and returns the starting space.
(Space, Space) buildMap(List<String> input) {
  Map<Coord, Space> spaces = {};
  late final Space start;
  late final Space end;

  for (var row = 0; row < input.length; row++) {
    for (var col = 0; col < input[row].length; col++) {
      final char = input[row][col];
      if (char == 'S' || char == 'E' || char == '.') {
        if (char == 'S') {
          start = Space(
            coord: Coord(col, row),
            cost: 0,
            enteredFacing: Direction.east,
          );
          spaces[start.coord] = start;
        } else if (char == 'E') {
          end = Space(
            coord: Coord(col, row),
            isEnd: true,
          );
          spaces[Coord(col, row)] = end;
        } else if (char == '.') {
          spaces[Coord(col, row)] = Space(
            coord: Coord(col, row),
          );
        }

        // join these spaces with their neighbours to the north and west
        if (spaces.containsKey(Coord(col, row - 1))) {
          spaces[Coord(col, row)]!.neighbors[Direction.north] =
              spaces[Coord(col, row - 1)]!;
          spaces[Coord(col, row - 1)]!.neighbors[Direction.south] =
              spaces[Coord(col, row)]!;
        }
        if (spaces.containsKey(Coord(col - 1, row))) {
          spaces[Coord(col, row)]!.neighbors[Direction.west] =
              spaces[Coord(col - 1, row)]!;
          spaces[Coord(col - 1, row)]!.neighbors[Direction.east] =
              spaces[Coord(col, row)]!;
        }
      }
    }
  }

  return (start, end);
}

/// Depth-first search to find the cheapest path from the start to the end.
void dfs(Space space) {
  for (var neighbor in space.neighbors.entries) {
    final dir = neighbor.key;
    int cost = 1;
    if (dir != space.enteredFacing) {
      cost = 1001;
    }

    if (neighbor.value.cost == null ||
        space.cost! + cost < neighbor.value.cost!) {
      neighbor.value.cost = space.cost! + cost;
      neighbor.value.enteredFacing = dir;
      dfs(neighbor.value);
    }
  }
}
