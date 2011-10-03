package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Canvas;
  import net.flashpunk.FP;

  import flash.display.BitmapData;

  public class Snowflake extends Entity
  {
    private var mBitmap:BitmapData = new BitmapData(800,600,true,0xFFFFFFFF); 

    public function Snowflake()
    {
      graphic = new Image(mBitmap);
      layer = 199;
    }
    
    override public function update():void
    {
      for (var inc:Number=0; inc <40; inc++)
        mBitmap.setPixel32(Math.random()*800,Math.random()*600,0xFFFFFFFF);
      graphic = new Image(mBitmap);
    }

    public function blanky(ix:Number, iy:Number):void
    {
      for(var incx:Number = ix-10; incx < ix+10; incx++)
        for(var incy:Number = iy-10; incy < iy+10; incy++)
          mBitmap.setPixel32(incx,incy,0x000000FF);
    }

    public function singleBlank(ix:Number, iy:Number):void
    {
      mBitmap.setPixel32(ix,iy,0x000000FF);
    }

    public function getSnowIndex(ix:Number, iy:Number):Number
    {
      var totalIndex:Number = 0;
      var totalCount:Number = 0;
      for (var incx:Number=ix-5; incx<= ix+5; incx++)
        for(var incy:Number=iy-5; incy<= iy+5; incy++)
          if (FP.distance(ix, iy, incx, incy) <=5)
          {
            totalCount++;
            if (mBitmap.getPixel(incx, incy) != 0xFFFFFFFF)
              totalIndex++;
          }
      return (totalIndex/totalCount);
    }
  }
}
