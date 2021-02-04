package
{
	import org.flixel.*;
	import Math;
	
	public class EnemyChef extends Enemy
	{
		[Embed(source="../data/chars_50x50.png")] private var ImgChars:Class;

		public function EnemyChef(X:int, Y:int, talkString:String)
		{
			super(X+6, Y+10, talkString);
			
			loadGraphic(ImgChars, true, true, 50,80);
						
			//animations
			
			addAnimation("idle", [5], 1, true);
			addAnimation("walk", [30,31,32,33,34,35], 10, true);
			addAnimation("talk", [5,58], 6, true);

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