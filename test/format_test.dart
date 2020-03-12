import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });
    test('zero', () {
      expect(Format.hours(0), '0h');
    });
    test('negative', () {
      expect(Format.hours(-5), '0h');
    });
    test('decimal', () {
      expect(Format.hours(4.5), '4.5h');
    });
  });

  group('date - GB Local', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2019-08-12', () {
      expect(Format.date(DateTime(209, 8, 12)), '12 Aug 209');
    });
    test('2019-08-16', () {
      expect(Format.date(DateTime(209, 8, 16)), '16 Aug 209');
    });
  });

  group('dayOfWeek - GB Local', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Monday', () {
      expect(Format.dayOfWeek(DateTime(209, 8, 12)), 'Sat');
    });
  });

  group('dayOfWeek - IT Local', () {
    setUp(() async {
      Intl.defaultLocale = 'it_IT';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Lunedi', () {
      expect(Format.dayOfWeek(DateTime(209, 8, 12)), 'sab');
    });
  });

  group('currency - US Local', () {
    setUp(() {
      Intl.defaultLocale = 'en_us';
    });
    test('positive', () {
      expect(Format.currency(10), '\$10');
    });
    test('zero', () {
      expect(Format.currency(0), '');
    });
    test('negative', () {
      expect(Format.currency(-5), '-\$5');
    });
  });
}
