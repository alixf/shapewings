class Math2 {
  public static inline function clamp(a : Float, min : Float, max : Float) : Float
  {
    return Math.max(min, Math.min(max, a));
  }

  public static inline function clamp01(a : Float) : Float
  {
    return clamp(a, 0, 1);
  }

  public static function easeInBack(t : Float, b : Float, c : Float, d : Float) {
		var s = 1.70158;
		return c*(t/=d)*t*((s+1)*t - s) + b;
	}

	public static function easeOutBack(t : Float, b : Float, c : Float, d : Float) {
		var s = 1.70158;
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	}

	public static function easeInOutBack(t : Float, b : Float, c : Float, d : Float) {
		var s = 1.70158;
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	}

  public static function scale(a : Float, b : Float, c : Float, d : Float, t : Float) {
    return c + ((t - a) / (b - a)) * (b - a);
  }

  public static function lerp(a : Float, b : Float, t : Float) {
    return a + t * (b-a);
  }
}
