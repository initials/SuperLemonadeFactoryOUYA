package
{
	import org.flixel.*;
	import Math;
	
	public class EnemyWorker extends Enemy
	{
		[Embed(source="../data/chars_50x50.png")] private var ImgChars:Class;

		public function EnemyWorker(X:int, Y:int, talkString:String)
		{
			super(X+6, Y, talkString );
			
			loadGraphic(ImgChars, true, true, 50,80);
						
			//animations
			
			addAnimation("idle", [0], 1, true);
			addAnimation("walk", [18,19,20,21,22,23], 10, true);
			addAnimation("talk", [0, 53, 52, 54], 6, true);

			
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