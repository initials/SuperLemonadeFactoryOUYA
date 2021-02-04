package org.flixel.system.input
{
	/**
	 * A Flixel Wrapper for joyquery
	 * 
	 * @author Initials
	 */
	public class FlxJoystick
	{
			private var j1Button0Pressed:Boolean;
		private var j1Button1Pressed:Boolean;
		private var j1Button2Pressed:Boolean;
		private var j1Button3Pressed:Boolean;
		private var j1Button4Pressed:Boolean;		
		private var j1Button5Pressed:Boolean;
		private var j1Button6Pressed:Boolean;
		private var j1Button7Pressed:Boolean;
		private var j1Button8Pressed:Boolean;
		private var j1Button9Pressed:Boolean;
		
		private var j1Button0JustPressed:Boolean;
		private var j1Button1JustPressed:Boolean;
		private var j1Button2JustPressed:Boolean;
		private var j1Button3JustPressed:Boolean;
		private var j1Button4JustPressed:Boolean;		
		private var j1Button5JustPressed:Boolean;
		private var j1Button6JustPressed:Boolean;
		private var j1Button7JustPressed:Boolean;
		private var j1Button8JustPressed:Boolean;
		private var j1Button9JustPressed:Boolean;
		
		public var j1ButtonAPressed:Boolean;
		public var j1ButtonBPressed:Boolean;
		public var j1ButtonXPressed:Boolean;
		public var j1ButtonYPressed:Boolean;
		public var j1ButtonLBPressed:Boolean;		
		public var j1ButtonRBPressed:Boolean;
		public var j1ButtonBackPressed:Boolean;
		public var j1ButtonStartPressed:Boolean;
		public var j1ButtonLeftStickClickPressed:Boolean;
		public var j1ButtonRightStickClickPressed:Boolean;
		
		public var j1ButtonAJustPressed:Boolean;
		public var j1ButtonBJustPressed:Boolean;
		public var j1ButtonXJustPressed:Boolean;
		public var j1ButtonYJustPressed:Boolean;
		public var j1ButtonLBJustPressed:Boolean;		
		public var j1ButtonRBJustPressed:Boolean;
		public var j1ButtonBackJustPressed:Boolean;
		public var j1ButtonStartJustPressed:Boolean;
		public var j1ButtonLeftStickClickJustPressed:Boolean;
		public var j1ButtonRightStickClickJustPressed:Boolean;		
		
		public var j1Stick1X:Number;
		public var j1Stick1Y:Number;	
		/*
		 * The angle of the stick 1
		 */
		public var j1Stick1Angle:Number;
		
		public var j1Stick2X:Number;
		public var j1Stick2Y:Number;
		/*
		 * The angle of the stick 2
		 */
		public var j1Stick2Angle:Number;		
		public var j1Trigger:Number;
		
		public var j1Stick1DownPressed:Boolean;
		public var j1Stick1UpPressed:Boolean;
		public var j1Stick1LeftPressed:Boolean;
		public var j1Stick1RightPressed:Boolean;
		
		public var j1Stick1DownJustPressed:Boolean;
		public var j1Stick1UpJustPressed:Boolean;
		public var j1Stick1LeftJustPressed:Boolean;
		public var j1Stick1RightJustPressed:Boolean;	
		
		public var j1Stick2DownPressed:Boolean;
		public var j1Stick2UpPressed:Boolean;
		public var j1Stick2LeftPressed:Boolean;
		public var j1Stick2RightPressed:Boolean;
		
		public var j1Stick2DownJustPressed:Boolean;
		public var j1Stick2UpJustPressed:Boolean;
		public var j1Stick2LeftJustPressed:Boolean;
		public var j1Stick2RightJustPressed:Boolean;
		
		// JOYSTICK 2
		
		private var j2Button0Pressed:Boolean;
		private var j2Button1Pressed:Boolean;
		private var j2Button2Pressed:Boolean;
		private var j2Button3Pressed:Boolean;
		private var j2Button4Pressed:Boolean;		
		private var j2Button5Pressed:Boolean;
		private var j2Button6Pressed:Boolean;
		private var j2Button7Pressed:Boolean;
		private var j2Button8Pressed:Boolean;
		private var j2Button9Pressed:Boolean;
		
		private var j2Button0JustPressed:Boolean;
		private var j2Button1JustPressed:Boolean;
		private var j2Button2JustPressed:Boolean;
		private var j2Button3JustPressed:Boolean;
		private var j2Button4JustPressed:Boolean;		
		private var j2Button5JustPressed:Boolean;
		private var j2Button6JustPressed:Boolean;
		private var j2Button7JustPressed:Boolean;
		private var j2Button8JustPressed:Boolean;
		private var j2Button9JustPressed:Boolean;
		
		public var j2ButtonAPressed:Boolean;
		public var j2ButtonBPressed:Boolean;
		public var j2ButtonXPressed:Boolean;
		public var j2ButtonYPressed:Boolean;
		public var j2ButtonLBPressed:Boolean;		
		public var j2ButtonRBPressed:Boolean;
		public var j2ButtonBackPressed:Boolean;
		public var j2ButtonStartPressed:Boolean;
		public var j2ButtonLeftStickClickPressed:Boolean;
		public var j2ButtonRightStickClickPressed:Boolean;
		
		public var j2ButtonAJustPressed:Boolean;
		public var j2ButtonBJustPressed:Boolean;
		public var j2ButtonXJustPressed:Boolean;
		public var j2ButtonYJustPressed:Boolean;
		public var j2ButtonLBJustPressed:Boolean;		
		public var j2ButtonRBJustPressed:Boolean;
		public var j2ButtonBackJustPressed:Boolean;
		public var j2ButtonStartJustPressed:Boolean;
		public var j2ButtonLeftStickClickJustPressed:Boolean;
		public var j2ButtonRightStickClickJustPressed:Boolean;	
		
		public var j2Stick1X:Number;
		public var j2Stick1Y:Number;		
		public var j2Stick2X:Number;
		public var j2Stick2Y:Number;
		public var j2Trigger:Number;
		
		/*
		 * The angle of the stick 1
		 */
		public var j2Stick1Angle:Number;
		/*
		 * The angle of the stick 2
		 */
		public var j2Stick2Angle:Number;		
		
		public var j2Stick1DownPressed:Boolean;
		public var j2Stick1UpPressed:Boolean;
		public var j2Stick1LeftPressed:Boolean;
		public var j2Stick1RightPressed:Boolean;
		
		public var j2Stick1DownJustPressed:Boolean;
		public var j2Stick1UpJustPressed:Boolean;
		public var j2Stick1LeftJustPressed:Boolean;
		public var j2Stick1RightJustPressed:Boolean;	
		
		public var j2Stick2DownPressed:Boolean;
		public var j2Stick2UpPressed:Boolean;
		public var j2Stick2LeftPressed:Boolean;
		public var j2Stick2RightPressed:Boolean;
		
		public var j2Stick2DownJustPressed:Boolean;
		public var j2Stick2UpJustPressed:Boolean;
		public var j2Stick2LeftJustPressed:Boolean;
		public var j2Stick2RightJustPressed:Boolean;	
		
		public function FlxJoystick()
		{
			//super();
		}
		
		public function update():void
		{
			
		}
	}
}
//package org.flixel.system.input
//{
	//import flash.display.Sprite;
	//import flash.display.StageAlign;
	//import flash.display.StageScaleMode;
	//import flash.events.Event;
	//import flash.events.GameInputEvent;
	//import flash.text.TextField;
	//import flash.ui.GameInput;
	//import flash.ui.GameInputControl;
	//import flash.ui.GameInputDevice;
	//import flash.utils.ByteArray;
	//import flash.utils.Timer;
	//
	//import org.flixel.*;
	//
	 //
	//public class FlxJoystick
	//{
		//private var j1Button0Pressed:Boolean;
		//private var j1Button1Pressed:Boolean;
		//private var j1Button2Pressed:Boolean;
		//private var j1Button3Pressed:Boolean;
		//private var j1Button4Pressed:Boolean;		
		//private var j1Button5Pressed:Boolean;
		//private var j1Button6Pressed:Boolean;
		//private var j1Button7Pressed:Boolean;
		//private var j1Button8Pressed:Boolean;
		//private var j1Button9Pressed:Boolean;
		//
		//private var j1Button0JustPressed:Boolean;
		//private var j1Button1JustPressed:Boolean;
		//private var j1Button2JustPressed:Boolean;
		//private var j1Button3JustPressed:Boolean;
		//private var j1Button4JustPressed:Boolean;		
		//private var j1Button5JustPressed:Boolean;
		//private var j1Button6JustPressed:Boolean;
		//private var j1Button7JustPressed:Boolean;
		//private var j1Button8JustPressed:Boolean;
		//private var j1Button9JustPressed:Boolean;
		//
		//public var j1ButtonAPressed:Boolean;
		//public var j1ButtonBPressed:Boolean;
		//public var j1ButtonXPressed:Boolean;
		//public var j1ButtonYPressed:Boolean;
		//public var j1ButtonLBPressed:Boolean;		
		//public var j1ButtonRBPressed:Boolean;
		//public var j1ButtonBackPressed:Boolean;
		//public var j1ButtonStartPressed:Boolean;
		//public var j1ButtonLeftStickClickPressed:Boolean;
		//public var j1ButtonRightStickClickPressed:Boolean;
		//
		//public var j1ButtonAJustPressed:Boolean;
		//public var j1ButtonBJustPressed:Boolean;
		//public var j1ButtonXJustPressed:Boolean;
		//public var j1ButtonYJustPressed:Boolean;
		//public var j1ButtonLBJustPressed:Boolean;		
		//public var j1ButtonRBJustPressed:Boolean;
		//public var j1ButtonBackJustPressed:Boolean;
		//public var j1ButtonStartJustPressed:Boolean;
		//public var j1ButtonLeftStickClickJustPressed:Boolean;
		//public var j1ButtonRightStickClickJustPressed:Boolean;		
		//
		//public var j1Stick1X:Number;
		//public var j1Stick1Y:Number;	
		///*
		 //* The angle of the stick 1
		 //*/
		//public var j1Stick1Angle:Number;
		//
		//public var j1Stick2X:Number;
		//public var j1Stick2Y:Number;
		///*
		 //* The angle of the stick 2
		 //*/
		//public var j1Stick2Angle:Number;		
		//public var j1Trigger:Number;
		//
		//public var j1Stick1DownPressed:Boolean;
		//public var j1Stick1UpPressed:Boolean;
		//public var j1Stick1LeftPressed:Boolean;
		//public var j1Stick1RightPressed:Boolean;
		//
		//public var j1Stick1DownJustPressed:Boolean;
		//public var j1Stick1UpJustPressed:Boolean;
		//public var j1Stick1LeftJustPressed:Boolean;
		//public var j1Stick1RightJustPressed:Boolean;	
		//
		//public var j1Stick2DownPressed:Boolean;
		//public var j1Stick2UpPressed:Boolean;
		//public var j1Stick2LeftPressed:Boolean;
		//public var j1Stick2RightPressed:Boolean;
		//
		//public var j1Stick2DownJustPressed:Boolean;
		//public var j1Stick2UpJustPressed:Boolean;
		//public var j1Stick2LeftJustPressed:Boolean;
		//public var j1Stick2RightJustPressed:Boolean;
		//
		// JOYSTICK 2
		//
		//private var j2Button0Pressed:Boolean;
		//private var j2Button1Pressed:Boolean;
		//private var j2Button2Pressed:Boolean;
		//private var j2Button3Pressed:Boolean;
		//private var j2Button4Pressed:Boolean;		
		//private var j2Button5Pressed:Boolean;
		//private var j2Button6Pressed:Boolean;
		//private var j2Button7Pressed:Boolean;
		//private var j2Button8Pressed:Boolean;
		//private var j2Button9Pressed:Boolean;
		//
		//private var j2Button0JustPressed:Boolean;
		//private var j2Button1JustPressed:Boolean;
		//private var j2Button2JustPressed:Boolean;
		//private var j2Button3JustPressed:Boolean;
		//private var j2Button4JustPressed:Boolean;		
		//private var j2Button5JustPressed:Boolean;
		//private var j2Button6JustPressed:Boolean;
		//private var j2Button7JustPressed:Boolean;
		//private var j2Button8JustPressed:Boolean;
		//private var j2Button9JustPressed:Boolean;
		//
		//public var j2ButtonAPressed:Boolean;
		//public var j2ButtonBPressed:Boolean;
		//public var j2ButtonXPressed:Boolean;
		//public var j2ButtonYPressed:Boolean;
		//public var j2ButtonLBPressed:Boolean;		
		//public var j2ButtonRBPressed:Boolean;
		//public var j2ButtonBackPressed:Boolean;
		//public var j2ButtonStartPressed:Boolean;
		//public var j2ButtonLeftStickClickPressed:Boolean;
		//public var j2ButtonRightStickClickPressed:Boolean;
		//
		//public var j2ButtonAJustPressed:Boolean;
		//public var j2ButtonBJustPressed:Boolean;
		//public var j2ButtonXJustPressed:Boolean;
		//public var j2ButtonYJustPressed:Boolean;
		//public var j2ButtonLBJustPressed:Boolean;		
		//public var j2ButtonRBJustPressed:Boolean;
		//public var j2ButtonBackJustPressed:Boolean;
		//public var j2ButtonStartJustPressed:Boolean;
		//public var j2ButtonLeftStickClickJustPressed:Boolean;
		//public var j2ButtonRightStickClickJustPressed:Boolean;	
		//
		//public var j2Stick1X:Number;
		//public var j2Stick1Y:Number;		
		//public var j2Stick2X:Number;
		//public var j2Stick2Y:Number;
		//public var j2Trigger:Number;
		//
		///*
		 //* The angle of the stick 1
		 //*/
		//public var j2Stick1Angle:Number;
		///*
		 //* The angle of the stick 2
		 //*/
		//public var j2Stick2Angle:Number;		
		//
		//public var j2Stick1DownPressed:Boolean;
		//public var j2Stick1UpPressed:Boolean;
		//public var j2Stick1LeftPressed:Boolean;
		//public var j2Stick1RightPressed:Boolean;
		//
		//public var j2Stick1DownJustPressed:Boolean;
		//public var j2Stick1UpJustPressed:Boolean;
		//public var j2Stick1LeftJustPressed:Boolean;
		//public var j2Stick1RightJustPressed:Boolean;	
		//
		//public var j2Stick2DownPressed:Boolean;
		//public var j2Stick2UpPressed:Boolean;
		//public var j2Stick2LeftPressed:Boolean;
		//public var j2Stick2RightPressed:Boolean;
		//
		//public var j2Stick2DownJustPressed:Boolean;
		//public var j2Stick2UpJustPressed:Boolean;
		//public var j2Stick2LeftJustPressed:Boolean;
		//public var j2Stick2RightJustPressed:Boolean;	
		//
		//private var gameInput:GameInput;
		//private var _device:GameInputDevice;
		//private var ba:ByteArray;
		//
		//
		//public function FlxJoystick()
		//{
			//super();
			//
			//ba = new ByteArray();
			//
			//gameInput = new GameInput();
			//gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, handleDeviceAttached);
			//gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, handleDeviceRemoved);
			//
			//FlxG.log("start joystick");
		//}
		//
		//public function update():void
		//{
			//
			//
			//FlxG.log("Ok joystick");
		//}
		//
		//protected function handleDeviceRemoved(event:GameInputEvent):void
		//{
			//tf.appendText("Device is removed\n");
			//FlxG.log("Device is removed");
			//
		//}
		//
		//protected function handleDeviceAttached(e:GameInputEvent):void
		//{
			//FlxG.log("Device is added\n");
			//
			//
			//GameInputControlName.initialize(e.device);
			//
			//
			//for(var k:Number=0;k<GameInput.numDevices;k++){
				//_device = GameInput.getDeviceAt(k);
				//var _controls:Vector.<String> = new Vector.<String>;
				//_device.enabled = true;
				//
				//for (var i:Number = 0; i < _device.numControls; i++) {
					//var control:GameInputControl = _device.getControlAt(i);
					//control.addEventListener(Event.CHANGE,onChange);
					//_controls[i] = control.id;
				//}
				//
				//_device.startCachingSamples(30, _controls);
				//
				//
			//}
			//
			//for(var j:int=0; j<_controls.length; j++)
			//{
				//FlxG.log(_controls[j]);
			//}
			//
			//FlxG.stage.addEventListener(Event.ENTER_FRAME, getCachedSamples);
			//
		//}	
		//
		//protected function onChange(event:Event):void
		//{
			//var control:GameInputControl = event.target as GameInputControl;
			//
			//FlxG.log("The pressed control is " +control.name+" with value "+control.value+" \n");
		//}
		//
		//protected function getCachedSamples(event:Event):void
		//{
			//var data:ByteArray = new ByteArray();
			//var _device:GameInputDevice;
			//_device = GameInput.getDeviceAt(0);
			//
			//try
			//{
				//var completed:int = _device.getCachedSamples(data, true);
			//} 
			//catch(e:Error)
			//{
				//FlxG.log("FAIL \n");
			//}
			//
			//if(completed > 0 && data.length > 0)
			//{
				//
				//FlxG.log("Number of samples are "+completed+" and byte length is "+data.length+" \n");
			//}
		//}
		//
		//
		//
	//}
//}