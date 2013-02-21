part of dartflex.animation;

class Animator extends FrameworkEventDispatcher {

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
  // duration
  //-----------------------------------

  int _duration;

  int get duration => _duration;
  set duration(int value) => _duration = value;

  //-----------------------------------
  // easer
  //-----------------------------------

  IEaser _easer;

  IEaser get easer => _easer;
  set easer(IEaser value) => _easer = value;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Animator({double easeInFraction: .5}) : super() {
    _easeInFraction = easeInFraction;
  }

}