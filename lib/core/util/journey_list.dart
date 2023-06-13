import 'dart:collection';

class JourneyList<E, T> extends ListBase<E> {
  JourneyList(this.modelData);

  T modelData;

  E start() {
    return this[0];
  }

  List innerList = <E>[];

  @override
  int get length => innerList.length;

  @override
  set length(int length) {
    innerList.length = length;
  }

  @override
  void operator []=(int index, E value) {
    innerList[index] = value;
  }

  @override
  E operator [](int index) => innerList[index];

  @override
  void add(E element) => innerList.add(element);

  @override
  void addAll(Iterable<E> iterable) => innerList.addAll(iterable);
}
