///   created               : Aditya Pratama
///   originalFilename      : _key_val
///   date                  : 20 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   general object Key Value. use example:
///   - bottom sheet dialog
///   - list dialog
///   - etc.
///
class KeyVal {
  KeyVal({required this.key, required this.val, this.icon, this.badge});

  dynamic key;
  String val;
  String? icon;
  bool? badge;
}
