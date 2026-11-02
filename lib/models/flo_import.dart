class FloImportRow {
  final DateTime date;
  final String? symptoms;
  final String? moods;
  final String? flow;
  final double? bbt;
  final double? weight;
  final String? notes;

  const FloImportRow({
    required this.date,
    this.symptoms,
    this.moods,
    this.flow,
    this.bbt,
    this.weight,
    this.notes,
  });
}

class FloImportResult {
  final int totalRows;
  final int imported;
  final int skipped;
  final List<String> errors;

  const FloImportResult({
    required this.totalRows,
    required this.imported,
    required this.skipped,
    required this.errors,
  });
}
