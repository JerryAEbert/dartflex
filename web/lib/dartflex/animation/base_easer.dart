part of dartflex.animation;

class BaseEaser implements IEaser {

  //-----------------------------------
  //
  // Public properties
  //
  //-----------------------------------

  //-----------------------------------
  // easeInFraction
  //-----------------------------------

  double _easeInFraction;

  double get easeInFraction => _easeInFraction;
  set easeInFraction(double value) => _easeInFraction = value;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  BaseEaser({double easeInFraction}) : super() {
    _easeInFraction = easeInFraction;
  }

  //-----------------------------------
  //
  // Public methods
  //
  //-----------------------------------

  double ease(double fraction) {
    double easeOutFraction = 1.0 - _easeInFraction;

    if (
        (fraction <= _easeInFraction) &&
        (_easeInFraction > .0)
    ) {
      return _easeInFraction * _easeIn(fraction / _easeInFraction);
    } else {
      return _easeInFraction + easeOutFraction * _easeOut((fraction - _easeInFraction) / easeOutFraction);
    }
  }

  //-----------------------------------
  //
  // Protected methods
  //
  //-----------------------------------

  double _easeIn(double fraction) {
    return fraction;
  }

  double _easeOut(double fraction) {
    return fraction;
  }
}

