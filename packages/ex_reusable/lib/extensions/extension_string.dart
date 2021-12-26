///   created               : Aditya Pratama
///   originalFilename      : string_extension
///   date                  : 19 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   scope                 : string only

enum DocumentType {
  xls, doc, ppt, pdf, file
}

extension StringExtension on String {
  /// input = aditya pratama | output = A
  String get firstWord => length > 1 ? substring(0, 1).toUpperCase() : '';

  /// input = aditya pratama kurniawan | output = AP
  String get initialName {
    final List<String> splitW = split(' ');
    String output = '';
    try {
      if (splitW.length > 1) {
        final String fWord = splitW[0].substring(0, 1).toUpperCase();
        final String sWord = splitW[1].substring(0, 1).toUpperCase();
        output = fWord + sWord;
      } else {
        final String fWord = splitW[0].substring(0, 1).toUpperCase();
        output = fWord;
      }
    } catch (e) {
      output = '-';
    }
    return output;
  }

  /// get type document url
  DocumentType get typeDocumentUrl => contains('xls') ? DocumentType.xls : contains('doc') ?
  DocumentType.doc : contains('ppt') ? DocumentType.ppt : contains('pdf') ? DocumentType.pdf : DocumentType.file;

  /// get icon document
  String get iconDocument => contains('xls') ? 'assets/images/ic_xls.svg' : contains('doc') ?
  'assets/images/ic_doc.svg' : contains('ppt') ? 'assets/images/ic_ppt.svg' : contains('pdf') ? 'assets/images/ic_pdf.svg' :
  'assets/images/ic_file.svg';
}
