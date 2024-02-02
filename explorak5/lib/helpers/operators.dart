class Operators {
  static bool setEquals<int>(Set<int> a, Set<int> b) {
    if (b == null || a == null || a.length != b.length) return false;
    for (int value in a) {
      if (!b.contains(value)) return false;
    }
    return true;
  }
}
