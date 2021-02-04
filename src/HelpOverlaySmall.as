package 
{
	import org.flixel.*;

	public class HelpOverlaySmall extends FlxSprite
	{
		[Embed(source="../data/tutorial/helpButtonWSmall.png")] private var ImgW:Class;
		[Embed(source="../data/tutorial/helpButtonFSmall.png")] private var ImgF:Class;
		[Embed(source = "../data/tutorial/helpButtonMSmall.png")] private var ImgM:Class;
				
		
		public function HelpOverlaySmall(X:int,Y:int)
		{
			super(X, Y);
			
			if (Registry.levelType==1)
				loadGraphic(ImgW, true, false, 256, 50);
			else if (Registry.levelType==2)
				loadGraphic(ImgF, true, false, 256, 50);
			else if (Registry.levelType==3)
				loadGraphic(ImgM, true, false, 256, 50);
			else
				loadGraphic(ImgW, true, false, 256, 50);
				
			
			
			addAnimation("Idle", [0,1,2], 4 , false);
			
			play("Idle");
			
			
			
		}

		override public function update():void
		{
			super.update();

		}
	}
}