import 'dart:io';

enum Direction {
  up(0, -1),
  right(1, 0),
  down(0, 1),
  left(-1, 0);

  final int dx;
  final int dy;

  const Direction(this.dx, this.dy);

  Direction opposite() {
    return Direction
        .values[(Direction.values.indexOf(this) + 2) % Direction.values.length];
  }
}

class GardenPlot {
  final String value;
  final int x;
  final int y;
  bool areaVisited;
  bool perimeterVisited;
  late List<bool> fences;

  GardenPlot({
    required this.value,
    required this.x,
    required this.y,
    this.areaVisited = false,
    this.perimeterVisited = false,
  }) {
    this.fences = List.generate(4, (_) => true);
  }
}

Future<void> main() async {
  final input = await File('./Day12/day12_input.txt').readAsLines();
  print('Part 1: ${part1(input)}');
  print('Part 2: ${part2(input)}');
}

int part1(List<String> input) {
  var garden = parse(input);

  var sum = 0;
  for (var y = 0; y < garden.length; y++) {
    for (var x = 0; x < garden[y].length; x++) {
      if (!garden[y][x].areaVisited) {
        var area = areaFlood(garden, x, y);
        var perimeter = perimeterFlood(garden, x, y);
        sum += area * perimeter;
      }
    }
  }

  return sum;
}

int part2(List<String> input) {
  return 0;
}

List<List<GardenPlot>> parse(List<String> input) {
  List<List<GardenPlot>> garden = [];

  for (var y = 0; y < input.length; y++) {
    List<GardenPlot> row = [];
    for (var x = 0; x < input[y].length; x++) {
      row.add(GardenPlot(value: input[y][x], x: x, y: y));
    }
    garden.add(row);
  }

  return garden;
}

/// Flood to the next garden plot to find the area of the garden region.
/// This has the side effect of marking the garden plot as visited and removing
/// fences from the current and next plot when the flood occurs.
int areaFlood(List<List<GardenPlot>> garden, int x, int y) {
  if (garden[y][x].areaVisited) {
    return 0;
  }

  int area = 1;
  garden[y][x].areaVisited = true;

  for (var direction in Direction.values) {
    var newX = x + direction.dx;
    var newY = y + direction.dy;

    if (newX < 0 ||
        newY < 0 ||
        newX >= garden[0].length ||
        newY >= garden.length) {
      continue;
    }

    if (garden[newY][newX].value == garden[y][x].value) {
      if (!garden[newY][newX].areaVisited) {
        area += areaFlood(garden, newX, newY);
      }
      garden[y][x].fences[Direction.values.indexOf(direction)] = false;
      garden[newY][newX]
          .fences[Direction.values.indexOf(direction.opposite())] = false;
    }
  }

  return area!;
}

int perimeterFlood(List<List<GardenPlot>> garden, int x, int y) {
  if (garden[y][x].perimeterVisited) {
    return 0;
  }

  int perimeter = garden[y][x].fences.where((fence) => fence).length;
  garden[y][x].perimeterVisited = true;

  for (var direction in Direction.values) {
    var newX = x + direction.dx;
    var newY = y + direction.dy;

    if (newX < 0 ||
        newY < 0 ||
        newX >= garden[0].length ||
        newY >= garden.length) {
      continue;
    }

    if (garden[newY][newX].value == garden[y][x].value) {
      perimeter += perimeterFlood(garden, newX, newY);
    }
  }

  return perimeter;
}
