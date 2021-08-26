typedef GetValue<E, T> = T Function(E element);

extension ListExt<T> on List<T> {
  Map<TKey, TVal> toMap<TKey, TVal>(
      GetValue<T, TKey> getKey, GetValue<T, TVal> getVal) =>
      {for (final e in this) getKey(e): getVal(e)};
}