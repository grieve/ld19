package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Spritemap;
  import net.flashpunk.utils.Input;

  import com.rushthefence.GU;

  public class Win extends Entity
  {
    public var titleSprMap:Spritemap = new Spritemap(Assets.IMG_WIN, 680,100);
    public var mMaxHeatRange:Number = 60;

    public function Win()
    {
     titleSprMap.add("flash", [0,1,2,3,4,5,6,7,6,5,4,3,2,1], 20, true);
     titleSprMap.play("flash");
     graphic = titleSprMap;
     this.x = 60;
     this.y = 200;
     layer = 249;
    }
    
    override public function update():void
    {
        var snowies:Array = [];
        FP.world.getClass(Snowflake, snowies);
        for (var tx:Number=this.x; tx<this.x+680; tx+=50)
        {
          var cX:Number = tx;
          var cY:Number = this.y + 50;
          for (var incx:Number=-110; incx<=110; incx++)
            for(var incy:Number=-110; incy<=110; incy++)
            {
              var dis:Number = FP.distance(cX,cY,cX+incx,cY+incy);
              if (((mMaxHeatRange-dis)/mMaxHeatRange)*((mMaxHeatRange-dis)/mMaxHeatRange)*((mMaxHeatRange-dis)/mMaxHeatRange) > (Math.random()) && dis < 110)
                if (Math.random() > 0.9)
                  snowies[0].singleBlank(cX+incx, cY+incy);
            }
        }

        if (Input.mousePressed)
        {
          FP.world = new GameWorld(800,600, 7, 100, 100000, 1);
        }
    }
  }
}
