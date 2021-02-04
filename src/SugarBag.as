package 
{
	import org.flixel.*;

	public class SugarBag extends PickUp
	{
		[Embed(source="../data/pickups/smallSugarBag.png")] private var Img:Class;
		
		public function SugarBag(X:int,Y:int)
		{
			super(X, Y);
						
			loadGraphic(Img, true, false, 22, 25);			
			
			addAnimation("blink", [0,1], (2+FlxG.random()*2) , true);
			
			play("blink");
			

		}

		override public function update():void
		{
			super.update();

		}
	}
}