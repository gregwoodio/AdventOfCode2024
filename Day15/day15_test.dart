import 'package:test/test.dart';

import 'day15.dart';

Future<void> main() async {
  group('day 15', () {
    [
      [
        [
          '########',
          '#..O.O.#',
          '##@.O..#',
          '#...O..#',
          '#.#.O..#',
          '#...O..#',
          '#......#',
          '########',
          '',
          '<^^>>>vv<v>>v<<',
        ],
        2028,
      ],
      [
        [
          '##########',
          '#..O..O.O#',
          '#......O.#',
          '#.OO..O.O#',
          '#..O@..O.#',
          '#O#..O...#',
          '#O..O..O.#',
          '#.OO.O.OO#',
          '#....O...#',
          '##########',
          '',
          '<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^',
          'vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v',
          '><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<',
          '<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^',
          '^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><',
          '^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^',
          '>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^',
          '<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>',
          '^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>',
          'v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^',
        ],
        10092,
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as int;

      test('part one', () {
        expect(part1(input), expected);
      });
    });

    [
      [
        [
          '##########',
          '#..O..O.O#',
          '#......O.#',
          '#.OO..O.O#',
          '#..O@..O.#',
          '#O#..O...#',
          '#O..O..O.#',
          '#.OO.O.OO#',
          '#....O...#',
          '##########',
          '',
          '<vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^',
          'vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v',
          '><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<',
          '<<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^',
          '^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><',
          '^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^',
          '>^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^',
          '<><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>',
          '^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>',
          'v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^',
        ],
        9021,
      ],
      [
        [
          '######',
          '#....#',
          "#@O..#",
          '#..O.#',
          '#....#',
          '######',
          '',
          '>>^>vv',
        ],
        711,
      ],
      [
        [
          '######',
          '#....#',
          "#..O@#",
          '#.O..#',
          '#....#',
          '######',
          '',
          '<vv<<<^^',
        ],
        309,
      ],
      [
        [
          '######',
          '#..O@#',
          '######',
          '',
          '<<<<',
        ],
        102
      ],
      [
        [
          '######',
          '#@O..#',
          '######',
          '',
          '>>>>',
        ],
        107
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as int;

      test('part two', () {
        expect(part2(input), expected);
      });
    });
  });
}