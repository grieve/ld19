package com.rushthefence.coldfusion
{
  import net.flashpunk.World;
  import net.flashpunk.FP;
  import net.flashpunk.utils.Draw;

  import com.rushthefence.GU;

  public class GameWorld extends World
  {

    private var mScoop:Scoop = new Scoop();
//    private var mClouds:Clouds = new Clouds();
    private var mHUD:HUD = new HUD();
    private var mPlants:Array = [];
    private var mBugs:Array = [];

    public function GameWorld(maxX:Number, maxY:Number, numPlants:Number, numSpiders:Number, powerGoal:Number, difficulty:Number)
    {
      GU.config.powerCurrent = 0;
      GU.config.numActive = 0;
      GU.config.difficulty = difficulty;
      var inc:Number;
      var dx:Number;
      var dy:Number;
      var di:Number;
      var ok:Boolean;
      var plant:PowerNode;
      var bug:Bug;

      for (inc=0;inc<=numPlants;inc++)
      {
        ok = false;
        while (!ok)
        {
          dx = Math.random()*(maxX-120) + 60;
          dy = Math.random()*(maxY-120) + 60;
          ok = true;
          for each (plant in mPlants)
          {
            if (FP.distance(dx, dy, plant.x, plant.y) < 160)
              ok = false;
          }
        }
        if(inc < numPlants)
        {
          plant = new PowerNode();
          plant.x = dx;
          plant.y = dy;
          mPlants.push(plant);
          add(plant);
        }
        else
        {
          mScoop.x = dx;
          mScoop.y = dy;
        }
      }

      add(mScoop);
      add(mHUD);
      //add(mClouds);
      add(new Snowflake());

      GU.config.dynamite = 3;
      GU.config.powerGoal = powerGoal;
      GU.config.currentPower = 0;

      for (inc=0;inc<numSpiders;inc++)
      {
        bug = new Bug();
        bug.x = Math.random()*800;
        bug.y = Math.random()*600;
        mBugs.push(bug);
        add(bug);
      }
    }

    override public function update():void
    {
        if (GU.config.powerCurrent < 0)
        {
          GU.config.powerCurrent = 0;
        }
        if (GU.config.powerCurrent >= GU.config.powerGoal)
        {
          FP.world = new WinWorld();
        }
        super.update();
    }
  }
}
