package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Backdrop;
  import net.flashpunk.graphics.Image;
  import net.flashpunk.utils.Draw;

  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BitmapDataChannel;
  import flash.geom.ColorTransform;
  import flash.geom.Rectangle;
  import flash.geom.Point;

  import com.rushthefence.GU;

  public class Clouds extends Entity
  {
    public var goX:Number = 1;
    public var goY:Number = 1;

    public var nowX:Number = 0;
    public var nowY:Number = 0;

    public var clouds:Backdrop= new Backdrop(Assets.IMG_CLOUDS, true, true);
    public var bmd:BitmapData = new BitmapData(1600,1200, true, 0xFFFFFFF);

    public function Clouds()
    {
     layer = 22;
     updateDir();
     var temp:Image = new Image(Assets.IMG_MASK);
     temp.render(bmd,FP.camera,FP.camera);
    }
    
    override public function update():void
    {
      clouds.x += goX;
      clouds.y += goY;
    }

    override public function render():void
    {
      var bmd2:BitmapData = new BitmapData(800,600, true, 0xFFFFFFF);
      clouds.alpha = 0.6;
      clouds.render(bmd2, FP.camera, FP.camera);
      //bmd2.merge(bmd, new Rectangle(0,0,1600,1200),new Point(GU.config.scoop.x-800,GU.config.scoop.y-600),0,0,0,128);
      graphic = new Image(bmd2);
      super.render();
    }

    public function updateDir():void
    {
      goX = (Math.random()*0.8)-0.4;
      goY = (Math.random()*0.8)-0.4;
    }
  }
}
