import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/paging.dart';

void main() {
  group('PageIndexPaging', () {
    test('query uses the backend pageIndex/perPage convention', () {
      expect(PageIndexPaging.query(2), {'pageIndex': 2, 'perPage': 20});
      expect(PageIndexPaging.query(1, perPage: 50), {'pageIndex': 1, 'perPage': 50});
    });

    test('parse reads the backend pagination block', () {
      expect(
        PageIndexPaging.parse({
          'count': 41,
          'totalPages': 3,
          'isNext': true,
          'isPrev': false,
          'nextPage': 2,
        }),
        const PageInfo(hasNext: true, totalPages: 3, count: 41),
      );
    });

    test('parse treats a missing pagination block as a single empty page', () {
      expect(
        PageIndexPaging.parse(null),
        const PageInfo(hasNext: false, totalPages: 1, count: 0),
      );
    });
  });

  test('mergeUniqueBy appends new items and drops ids already present', () {
    final current = [(id: 'a', v: 1), (id: 'b', v: 1)];
    final incoming = [(id: 'b', v: 2), (id: 'c', v: 2)];

    final merged = mergeUniqueBy(current, incoming, (x) => x.id);

    expect(merged.map((x) => x.id), ['a', 'b', 'c']);
    expect(merged[1].v, 1, reason: 'the first occurrence wins');
  });
}
