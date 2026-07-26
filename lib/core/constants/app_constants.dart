/// Shared spacing, radius and animation-duration tokens.
class AppRadius {
  AppRadius._();
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 28;
  static const double pill = 100;
}

class AppSpacing {
  AppSpacing._();
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

class AppDurations {
  AppDurations._();
  static const press = Duration(milliseconds: 120);
  static const entrance = Duration(milliseconds: 480);
  static const stagger = Duration(milliseconds: 70);
}
