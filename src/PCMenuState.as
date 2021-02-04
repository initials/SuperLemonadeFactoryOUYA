package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	import flash.net.FileReference;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.net.URLLoaderDataFormat;    
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.AIROUYAIAPANE;
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.AIROUYAIAPANEEvent;
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.Gamer;
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.Product;
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.Purchase;
	import com.gaslightgames.nativeExtensions.AIROUYAIAPANE.Receipt;
		

	
	
	public class PCMenuState extends FlxState
	{
		[Embed(source = "../data/largeCrate.png")] private var ImgLargeCrate:Class;
		[Embed(source = "../data/level1/palettes.png")] private var ImgPalettes:Class;
		[Embed(source = "../data/smallCrate.png")] private var ImgSmallCrate:Class;
		[Embed(source = "../data/smallSugarBag.png")] private var ImgSmallSugarBag:Class;
		[Embed(source = "../data/sodaPack.png")] private var ImgSodaPack:Class;
		[Embed(source = "../data/sugarBags.png")] private var ImgSugarBags:Class;
		[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;		
		[Embed(source = "../data/bubble.png")] private var ImgLeaves:Class;
		
		[Embed(source = "../data/level1/sugarBagsAndCrates.png")] private var ImgSugarBagsAndCrate:Class;
		[Embed(source = "../data/level1/L1_Shelf.png")] private var ImgShelf:Class;
		
		[Embed(source = "../data/sfx_128/ping.mp3")] protected var SndPing:Class;		
		[Embed(source = "../data/sfx_128/ping2.mp3")] protected var SndPing2:Class;		
		
		[Embed(source = '../data/SLF_levelEditor/level1.oel', mimeType = 'application/octet-stream')] private var Level1:Class;
		
		private var loader:URLLoader;
		
		
		//	Test specific variables
		private var slide:CenterSlideFX;
		private var scratch:FlxSprite;
		private var glitchAmount:int;
		
		public var ground:FlxTilemap;
		
		public var collideGroup:FlxGroup;
		
		public var buttonsGroup:FlxGroup;
		
		public var playBtn:FlxButton ;
		public var optionsBtn:FlxButton ;
		public var helpBtn:FlxButton ;
		public var creditsBtn:FlxButton ;
		public var customBtn:FlxButton ;
		public var oldSchoolBtn:FlxButton ;
		
		public var txtLevel:FlxText;
		public var txtPlayersNo:FlxText;
		
		private var _bubbles:FlxEmitter;
		
		public var ping:FlxSound;
		public var ping2:FlxSound;
		
		private var bgBags:FlxSprite;
		private var bgShelf:FlxSprite;
		
		private var versionText:FlxText ;
		private var latestText:FlxText ;
		
		
		private var buttonEmitter:FlxEmitter;
		
		private var ouyaIap:AIROUYAIAPANE;
		
		private var buytimer:Number;
		
		private var headingTxt:FlxText;
		
		private var canProceed:Boolean;
		
		override public function create():void
		{
			canProceed = false;
			buytimer = 10.0;
			
			Registry.oldSchoolMode = false;
			
			ping = new FlxSound();
			ping.loadEmbedded(Registry.SndBlip);
			ping.volume = 0.5;
			
			ping2 = new FlxSound();
			ping2.loadEmbedded(Registry.SndPing);			
			
			FlxG.playMusic(Registry.SndEcho, 1.0);
			
			FlxG.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:FlxSprite = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, [0xffcac5ac, 0xffdedbc3 , 0xffdfdcc4], 10 ); //0xffd6d3ba
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			//Bubbles
			var gibs:FlxEmitter = new FlxEmitter(0,FlxG.height);
			gibs.setSize(FlxG.width,0);
			gibs.setXSpeed(-15,15);
			gibs.setYSpeed(-5,-20);
			gibs.setRotation(0,0);
			gibs.gravity = -20;
			gibs.makeParticles(ImgLeaves,50,8,true,0);
			add(gibs);
			gibs.start(false, 0, 0.75);	
			
			bgBags = new FlxSprite(60, 0, ImgSugarBagsAndCrate);
			bgBags.y = FlxG.height - bgBags.height;
			add(bgBags);
			
			bgShelf = new FlxSprite(110, 110, ImgShelf);
			bgShelf.x = FlxG.width - bgShelf.width;			
			bgShelf.y = FlxG.height - bgShelf.height;
			add(bgShelf);			
			
			//	Test specific
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			var pic:FlxSprite = new FlxSprite(0, 0, Registry.ImgLogo);
			
			//	Create the Slide FX
			slide = FlxSpecialFX.centerSlide();
			
			//	Here we'll create it from an embedded PNG, positioned at 0,0 and it'll do a vertical reveal to start with
			pic = slide.createFromClass(Registry.ImgLogo, 0, 0, CenterSlideFX.REVEAL_VERTICAL);
			pic.x = FlxG.width / 2 - pic.width / 2;
			pic.y = (FlxG.height / 2 - pic.height / 2 ) - 100;
			
			add(pic);
			
			slide.start();
			
			if (Registry.mouseEnabled)
				FlxG.mouse.show();
			else
				FlxG.mouse.hide();
			
			buttonsGroup = new FlxGroup();
			
			playBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 20 , "Play", this.onLevelSelect);
			playBtn.soundOver = ping;
			playBtn.soundDown = ping2;
			playBtn.color = 0xC082FF;
			playBtn.label.color = 0xffffff;
			buttonsGroup.add(playBtn);
			
			playBtn.highlightedText = "Factory Floor";
			
			playBtn.status = FlxButton.HIGHLIGHT;
			
			optionsBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 10, "options", this.onOptions );
			optionsBtn.soundOver = ping;
			optionsBtn.soundDown = ping2;
			optionsBtn.color = 0xC082FF;
			optionsBtn.label.color = 0xffffff;
			buttonsGroup.add(optionsBtn);	
			optionsBtn.highlightedText = "Output Ratio";

			helpBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 40, "help", this.onHelp);
			helpBtn.soundOver = ping;
			helpBtn.soundDown = ping2;			
			helpBtn.color = 0xC082FF;
			helpBtn.label.color = 0xffffff;
			buttonsGroup.add(helpBtn);			
			helpBtn.highlightedText = "Customer Service";

			creditsBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 70, "credits", this.onCredits);
			creditsBtn.soundOver = ping;
			creditsBtn.soundDown = ping2;
			creditsBtn.color = 0xC082FF;
			creditsBtn.label.color = 0xffffff;
			buttonsGroup.add(creditsBtn);
			creditsBtn.highlightedText = "Ingredients";
			
			
			customBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 100, "BUY GAME", this.buy);
			customBtn.soundOver = ping;
			customBtn.soundDown = ping2;
			customBtn.color = 0xC082FF;
			customBtn.label.color = 0xffffff;
			
			
			//oldSchoolBtn = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 130, "old school", this.onOldSchool);
			//oldSchoolBtn.soundOver = ping;
			//oldSchoolBtn.soundDown = ping2;
			//oldSchoolBtn.color = 0xC082FF;
			//oldSchoolBtn.label.color = 0xffffff;
			//buttonsGroup.add(oldSchoolBtn);
			//oldSchoolBtn.highlightedText = "3 Lives";
			
			add(buttonsGroup);
			
			var save:FlxSave = new FlxSave();
			if(save.bind("SLF"))
			{
				// Register defaults for level progress.
				
				var ar1:Array = new Array("wh   ", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar2:Array = new Array("fc   ", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar3:Array = new Array("mgmt ", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar4:Array = new Array("xwh  ", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar5:Array = new Array("xfc  ", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar6:Array = new Array("xmgmt", "1", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsComplete == null) 
					save.data.warehouseLevelsComplete = ar1 as Array;
				if(save.data.factoryLevelsComplete == null) 
					save.data.factoryLevelsComplete = ar2 as Array;
				if(save.data.mgmtLevelsComplete == null) 
					save.data.mgmtLevelsComplete = ar3 as Array;
				if(save.data.hcwarehouseLevelsComplete == null) 
					save.data.hcwarehouseLevelsComplete = ar4 as Array;
				if(save.data.hcfactoryLevelsComplete == null) 
					save.data.hcfactoryLevelsComplete = ar5 as Array;
				if(save.data.hcmgmtLevelsComplete == null) 
					save.data.hcmgmtLevelsComplete = ar6 as Array;
					
				//register defaults for talking progress
					
				var tar1:Array = new Array("wh-talk   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar2:Array = new Array("fc-talk   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar3:Array = new Array("mgmt-talk ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar4:Array = new Array("xwh-talk  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar5:Array = new Array("xfc-talk  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar6:Array = new Array("xmgmt-talk", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsTalk == null) 
					save.data.warehouseLevelsTalk = tar1 as Array;
				if(save.data.factoryLevelsTalk == null) 
					save.data.factoryLevelsTalk= tar2 as Array;
				if(save.data.mgmtLevelsTalk == null) 
					save.data.mgmtLevelsTalk = tar3 as Array;
				if(save.data.hcwarehouseLevelsTalk == null) 
					save.data.hcwarehouseLevelsTalk = tar4 as Array;
				if(save.data.hcfactoryLevelsTalk == null) 
					save.data.hcfactoryLevelsTalk = tar5 as Array;
				if(save.data.hcmgmtLevelsTalk == null) 
					save.data.hcmgmtLevelsTalk = tar6 as Array;					

					
				//register defaults for talking t0 Andre progress
					
				var taar1:Array = new Array("wh-talk-andre   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar2:Array = new Array("fc-talk-andre   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar3:Array = new Array("mgmt-talk-andre ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar4:Array = new Array("xwh-talk-andre  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar5:Array = new Array("xfc-talk-andre  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar6:Array = new Array("xmgmt-talk-andre", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsTalkAndre == null) 
					save.data.warehouseLevelsTalkAndre = taar1 as Array;
				if(save.data.factoryLevelsTalkAndre == null) 
					save.data.factoryLevelsTalkAndre= taar2 as Array;
				if(save.data.mgmtLevelsTalkAndre == null) 
					save.data.mgmtLevelsTalkAndre = taar3 as Array;
				if(save.data.hcwarehouseLevelsTalkAndre == null) 
					save.data.hcwarehouseLevelsTalkAndre = taar4 as Array;
				if(save.data.hcfactoryLevelsTalkAndre == null) 
					save.data.hcfactoryLevelsTalkAndre = taar5 as Array;
				if(save.data.hcmgmtLevelsTalkAndre == null) 
					save.data.hcmgmtLevelsTalkAndre = taar6 as Array;	
					
					
				// register defaults for caps
				
				var car1:Array = new Array("whcap   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car2:Array = new Array("fccap   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car3:Array = new Array("mgmtcap ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car4:Array = new Array("xwhcap  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car5:Array = new Array("xfccap  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car6:Array = new Array("xmgmtcap", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseCap == null) 
					save.data.warehouseCap = car1 as Array;
				if(save.data.factoryCap == null) 
					save.data.factoryCap = car2 as Array;
				if(save.data.mgmtCap == null) 
					save.data.mgmtCap = car3 as Array;
				if(save.data.hcwarehouseCap == null) 
					save.data.hcwarehouseCap = car4 as Array;
				if(save.data.hcfactoryCap == null) 
					save.data.hcfactoryCap = car5 as Array;
				if(save.data.hcmgmtCap == null) 
					save.data.hcmgmtCap = car6 as Array;
					
				if(save.data.plays == null) 
					save.data.plays = 0 as Number;
					
				else
					save.data.plays++;
					
				//FlxG.log("Number of plays:       " + save.data.plays );
				//save.erase();
				save.close();
			}
			
			headingTxt = new FlxText(FlxG.width/2 - 40 , FlxG.height-50, FlxG.width/2, "", true);
			headingTxt.color = 0x8000FF;
			headingTxt.size = 8;
			headingTxt.alignment = "left";
			add(headingTxt);
			
			if (Registry.DEMO) {
				headingTxt.text = "--DEMO MODE--\n" + headingTxt.text;
				
				buttonsGroup.add(customBtn);
			}
			else
			{
				headingTxt.text = "--FULL GAME UNLOCKED--\n" + headingTxt.text;
				
			}
			
/*			loader = new URLLoader;
			loader.load( new URLRequest( "http://superlemonadefactory.initialsgames.com/log.xml" ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );*/
			
			//Get the version number
			var xml : XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns : Namespace = xml.namespace();
			var version : String = xml.ns::versionNumber;
			Registry.version = version;
			////FlxG.log("Version " + version);
			
			versionText = new FlxText(-60 , FlxG.height-34, FlxG.width, "", true);
			versionText.color = 0x8000FF;
			versionText.size = 8;
			versionText.alignment = "right";
			versionText.text = "Version: " + version;
			add(versionText);	
			
			//latestText = new FlxText(0 , FlxG.height-22, FlxG.width, Registry.newVersionText, true);
/*			latestText = new FlxText(0 , FlxG.height-22, FlxG.width, "", true);
			latestText.color = 0x8000FF;
			latestText.size = 8;
			latestText.alignment = "right";
			add(latestText);	*/		
			
			FlxG.ouyaController.o.reset();
			
			buttonEmitter = new FlxEmitter(0,FlxG.height);
			buttonEmitter.setSize(80,20);
			buttonEmitter.setXSpeed(-15,15);
			buttonEmitter.setYSpeed(-15,15);
			buttonEmitter.setRotation(0,0);
			buttonEmitter.gravity = 0;
			buttonEmitter.makeParticles(ImgLeaves,12,8,true,0);
			add(buttonEmitter);
			buttonEmitter.start(false, 0.25, 0.02);	
			
			if (Registry.DEMO)
				check();
			
			
			
			
			
			
			
			
			// TURN OFF
			
			
			//if ( FlxG.debug) FlxG.showDebugger();
			
			
		}

		override public function update():void
		{
			
			
			
			buytimer += FlxG.elapsed;
			
			if (!fading && !FlxG.mouse.visible )
				this.handleButtons();

			
			//FlxG.collide(collideGroup,ground);
			
			super.update();
			
			//latestText.text = Registry.newVersionText;
			
		}
		
		
		public function handleButtons():void {
			if (FlxG.keys.justPressed(Registry.p1Down)  || FlxG.joystick.j1Stick1DownJustPressed ) {
				currentButton++;
				FlxG.play(Registry.SndBlip, 0.3);
				
			}
			
			else if (FlxG.keys.justPressed(Registry.p1Up) || FlxG.joystick.j1Stick1UpJustPressed ) {
				currentButton--;
				FlxG.play(Registry.SndBlip, 0.3);
			}
			
			if (FlxG.keys.justPressed(Registry.p1Action) || FlxG.ouyaController.o.pressed || FlxG.keys.justPressed(Registry.p1Switch) || FlxG.keys.justPressed(Registry.p1Jump) || FlxG.joystick.j1ButtonAJustPressed  ) {
				FlxG.play(Registry.SndPing, Registry.pingVolume);
				if (currentButton<4)
					this.beginFade();
				else if (currentButton == 4)
				{
					//FlxG.switchState(new OuyaBuy());
					
					//this.beginFade();
					
					if (buytimer>2.0) {
						this.buy();
					}
						
				}
				else if (currentButton == 5 && Registry.DEMO == true)
				{
					headingTxt.text = "PURCHASE GAME TO PLAY OLD SCHOOL MODE";
				}
				else if (currentButton == 5 && Registry.DEMO == false)
				{
					this.beginFade();
				}
					
			}
			
			if (currentButton < 0) {
				currentButton = buttonsGroup.length-1;
			}
			else if (currentButton > buttonsGroup.length-1) {
				currentButton = 0;
			}
			
			
			for (var i:int = 0; i < buttonsGroup.length; i++) 
			{ 
				if (i == currentButton) 
				{
					(buttonsGroup.members[i] as FlxButton).status = FlxButton.HIGHLIGHT;
					buttonEmitter.at(buttonsGroup.members[i]);
					
				}
				else 
				{
					(buttonsGroup.members[i] as FlxButton).status = FlxButton.NORMAL;
				}
			}
		}
		
		protected function beginFade():void
		{
			fading = true;
			FlxG.fade(0xff000000, 0.4, completeFade);
			
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PRODUCT, onProduct );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PURCHASE, onPurchase );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceipt );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.GAMER, onGamer );
		}
		
		protected function completeFade():void
		{
			switch(currentButton) {
				case 0:
					Registry.oldSchoolMode = false;
					FlxG.switchState(new PCLevelSelectState());
					break;
				case 1:
					FlxG.switchState(new PCOptionsState());
					break;		
				case 2:
					FlxG.switchState(new PCHelpState());
					break;
				case 3:
					FlxG.switchState(new PCCreditsState());
					break;	
				case 4:
					//FlxG.switchState(new OuyaBuy());
					
					this.buy();
					
					break;			
				case 5:
					if (Registry.DEMO == true)
					{
						headingTxt.text = "";
					}
					else 
					{
						FlxG.playMusic(Registry.SndMega, 1.0);
						Registry.oldSchoolLivesF = 3;
						Registry.oldSchoolLivesM = 3;
						//Registry.restartMusic = true;
						Registry.oldSchoolMode = true;
						Registry.level = XML(new Registry.Level1);
						Registry.levelType = 1;
						Registry.levelNumber = 1;
						Registry.hardCore = false;
						FlxG.switchState(new PCPlayState());
					}
					break;						
			}
		}		
		
		public function onLevelSelect():void 
		{
			//FlxG.switchState(new PCLevelSelectState());
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 0;
		}
		
		public function onOptions():void 
		{
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 1;
		}
		
		public function onHelp():void 
		{
			//FlxG.switchState(new PCHelpState());
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 2;
		}
		
		public function onCredits():void 
		{
			//FlxG.switchState(new PCCreditsState());
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 3;
		}		
		
		public function onCustom():void 
		{
			//FlxG.switchState(new PCCustomLevelState());
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 4;
		}		
		
		public function onOldSchool():void 
		{
			//FlxG.switchState(new PCCustomLevelState());
			FlxG.fade(0xff000000, 0.4, completeFade);
			currentButton = 5;
		}	
		
		override public function destroy():void
		{
			
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			
			super.destroy();
		}
		
		
		
		private function check():void
		{
			//FlxG.log("-------------checking--------------? : "  + buytimer);
			//if (buytimer < 0.25) return;
			
			buytimer = 0;
			  
			var urlRequest:URLRequest = new URLRequest( "key.der" );        // Needs to be in your bin directory!
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, onKeyLoadx );
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load( urlRequest );
			
		}
		private function onKeyLoadx( event:Event ):void
		{
			//currentButton = 0;
			
			//FlxG.log(" ON KEY LOADx ");
			
			( event.target as URLLoader ).removeEventListener( Event.COMPLETE, onKeyLoad );
			
			// Get the Key data - as a ByteArray so we can pass it to the ANE
			var key:ByteArray = ( event.target as URLLoader ).data as ByteArray;
			key.endian = Endian.LITTLE_ENDIAN;
			
			// Simple way to read the values and make sure your key matches.
			this.checkKey( key );
			
			this.ouyaIap = AIROUYAIAPANE.getInstance( "1524df9e-c5bf-426d-86e9-2194298858c6", key, true );

			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceiptx );

			this.ouyaIap.getProductInfo( "SLF" );						// You will need a product on OUYAs server! Not yet updated to new ODK
			this.ouyaIap.getGamerUUID();
			
			this.ouyaIap.getProductReceipts();
		}
		private function onReceiptx( iapEvent:AIROUYAIAPANEEvent ):void
		{
			canProceed = true;
			//trace( "Receipt Received: " + iapEvent.status );
			
			//FlxG.log(" receipt xxx") ;
			
			var receipt:Receipt = iapEvent.data as Receipt;
			if( null != receipt )
			{
				//FlxG.log( "Receipt Received: " + receipt.identifier + ", " + receipt.price + ", " + receipt.generatedDate + ", " + receipt.purchasedDate );
				Registry.DEMO = false;
				
				headingTxt.text = "--FULL GAME UNLOCKED--";
				
				customBtn.kill();
				
				var save:FlxSave = new FlxSave();
				if(save.bind("SLF"))
				{
					save.data.buy = "1"; 
					
					var c:Array = new Array;
					var c1:Array = new Array;
					var c2:Array = new Array;
					//var c3:Array = new Array;
					
					for (var i2:int = 3; i2 < 13; i2++) 
					{
						c = save.data.warehouseLevelsComplete;
						c[i2] = "1";
						save.data.warehouseLevelsComplete = c;
						
						c1 = save.data.mgmtLevelsComplete;
						c1[i2] = "1";
						save.data.mgmtLevelsComplete = c1;
						
						c2 = save.data.factoryLevelsComplete;
						c2[i2] = "1";
						save.data.factoryLevelsComplete = c2;
					}
					
					save.close();
				}
				
				FlxG.switchState(new PCMenuState());
				
				
			}
			else
			{
				//FlxG.log( "---no buys--- " );
			}
		}
		
		
		
		
		
		
		
		
		private function buy():void
		{
			//FlxG.log("-------------BUYING-------------- buyTimer? : "  + buytimer);
			//if (buytimer < 0.25) return;
			
			buytimer = 0;
			  
			var urlRequest:URLRequest = new URLRequest( "key.der" );        // Needs to be in your bin directory!
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, onKeyLoad );
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load( urlRequest );
			
		}
		
		private function onKeyLoad( event:Event ):void
		{
			//currentButton = 0;
			
			//FlxG.log(" ON KEY LOAD ");
			
			( event.target as URLLoader ).removeEventListener( Event.COMPLETE, onKeyLoad );
			
			// Get the Key data - as a ByteArray so we can pass it to the ANE
			var key:ByteArray = ( event.target as URLLoader ).data as ByteArray;
			key.endian = Endian.LITTLE_ENDIAN;
			
			// Simple way to read the values and make sure your key matches.
			this.checkKey( key );
			
			this.ouyaIap = AIROUYAIAPANE.getInstance( "1524df9e-c5bf-426d-86e9-2194298858c6", key, true );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.PRODUCT, onProduct );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.PURCHASE, onPurchase );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceipt );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.GAMER, onGamer );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.CANCEL, onCancel );
			this.ouyaIap.getProductInfo( "SLF" );						// You will need a product on OUYAs server! Not yet updated to new ODK
			this.ouyaIap.getGamerUUID();
		}
		
		private function onCancel( iapEvent:AIROUYAIAPANEEvent):void
		{
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PRODUCT, onProduct );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PURCHASE, onPurchase );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceipt );
			this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.GAMER, onGamer );
		}
		
		private function onProduct( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var product:Product = iapEvent.data as Product;
			if( null != product )
			{
				//FlxG.log( "Product Received: " + product.identifier + ", " + product.name + ", " + product.price );
				
				this.ouyaIap.makeProductPurchase( product );
			}
		}
		
		private function onPurchase( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var purchase:Purchase = iapEvent.data as Purchase;
			if( null != purchase )
			{
				//FlxG.log( "Purchase Made: " + purchase.identifier + ", " + purchase.name + ", " + purchase.price );
				
				this.ouyaIap.getProductReceipts();									// This call only works on ENTITLEMENTS!  Make sure you've bought one first to see a receipt.
			}
		}
		
		private function onReceipt( iapEvent:AIROUYAIAPANEEvent ):void
		{
			//trace( "Receipt Received: " + iapEvent.status );
			
			var receipt:Receipt = iapEvent.data as Receipt;
			if( null != receipt )
			{
				//FlxG.log( "Receipt Received: " + receipt.identifier + ", " + receipt.price + ", " + receipt.generatedDate + ", " + receipt.purchasedDate );
				Registry.DEMO = false;
				
				headingTxt.text = "--FULL GAME UNLOCKED--";
				
				var save:FlxSave = new FlxSave();
				if(save.bind("SLF"))
				{
					save.data.buy = "1"; 
					
					var c:Array = new Array;
					var c1:Array = new Array;
					var c2:Array = new Array;
					//var c3:Array = new Array;
					
					for (var i2:int = 3; i2 < 13; i2++) 
					{
						c = save.data.warehouseLevelsComplete;
						c[i2] = "1";
						save.data.warehouseLevelsComplete = c;
						
						c1 = save.data.mgmtLevelsComplete;
						c1[i2] = "1";
						save.data.mgmtLevelsComplete = c1;
						
						c2 = save.data.factoryLevelsComplete;
						c2[i2] = "1";
						save.data.factoryLevelsComplete = c2;
					}
					
					save.close();
				}
				
			}
		}
		
		private function onGamer( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var gamer:Gamer = iapEvent.data as Gamer;
			if( null != gamer )
			{
				//FlxG.log( "Gamer UUID Received: " + gamer.udid );
				
			}
		}
		
		private function checkKey( key:ByteArray ):void
		{
			key.position = 0;
			var keyStr:String = "";
			while( key.bytesAvailable )
			{
				var byte:uint = key.readUnsignedByte();
				keyStr += byte.toString(16).substr(-2);
			}
			////FlxG.log( "Key: " + keyStr );
		}
		


		
	}
}
