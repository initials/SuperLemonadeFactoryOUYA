package
{
	import org.flixel.*;
	import Math;
	
	public class EnemyInspector extends Enemy
	{
		[Embed(source="../data/chars_50x50.png")] private var ImgChars:Class;

		public function EnemyInspector(X:int, Y:int, talkString:String)
		{
			super(X+6, Y, talkString);
			
			loadGraphic(ImgChars, true, true, 50,80);
						
			//animations
			
			addAnimation("idle", [3], 1, true);
			addAnimation("walk", [24, 25, 26, 27, 28, 29], 10, true);
			addAnimation("talk", [3,56], 8, true);

					
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