package com.rushthefence.coldfusion
{
  import net.flashpunk.World;
  import net.flashpunk.FP;

  public class WinWorld extends World
  {

    public function WinWorld()
    {
      var inc:Number;
      add(new Win());
      add(new Snowflake());
    }
  }
}
