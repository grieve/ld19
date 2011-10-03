package com.rushthefence
{
	public class GU
	{
    static public var epsilon:Number = 5;

    static public var config:Object = new Object();

		public function GU()
		{
		}

    static public function getSlope(x1:Number, y1:Number, x2:Number, y2:Number):Number
    {
      if (y1 == y2)
        return 0;
      if (x1 == x2)
        return NaN;

      return (y1-y2)/(x1-x2);
    }

    static public function getIntercept(x1:Number, y1:Number, slope:Number):Number
    {
      return y1 - (slope*x1);
    }

    static public function solveForY(x1:Number, slope:Number, intercept:Number):Number
    {
      return (slope*x1)+intercept;
    }

    static public function solveForX(y1:Number, slope:Number, intercept:Number):Number
    {
      return (y1 - intercept)/slope;
    }
		
		static public function nearEnough(a:Number, b:Number):Boolean
		{
      if (a-b < epsilon && a-b > (epsilon*(-1)))
        return true;
      else
        return false;
		}

	}
}
