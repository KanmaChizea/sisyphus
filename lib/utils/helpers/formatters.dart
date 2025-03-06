import 'package:intl/intl.dart';

class Formatters {
  Formatters._();
  static String parseAndFormatNumber(String input) {
    // Remove invalid characters but keep digits, decimal points, and a leading negative sign
    String cleaned = input.replaceAll(RegExp(r'[^0-9.-]'), '');

    // Allow only one leading negative sign
    if (cleaned.contains('-')) {
      cleaned = '-${cleaned.replaceAll('-', '')}';
    }

    // Handle decimal point allowance
    List<String> parts = cleaned.split('.');
    if (parts.length > 2) {
      cleaned = '${parts[0]}.${parts.sublist(1).join('')}';
    }

    // Preserve trailing decimal point
    bool endsWithDot = cleaned.endsWith('.');

    // Convert to number (ignore parsing if just "-")
    if (cleaned.isEmpty || cleaned == '-' || cleaned == '.') return cleaned;

    num? number =
        cleaned.contains('.')
            ? double.tryParse(cleaned)
            : int.tryParse(cleaned);
    if (number == null) return cleaned;

    // Format with commas
    final formatter = NumberFormat("#,##0.##");
    String formatted = formatter.format(number);

    // Restore trailing decimal point if user is typing it
    if (endsWithDot) {
      formatted += ".";
    }

    return formatted;
  }

  static double parseFormattedNumber(String numberString) {
    String cleanString = numberString.replaceAll(',', '');
    return double.tryParse(cleanString) ?? 0;
  }

  static String formatMoney(double amount, [String? currency]) {
    final format = NumberFormat.currency(
      symbol: currency ?? '',
      decimalDigits: 2,
    );
    return format.format(amount).trim();
  }

  static String stringToPercent(String value) {
    double parsedValue = parseFormattedNumber(value);

    return "${parsedValue < 0 ? '-' : '+'}${parsedValue.toStringAsFixed(2)}%";
  }

  static String formatStringNumber(String value) {
    double parsedValue = parseFormattedNumber(value);
    return parsedValue.toStringAsFixed(2);
  }

  static String date(int value, String format) {
    return DateFormat(
      format,
    ).format(DateTime.fromMicrosecondsSinceEpoch(value));
  }
}
