import "package:HungryHippos/screens/limit.dart";

class Limits {
  static List<Limit> limits = _getLimits();
  static Limit _selectedLimit = limits[0];

  static List<Limit> _getLimits() {
    return <Limit>[
      Limit(10),
      Limit(20),
      Limit(30),
    ];
  }

  static List<Limit> getLimits() {
    return limits;
  }

  static void setSelectedLimit(Limit selectedLimit) {
    _selectedLimit = selectedLimit;
  }

  static Limit getSelectedLimit() {
    return _selectedLimit;
  }
}