package
{
	import org.flixel.*;
	import Math;
	
	public class EnemyArmy extends Enemy
	{
		[Embed(source="../data/chars_50x50.png")] private var ImgChars:Class;

		public function EnemyArmy(X:int, Y:int, talkString:String)
		{
			super(X+6, Y, talkString);
			
			loadGraphic(ImgChars, true, true, 50,80);
						
			//animations
			
			addAnimation("idle", [4], 1, true);
			addAnimation("walk", [36,37,38,39,40,41], 10, true);
			addAnimation("talk", [4,57], 6, true);

			
			play("idle", true);
			
			this.width = 10;
			this.height = 41;        
			this.offset.x = 20;
			this.offset.y = 39;

		}
		
		override public function update():void
		{
			super.update();
			
		}
	}
}