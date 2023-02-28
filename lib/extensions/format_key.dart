extension FormatKey on String {
  String get formatKey {
    final shadow = this;
    final formatted = shadow.replaceAll('_', ' ').split(' ').map((e) {
      return '${e[0].toUpperCase()}${e.substring(1)}';
    }).join(' ');

    return formatted;
  }
}
