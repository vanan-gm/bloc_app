import 'package:bloc_app/core/common/extensions/object_ext.dart';

extension ListObjectExt<T> on List<T> {
  /// Finds items that have changed compared to another list.
  ///
  /// [other]: The list to compare against.
  /// [isSameItem]: A function that defines if two items are the "same".
  /// [extractComparableFields]: A function that extracts the properties you want to compare.
  List<T> findChangedItems(
    List<T> other, {
    required bool Function(T a, T b) isSameItem,
    required Map<String, dynamic> Function(T item) extractComparableFields,
  }) {
    final changed = <T>[];

    for (final newItem in this) {
      final oldItem = other.firstWhere(
        (old) => isSameItem(old, newItem),
        orElse: () => null as T,
      );

      if (oldItem.isNull) continue;

      final oldFields = extractComparableFields(oldItem);
      final newFields = extractComparableFields(newItem);

      final hasChange = oldFields.entries.any(
        (entry) => newFields[entry.key] != entry.value,
      );

      if (hasChange) {
        changed.add(newItem);
      }
    }

    return changed;
  }
}
