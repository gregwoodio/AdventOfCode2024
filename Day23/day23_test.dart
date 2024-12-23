import 'package:test/test.dart';

import 'day23.dart';

Future<void> main() async {
  group('day 23', () {
    [
      [
        [
          'kh-tc',
          'qp-kh',
          'de-cg',
          'ka-co',
          'yn-aq',
          'qp-ub',
          'cg-tb',
          'vc-aq',
          'tb-ka',
          'wh-tc',
          'yn-cg',
          'kh-ub',
          'ta-co',
          'de-co',
          'tc-td',
          'tb-wq',
          'wh-td',
          'ta-ka',
          'td-qp',
          'aq-cg',
          'wq-ub',
          'ub-vc',
          'de-ta',
          'wq-aq',
          'wq-vc',
          'wh-yn',
          'ka-de',
          'kh-ta',
          'co-tc',
          'wh-qp',
          'tb-vc',
          'td-yn',
        ],
        7,
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
