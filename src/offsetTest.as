/*
 * Copyright (c) 2009 Initials Video Games
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 
 
 /*
 * offsetTest.as
 * Created On: 16/06/2012 8:08 PM
 */
 
package 
{
	import org.flixel.*;

	public class offsetTest extends FlxState
	{
		
		public var bg:FlxSprite;
		public var bg1:FlxSprite;
		
		override public function create():void
		{
			bg = new FlxSprite(20, 20);
			bg.makeGraphic(40, 40, 0xff4343e7, false);
			add(bg);
			
			bg1 = new FlxSprite(120, 120);
			bg1.makeGraphic(40, 40, 0xffFF0080, false);
			bg1.drag.x = 2022;
			bg1.drag.y = 2022;
			
			add(bg1);			
			
			
		}

		override public function update():void
		{
			var vel:Number = 40;
			if (FlxG.overlapWithOffset(bg, bg1, 60, 60))
				trace("Overlapping with offset");
				
			if (FlxG.overlap(bg, bg1))
				trace("Overlapping regular");				
				
			
			if (FlxG.joystick.j1Stick1LeftPressed)
				bg1.velocity.x -= vel;
			
			if (FlxG.joystick.j1Stick1RightPressed)
				bg1.velocity.x += vel;				
			
			if (FlxG.joystick.j1Stick1UpPressed)
				bg1.velocity.y -= vel;				
			
			if (FlxG.joystick.j1Stick1DownPressed)
				bg1.velocity.y += vel;				
			super.update();

		}
	}
}