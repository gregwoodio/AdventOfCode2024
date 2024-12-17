import 'package:test/test.dart';

import 'day17.dart';

Future<void> main() async {
  group('day 17', () {
    [
      [
        [
          'Register A: 729',
          'Register B: 0',
          'Register C: 0',
          '',
          'Program: 0,1,5,4,3,0',
        ],
        '4,6,3,5,6,3,5,2,1,0',
      ],
    ].forEach((testCase) {
      var input = testCase[0] as List<String>;
      var expected = testCase[1] as String;

      test('part one', () {
        expect(part1(input), expected);
      });
    });
  });
}
