package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.PreRotation;

  import net.flashpunk.utils.Input;
  import net.flashpunk.utils.Key;
  import net.flashpunk.utils.Draw;

  import net.flashpunk.World;
  import net.flashpunk.FP;

  import com.rushthefence.utils.Velocity;
  import com.rushthefence.GU;

  public class Scoop extends Entity
  {
    private const MAX_SPEED:Number = 2;
    private const MAX_ROTATION:Number = 5;
 
    private var image:PreRotation = new PreRotation(Assets.IMG_SCOOP);

    public var mVelocity:Velocity = new Velocity();
   

    public var mDesiredRotation:Number = 0;
    public var mDesiredLocationX:Number = 0;
    public var mDesiredLocationY:Number = 0;

    public var mMoving:Boolean = false;
    public var mDynamite:Number = 3;

    public function Scoop()
    {
      graphic = image;
      image.centerOO();
      layer = 99;
      type = "scoop";
      GU.config.scoop = this;
    }
    
    override public function update():void
    {
      updateHeading();
      if(mMoving)
      {
         if (mDesiredLocationX >= this.x)
           this.x = FP.approach(this.x, mDesiredLocationX, mVelocity.getX());
         else
           this.x = FP.approach(this.x, mDesiredLocationX, mVelocity.getX()*(-1));
  
        if (mDesiredLocationY >= this.y)
          this.y = FP.approach(this.y, mDesiredLocationY, mVelocity.getY());
        else
          this.y = FP.approach(this.y, mDesiredLocationY, mVelocity.getY()*(-1));
   
        if (mDesiredRotation > image.angle)
        {
          if ((mDesiredRotation - image.angle) < (image.angle - mDesiredRotation +360))
            image.angle+= MAX_ROTATION;
          else
            image.angle-= MAX_ROTATION;
        }
        if (mDesiredRotation < image.angle)
        {
          if ((image.angle - mDesiredRotation) < (mDesiredRotation - image.angle + 360))
            image.angle-= MAX_ROTATION*(mVelocity.getMagnitude()/MAX_SPEED);
          else
            image.angle+= MAX_ROTATION*(mVelocity.getMagnitude()/MAX_SPEED);
        }
  
        if (image.angle < 0)
          image.angle+=360;
        if (image.angle >360)
          image.angle-=360;
      }
      var objects:Array = new Array();
      FP.world.getClass(Snowflake, objects); 

      objects[0].blanky(this.x, this.y);

      if (Input.pressed(Key.SPACE) && GU.config.dynamite > 0)
      {
        for (var incx:Number = this.x-60; incx <= this.x+60; incx++)
          for (var incy:Number = this.y-60; incy <= this.y+60; incy++)
            if (FP.distance(this.x, this.y, incx, incy) <= 60)
              objects[0].singleBlank(incx, incy);
        GU.config.dynamite--;
        FP.world.add(new Explo(this.x-50, this.y-50));
      }
    }

    override public function render():void
    {
      var node:PowerNode = collide("node",x ,y) as PowerNode;
      if (node)
      {
        Draw.curve(this.x, this.y, node.x+(Math.random()*20)-10, node.y+(Math.random()*20)-10, node.x+16, node.y+16, (Math.random()*2)+1, 0x8888FF, 0.7); 
        Draw.curve(this.x, this.y, node.x+(Math.random()*20)-10, node.y+(Math.random()*20)-10, node.x+16, node.y+16, (Math.random()*2)+1, 0xFF88FF, 0.7); 
        Draw.curve(this.x, this.y, node.x+(Math.random()*20)-10, node.y+(Math.random()*20)-10, node.x+16, node.y+16, (Math.random()*2)+1, 0xCCCFF, 0.7); 
      }
      super.render();
    }

    public function updateDestination(newX:Number, newY:Number):void
    {
      mDesiredLocationX = newX;
      mDesiredLocationY = newY;
    }

    public function updateHeading():void
    {
      if (Input.mousePressed || Input.mouseDown)
      {
        updateDestination(Input.mouseX, Input.mouseY);
        mMoving = true;
      }

      if (GU.nearEnough(mDesiredLocationX, this.x) && GU.nearEnough(mDesiredLocationY, this.y))
        mMoving = false;

      mDesiredRotation = FP.angle(this.x, this.y, mDesiredLocationX, mDesiredLocationY);
      var temp:Object = new Object();
      FP.angleXY(temp, image.angle, MAX_SPEED);
      mVelocity.setX(temp.x);
      mVelocity.setY(temp.y);
    }
  }
}
