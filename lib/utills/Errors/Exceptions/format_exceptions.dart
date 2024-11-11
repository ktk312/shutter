class EFormatException implements Exception {
  final String code;
  EFormatException(this.code);

  String get message {
    switch (code) {
      case 'invalid-format':
        return 'The data format is invalid. Please check your input.';
      case 'format-mismatch':
        return 'The format does not match the expected type.';
      case 'data-corruption':
        return 'The data is corrupted and cannot be processed.';
      case 'json-parse-error':
        return 'Failed to parse JSON data. Please check the format.';
      case 'xml-parse-error':
        return 'Failed to parse XML data. Please check the format.';
      case 'csv-parse-error':
        return 'Failed to parse CSV data. Please check the format.';
      case 'invalid-date-format':
        return 'The date format is invalid. Please use the correct format.';
      case 'invalid-number-format':
        return 'The number format is invalid. Please check your input.';
      case 'invalid-string-format':
        return 'The string format is invalid. Please check your input.';
      case 'missing-required-field':
        return 'A required field is missing in the data format.';
      case 'unsupported-format':
        return 'The data format is not supported.';
      case 'encoding-error':
        return 'An encoding error occurred while processing the data.';
      case 'decoding-error':
        return 'A decoding error occurred while processing the data.';
      case 'type-cast-error':
        return 'Type casting failed. Please ensure data types are compatible.';
      case 'file-format-error':
        return 'The file format is not recognized. Please check the file.';
      default:
        return 'An unknown formatting error occurred.';
    }
  }
}
