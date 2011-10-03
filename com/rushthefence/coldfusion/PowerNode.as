package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Spritemap;

  import com.rushthefence.GU;

  public class PowerNode extends Entity
  {
    public var spriteMap:Spritemap = new Spritemap(Assets.IMG_POWERNODE, 32, 32);

    public var mPower:Number = 0;
    public var mDischarging:Boolean = false;
    public var mPrime:Boolean = false;
    public var mMaxHeatRange:Number = 60;

    public function PowerNode(prime:Boolean = false)
    {
      mPrime = prime;
      spriteMap.add("on", [0,1,2,3,8,9,10,11,10,9,8,3,2,1], 30, true);
      spriteMap.add("off", [4,5,6,7,12,13,14,15,14,13,12,7,6,5], 10, true);

      graphic = spriteMap;
      spriteMap.play("off");
      layer = 299;
      setHitbox(100,100, 34, 34);
      type = "node";
    }
    
    override public function update():void
    {
      if (mPrime)
        mPower = 1;
      if (collide("scoop", x, y))
        mPower += 0.02;

      mPower -= 0.0015
      if (mPower <= 0)
      {
        mPower=0;
        if (mDischarging)
        {
          spriteMap.play("off");
          mDischarging = false;
          GU.config.numActive--;
        }
        GU.config.powerCurrent--;
      }
      if (mPower > 1)
      {
        mPower=1;
        if (!mDischarging)
        {
          mDischarging = true;
          spriteMap.play("on");
          GU.config.numActive++;
        }
      }
      if (mDischarging)
      {
        GU.config.powerCurrent += (GU.config.numActive*GU.config.numActive*GU.config.difficulty);
        var snowies:Array = [];    
        FP.world.getClass(Snowflake, snowies);
        var cX:Number = this.x + 16;
        var cY:Number = this.y + 16;
        for (var incx:Number=-35; incx<=35; incx++)
          for(var incy:Number=-35; incy<=35; incy++)
          {
            var dis:Number = FP.distance(cX,cY,cX+incx,cY+incy);
            if (((mMaxHeatRange-dis)/mMaxHeatRange)*((mMaxHeatRange-dis)/mMaxHeatRange)*((mMaxHeatRange-dis)/mMaxHeatRange) > (Math.random()) && dis < 35)
              if (Math.random() > 0.9)
                snowies[0].singleBlank(cX+incx, cY+incy);
          }
      }
    }
  }
}
