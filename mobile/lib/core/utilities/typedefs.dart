typedef AsyncVoidCallback = Future<void> Function();

typedef AsyncValueMapper<T> = Future<T> Function(T);
typedef AsyncValueTransformer<T, U> = Future<U> Function(T);

typedef ValueMapper<T> = T Function(T);
typedef ValueTransformer<T, U> = U Function(T);
typedef ValueSelected<T> = void Function(T);
