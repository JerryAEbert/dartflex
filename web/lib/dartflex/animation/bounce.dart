part of dartflex.animation;

class Bounce extends BaseEaser {

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Bounce({double easeInFraction: .5}) : super(easeInFraction: easeInFraction) {
  }

  //-----------------------------------
  //
  // Protected methods
  //
  //-----------------------------------

  double _easeIn(double fraction) {
    return 1 - _easeOut(fraction);
  }

  double _easeOut(double fraction) {
    if (fraction < (1.0 / 2.75)) {
      return (7.5625 * fraction * fraction);
    } else if (fraction < (2 / 2.75)) {
      return (7.5625 * (fraction -= (1.5 / 2.75)) * fraction + 0.75);
    } else if (fraction < (2.5 / 2.75)) {
      return (7.5625 * (fraction -= (2.25 / 2.75)) * fraction + 0.9375);
    } else {
      return (7.5625 * (fraction -= (2.625 / 2.75)) * fraction + 0.984375);
    }
  }

}



