import 'package:test/test.dart';

import 'day25.dart';

Future<void> main() async {
  group('day 25', () {
    [
      [
        [
          '#####',
          '.####',
          '.####',
          '.####',
          '.#.#.',
          '.#...',
          '.....',
          '',
          '#####',
          '##.##',
          '.#.##',
          '...##',
          '...#.',
          '...#.',
          '.....',
          '',
          '.....',
          '#....',
          '#....',
          '#...#',
          '#.#.#',
          '#.###',
          '#####',
          '',
          '.....',
          '.....',
          '#.#..',
          '###..',
          '###.#',
          '###.#',
          '#####',
          '',
          '.....',
          '.....',
          '.....',
          '#....',
          '#.#..',
          '#.#.#',
          '#####',
        ],
        3,
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as int;

      test('part one', () {
        expect(part1(input), expected);
      });
    });
  });
}
