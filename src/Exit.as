
 
package 
{
	import org.flixel.*;

	public class Exit extends FlxSprite
	{
		[Embed(source = "../data/exit.png")] private var ImgExit:Class;
		public var _nextLevel:int;
		
		
		public function Exit(X:int,Y:int, nextLevel:int)
		{
			super(X, Y);
			_nextLevel = nextLevel;
			
		
			loadGraphic(ImgExit, true, false, 66, 110);			
			
			if (Registry.levelType == 1) {
				addAnimation("open", [0,0,0,1,0,0,1,0,1,0], 12 , true);
				addAnimation("closed", [2,2,2,3,2,2,3,2,3,2], 12 , true);
			}
			else if (Registry.levelType == 2) {
				addAnimation("open", [4,4,4,5,4,4,5,4,5,4], 12 , true);
				addAnimation("closed", [6,6,6,7,6,6,7,6,7,6], 12 , true);	
			}
			else if (Registry.levelType == 3) {
				addAnimation("open", [8,8,8,9,8,8,9,8,9,8], 12 , true);
				addAnimation("closed", [10,10,10,11,10,10,11,10,11,10], 12 , true);	
			}			
			
			
			
			play("closed");
			
			

		}

		override public function update():void
		{
			super.update();

		}
	}
}