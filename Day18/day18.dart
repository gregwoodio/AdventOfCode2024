import 'dart:io';

class Coord {
  int x;
  int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Coord &&
      runtimeType == other.runtimeType &&
      x == other.x &&
      y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

enum Direction {
  up(0, -1),
  right(1, 0),
  down(0, 1),
  left(-1, 0);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);
}

class Node {
  final Coord coord;
  int distance;
  bool isCorrupt;

  Node(this.coord, this.distance) : isCorrupt = false;
}

Future<void> main() async {
  final input = await File('./Day18/day18_input.txt').readAsLines();
  print(part1(input, 1024, 71));
  print(part2(input));
}

int part1(List<String> input, int steps, int size) {
  List<List<Node>> board = List.generate(
    size,
    (y) => List.generate(
      size,
      (x) => Node(Coord(x, y), 99999),
    ),
  );

  for (var i = 0; i < steps; i++) {
    var parts = input[i].split(',').map(int.parse).toList();
    board[parts[1]][parts[0]].isCorrupt = true;
  }

  // printBoard(board);

  board[0][0].distance = 0;

  dfs(board, board[0][0]);

  return board[size - 1][size - 1].distance;
}

int part2(List<String> input) {
  return 0;
}

void dfs(List<List<Node>> board, Node current) {
  for (var direction in Direction.values) {
    var x = current.coord.x + direction.dx;
    var y = current.coord.y + direction.dy;

    if (x < 0 || x >= board[0].length || y < 0 || y >= board.length) {
      continue;
    }

    var next = board[y][x];
    if (next.isCorrupt) {
      continue;
    }

    var distance = current.distance + 1;
    if (distance < next.distance) {
      next.distance = distance;
      dfs(board, next);
    }
  }
}

void printBoard(List<List<Node>> nodes) {
  for (var row in nodes) {
    for (var node in row) {
      if (node.isCorrupt) {
        stdout.write('#');
      } else {
        stdout.write('.');
      }
    }
    stdout.writeln();
  }
}
