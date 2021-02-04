package 
{
	import org.flixel.*;

	public class HelpOverlay extends FlxSprite
	{
		[Embed(source="../data/tutorial/helpButtonW.png")] private var ImgW:Class;
		[Embed(source="../data/tutorial/helpButtonF.png")] private var ImgF:Class;
		[Embed(source = "../data/tutorial/helpButtonM.png")] private var ImgM:Class;
				
		
		public function HelpOverlay(X:int,Y:int)
		{
			super(X, Y);
			
			if (Registry.levelType==1)
				loadGraphic(ImgW, true, false, 390, 50);
			else if (Registry.levelType==2)
				loadGraphic(ImgF, true, false, 390, 50);
			else if (Registry.levelType==3)
				loadGraphic(ImgM, true, false, 390, 50);
			else
				loadGraphic(ImgW, true, false, 390, 50);
				
			
			
			addAnimation("Idle", [0,1,2], 4 , false);
			
			play("Idle");
			
			
			
		}

		override public function update():void
		{
			super.update();

		}
	}
}