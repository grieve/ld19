package com.rushthefence.utils
{
	public class Velocity
	{
		public var componentX:Number;
		public var componentY:Number;
		
		public function Velocity(comX:Number=0,comY:Number=0)
		{
			componentX=comX;
			componentY=comY;
		}
		
		public function getX():Number
		{
			return componentX;
		}
		
		public function getY():Number
		{
			return componentY;
		}
		
		public function setX(X:Number):void
		{
			componentX=X;
		}
		
		public function setY(Y:Number):void
		{
			componentY=Y;
		}
		
		public function getMagnitude():Number
		{
			return Math.sqrt((componentX*componentX)+(componentY*componentY));
		}
		
		public function getDirection():Number
		{
			var angle:Number;
			angle=Math.atan2(componentY,componentX);
			return angle;
		}
		
		public function setVelocity(comX:Number, comY:Number, mag:Number):void
		{
			/* to prevent future idiocy this comment is here to tell you that
			you used absolute values to decide the magnitude components and then
			used the sign of the passed coordinates to re-sign the components*/
			
			componentX=(Math.abs(comX)/(Math.abs(comX)+Math.abs(comY)))*mag;
			componentY=(Math.abs(comY)/(Math.abs(comX)+Math.abs(comY)))*mag;
			
			if(comX<0)
				if(componentX>0)
					componentX=componentX*(-1)
			else
				if(componentX<0)
					componentX=componentX*(-1)
					
			if(comY<0)
				if(componentY>0)
					componentY=componentY*(-1)
			else
				if(componentY<0)
					componentY=componentY*(-1)
		}
		
		public function addVelocity(vel:Velocity):void
		{
			componentX+=vel.getX();
			componentY+=vel.getY();
		}
	}
}
