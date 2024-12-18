import 'package:test/test.dart';

import 'day18.dart';

Future<void> main() async {
  group('day 18', () {
    [
      [
        [
          '5,4',
          '4,2',
          '4,5',
          '3,0',
          '2,1',
          '6,3',
          '2,4',
          '1,5',
          '0,6',
          '3,3',
          '2,6',
          '5,1',
          '1,2',
          '5,5',
          '2,5',
          '6,5',
          '1,4',
          '0,4',
          '6,4',
          '1,1',
          '6,1',
          '1,0',
          '0,5',
          '1,6',
          '2,0',
        ],
        22
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as int;

      test('part one', () {
        expect(part1(input, 12, 7), expected);
      });
    });

    [
      [
        [
          '5,4',
          '4,2',
          '4,5',
          '3,0',
          '2,1',
          '6,3',
          '2,4',
          '1,5',
          '0,6',
          '3,3',
          '2,6',
          '5,1',
          '1,2',
          '5,5',
          '2,5',
          '6,5',
          '1,4',
          '0,4',
          '6,4',
          '1,1',
          '6,1',
          '1,0',
          '0,5',
          '1,6',
          '2,0',
        ],
        '6,1',
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as String;

      test('part two', () {
        expect(part2(input, 12, 7), expected);
      });
    });
  });
}
