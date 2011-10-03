package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.utils.Draw;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.graphics.Canvas;
  import flash.display.BitmapData;
  import flash.geom.Rectangle;

  import com.rushthefence.GU;

  public class HUD extends Entity
  {
    public var mCanvas:Canvas = new Canvas(800,600);

    public function HUD()
    {
      layer = 11;
    }
    
    override public function update():void
    {
    }

    override public function render():void
    {
      mCanvas.render(FP.buffer, FP.camera, FP.camera);
      var powRatio:Number = GU.config.powerCurrent/GU.config.powerGoal;
      Draw.rect(0,590,powRatio*800, 600, 0x00FF00, 1);
    }
  }
}
