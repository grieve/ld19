package com.rushthefence.coldfusion
{
  import net.flashpunk.Engine;
  import net.flashpunk.FP;

  public class Main extends Engine
  {
    public function Main()
    {
      super(800, 600, 60,false);
      FP.world = new GameWorld(800,600, 7, 100, 100000, 1);
    }

    override public function init():void
    {
    }
  }
}
