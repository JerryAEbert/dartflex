part of dartflex.animation;

class Sine extends BaseEaser {
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  Sine({double easeInFraction: .5}) : super(easeInFraction: easeInFraction) {
  }
  
  //-----------------------------------
  //
  // Protected methods
  //
  //-----------------------------------
  
  double _easeIn(double fraction) {
    return 1.0 - cos(fraction * PI * .5);
  }
  
  double _easeOut(double fraction) {
    return sin(fraction * PI * .5);
  }
  
}

