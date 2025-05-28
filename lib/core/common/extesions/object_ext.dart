extension ObjectExt on Object? {
  /// Check if the object is null
  bool get isNull => this == null;

  /// Check if the object is not null
  bool get isNotNull => this != null;

  /// Check if the object is an empty string, list, map, or set
  bool get isEmpty {
    if (this == null) return true;
    if (this is String) return (this as String).trim().isEmpty;
    if (this is Iterable) return (this as Iterable).isEmpty;
    if (this is Map) return (this as Map).isEmpty;
    return false; // Fallback: not empty if type not handled
  }

  /// Check if the object is not empty
  bool get isNotEmpty => !isEmpty;

  /// Try to cast the object to a type, returns null if not possible
  T? asOrNull<T>() => this is T ? this as T : null;

  /// Try to convert to string
  String? get asString => this?.toString();

  /// Try to convert to int (if string/int)
  int? get asInt {
    if (this is int) return this as int;
    if (this is String) return int.tryParse(this as String);
    return null;
  }

  /// Try to convert to double (if string/double/int)
  double? get asDouble {
    if (this is double) return this as double;
    if (this is int) return (this as int).toDouble();
    if (this is String) return double.tryParse(this as String);
    return null;
  }

  /// Try to convert to bool (works with bool or string like 'true')
  bool? get asBool {
    if (this is bool) return this as bool;
    if (this is String) {
      final str = (this as String).toLowerCase().trim();
      return str == 'true' || str == '1';
    }
    return null;
  }

  /// Safely check equality with another object
  bool equals(Object? other) => this == other;

  /// Returns a default value if null
  T or<T>(T fallback) => this == null ? fallback : (this as T);
}
