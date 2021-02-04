
 
package 
{
	import org.flixel.*;

	public class Plant extends FlxSprite
	{
		[Embed(source = "../data/level3/plant1.png")] private var ImgPlant:Class;
		[Embed(source = "../data/level3/plant2.png")] private var ImgPlantAlt:Class;
		[Embed(source = "../data/level3/leaves.png")] private var ImgLeaves:Class;
		protected var _gibs:FlxEmitter; //leaves
		public var canLoseLeaves:Number;

		
		public function Plant(X:int,Y:int, type:int)
		{
			super(X, Y);
			if (type==1)
				loadGraphic(ImgPlant, false, false, 10, 110);	
			else if (type == 2)
				loadGraphic(ImgPlantAlt, false, false, 13, 100);
			
			_gibs = new FlxEmitter();
			_gibs.setSize(2, 110);
			_gibs.makeParticles(ImgLeaves, 15, 16, true, 0);
			_gibs.setRotation(0,360);
			_gibs.setYSpeed(15,85);
			_gibs.setXSpeed(-40,40);
			_gibs.gravity = 15;
			_gibs.at(this);
			//_gibs.start(false,0.5,0.01);
			canLoseLeaves = 110;
			

		}

		override public function update():void
		{
			
			canLoseLeaves += FlxG.elapsed;
			super.update();
			
			_gibs.update();
		}
		
		//Even though we updated the jets after we updated the Enemy,
		//we want to draw the jets below the Enemy, so we call _jets.draw() first.
		override public function draw():void
		{
			
			super.draw();
			_gibs.draw();
		}
		
		public function blowLeaves():void {
			if (canLoseLeaves > 10){
				_gibs.start(true, 4, 0.0000001);
				
				canLoseLeaves = 0;
				
			}
			
		}
		
	}
}