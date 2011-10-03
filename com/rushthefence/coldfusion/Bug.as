package com.rushthefence.coldfusion
{
  import net.flashpunk.Entity;
  import net.flashpunk.FP;
  import net.flashpunk.graphics.Spritemap;

  import com.rushthefence.GU;

  public class Bug extends Entity
  {
    public var bugSprMap:Spritemap = new Spritemap(Assets.IMG_BUG, 8,8);

    public function Bug()
    {
     bugSprMap.add("move", [0,1,2,3,4,5,6,7], 20, true);
     bugSprMap.play("move");
     graphic = bugSprMap;

     layer = 249;
    }
    
    override public function update():void
    {
      var bugs:Array = [];
      FP.world.getClass(Bug, bugs);
      for each (var bBug:Bug in bugs)
      {
        if (this == bBug)
          continue;

        if (this.distanceFrom(bBug) < 5)
          FP.stepTowards(this, Math.random()*800, Math.random()*600, -2);
      }

      if (this.distanceFrom(GU.config.scoop) < 100)
      {
        FP.stepTowards(this, GU.config.scoop.x, GU.config.scoop.y, -5);
        return;
      }
      var shortest:Number = 1600;
      var closeNode:PowerNode = null;
      var nodes:Array = [];
      FP.world.getClass(PowerNode, nodes);
      for each (var node:PowerNode in nodes)
      {
        if (node.mDischarging)
        {       
          var current:Number = FP.distance(this.x,this.y, node.x, node.y);
          if (current < shortest)
          {
            shortest = current;
            closeNode = node;
          }
        }
      }
      if (closeNode && this.distanceFrom(closeNode)>40)
        FP.stepTowards(this, closeNode.x+(Math.random()*32), closeNode.y+(Math.random()*32), 0.2);
      else
        if (closeNode)
          closeNode.mPower-=0.001;

      FP.stepTowards(this, Math.random()*800,Math.random()*600, 0.1);

    }
  }
}
