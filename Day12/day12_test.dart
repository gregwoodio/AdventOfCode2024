import 'package:test/test.dart';

import 'day12.dart';

Future<void> main() async {
  group('day 12', () {
    [
      [
        [
          'AAAA',
          'BBCD',
          'BBCC',
          'EEEC',
        ],
        140
      ],
      [
        [
          'OOOOO',
          'OXOXO',
          'OOOOO',
          'OXOXO',
          'OOOOO',
        ],
        772,
      ],
      [
        [
          'RRRRIICCFF',
          'RRRRIICCCF',
          'VVRRRCCFFF',
          'VVRCCCJFFF',
          'VVVVCJJCFE',
          'VVIVCCJJEE',
          'VVIIICJJEE',
          'MIIIIIJJEE',
          'MIIISIJEEE',
          'MMMISSJEEE',
        ],
        1930,
      ]
    ].forEach((testCase) {
      final input = testCase[0] as List<String>;
      final expected = testCase[1] as int;
      test('part one', () {
        expect(part1(input), expected);
      });
    });

    [
      [
        [
          'AAAA',
          'BBCD',
          'BBCC',
          'EEEC',
        ],
        80
      ],
      [
        [
          'OOOOO',
          'OXOXO',
          'OOOOO',
          'OXOXO',
          'OOOOO',
        ],
        436,
      ],
      [
        [
          'EEEEE',
          'EXXXX',
          'EEEEE',
          'EXXXX',
          'EEEEE',
        ],
        236,
      ],
      [
        [
          'AAAAAA',
          'AAABBA',
          'AAABBA',
          'ABBAAA',
          'ABBAAA',
          'AAAAAA',
        ],
        368,
      ],
      [
        [
          'RRRRIICCFF',
          'RRRRIICCCF',
          'VVRRRCCFFF',
          'VVRCCCJFFF',
          'VVVVCJJCFE',
          'VVIVCCJJEE',
          'VVIIICJJEE',
          'MIIIIIJJEE',
          'MIIISIJEEE',
          'MMMISSJEEE',
        ],
        1206,
      ],
    ].forEach((testCase) {
      final input = testCase[0] as List<String>;
      final expected = testCase[1] as int;

      test('part two', () {
        expect(part2(input), expected);
      });
    });
  });
}
