package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Spritemap;

  public class Explo extends Entity
  {
    private var exploMap:Spritemap = new Spritemap(Assets.IMG_EXPLO, 100,100);


    public function Explo(ix:Number, iy:Number)
    {
      this.x = ix;
      this.y = iy;
      exploMap.add("boom", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], 20, false);
      exploMap.callback = destroy;
      exploMap.play("boom");
      graphic = exploMap;
    }
    
    public function destroy():void
    {
      FP.world.remove(this);
    }
  }
}
