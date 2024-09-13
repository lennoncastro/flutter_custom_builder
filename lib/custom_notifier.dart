class CustomNotifier<T> {
  CustomNotifier(T value) : _value = value;

  final List<Function()> _listeners = <Function()>[];

  T _value;

  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  void addListener(Function() callback) {
    _listeners.add(callback);
  }

  void removeListener(Function() callback) {
    _listeners.remove(callback);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void dispose() {
    _listeners.clear();
  }
}
