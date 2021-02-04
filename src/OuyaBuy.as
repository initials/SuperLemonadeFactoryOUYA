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

	public class OuyaBuy extends FlxState
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
		
		public var urlRequest:URLRequest;
		public var urlLoader:URLLoader ;
		
		override public function create():void
		{
			buytimer = 0.0;
			
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
			
			bgBags = new FlxSprite(0, 0, ImgSugarBagsAndCrate);
			bgBags.y = FlxG.height - bgBags.height;
			bgBags.velocity.x = -200;
			add(bgBags);
			
			bgShelf = new FlxSprite(110, 110, ImgShelf);
			bgShelf.x = FlxG.width - bgShelf.width;			
			bgShelf.y = FlxG.height - bgShelf.height;
			bgShelf.velocity.x = -200;
			add(bgShelf);			
			
			//	Test specific
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			var pic:FlxSprite = new FlxSprite(0, 0, Registry.ImgLogo);
			
			//	Create the Slide FX
			//slide = FlxSpecialFX.centerSlide();
			
			//	Here we'll create it from an embedded PNG, positioned at 0,0 and it'll do a vertical reveal to start with
			//pic = slide.createFromClass(Registry.ImgLogo, 0, 0, CenterSlideFX.REVEAL_VERTICAL);
			pic.x = FlxG.width / 2 - pic.width / 2;
			pic.y = (FlxG.height / 2 - pic.height / 2 ) - 110;
			pic.velocity.x = -120;
			add(pic);
			
			//slide.start();
			
			if (Registry.mouseEnabled)
				FlxG.mouse.show();
			else
				FlxG.mouse.hide();
			
			buttonsGroup = new FlxGroup();
			
			
			
			
			
			headingTxt = new FlxText(FlxG.width/2 - 40 , FlxG.height-34, FlxG.width/2, "", true);
			headingTxt.color = 0x8000FF;
			headingTxt.size = 8;
			headingTxt.alignment = "left";
			headingTxt.text = "Press O to return to main menu";
			add(headingTxt);
			
			
			
/*			loader = new URLLoader;
			loader.load( new URLRequest( "http://superlemonadefactory.initialsgames.com/log.xml" ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );*/
			
			//Get the version number
			var xml : XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns : Namespace = xml.namespace();
			var version : String = xml.ns::versionNumber;
			Registry.version = version;
			//FlxG.log("Version " + version);
			
			versionText = new FlxText(0 , FlxG.height-34, FlxG.width, "", true);
			versionText.color = 0x8000FF;
			versionText.size = 8;
			versionText.alignment = "right";
			versionText.text = "Version: " + version;
			add(versionText);	
			
			
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
			
			
			this.buy();
			
			
						
			


		}

		override public function update():void
		{
			

			if (FlxG.ouyaController.o.pressed)  {
				FlxG.switchState(new PCMenuState());
				urlLoader = null;
				urlRequest = null;
				this.ouyaIap = null;
				

			
			
			}
			
			super.update();
			
			
			

		}
		
		private function buy():void
		{
			FlxG.log("-------------BUYING-------------- buyTimer? : "  + buytimer);
			//if (buytimer < 0.25) return;
			
			urlRequest = new URLRequest( "key.der" );        // Needs to be in your bin directory!
			urlLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, onKeyLoad );
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load( urlRequest );
			
			//urlLoader.removeEventListener(Event.COMPLETE, onKeyLoad);
			
			
			
		}
		
		private function onKeyLoad( event:Event ):void
		{
			//currentButton = 0;
			
			FlxG.log(" ON KEY LOAD ");
			
			( event.target as URLLoader ).removeEventListener( Event.COMPLETE, onKeyLoad );
			
			// Get the Key data - as a ByteArray so we can pass it to the ANE
			var key:ByteArray = ( event.target as URLLoader ).data as ByteArray;
			key.endian = Endian.LITTLE_ENDIAN;
			
			// Simple way to read the values and make sure your key matches.
			this.checkKey( key );
			
			//if(this.ouyaIap == null)
			this.ouyaIap = null;
			
			this.ouyaIap = AIROUYAIAPANE.getInstance( "1524df9e-c5bf-426d-86e9-2194298858c6", key, false );
				
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.PRODUCT, onProduct );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.PURCHASE, onPurchase );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceipt );
			this.ouyaIap.addEventListener( AIROUYAIAPANEEvent.GAMER, onGamer );
			this.ouyaIap.getProductInfo( "SLF" );						// You will need a product on OUYAs server! Not yet updated to new ODK
			this.ouyaIap.getGamerUUID();
		}
		
		private function onProduct( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var product:Product = iapEvent.data as Product;
			if( null != product )
			{
				FlxG.log( "Product Received: " + product.identifier + ", " + product.name + ", " + product.price );
				
				this.ouyaIap.makeProductPurchase( product );
			}
		}
		
		private function onPurchase( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var purchase:Purchase = iapEvent.data as Purchase;
			if( null != purchase )
			{
				FlxG.log( "Purchase Made: " + purchase.identifier + ", " + purchase.name + ", " + purchase.price );
				
				this.ouyaIap.getProductReceipts();									// This call only works on ENTITLEMENTS!  Make sure you've bought one first to see a receipt.
			}
		}
		
		private function unlockGame():void
		{
			Registry.DEMO = false;
			
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
		private function onReceipt( iapEvent:AIROUYAIAPANEEvent ):void
		{
			//trace( "Receipt Received: " + iapEvent.status );
			
			var receipt:Receipt = iapEvent.data as Receipt;
			if( null != receipt )
			{
				FlxG.log( "Receipt Received: " + receipt.identifier + ", " + receipt.price + ", " + receipt.generatedDate + ", " + receipt.purchasedDate );
				
				//headingTxt.text = "--FULL GAME UNLOCKED--";
				
				unlockGame();
				
			}
		}
		
		private function onGamer( iapEvent:AIROUYAIAPANEEvent ):void
		{
			var gamer:Gamer = iapEvent.data as Gamer;
			if( null != gamer )
			{
				FlxG.log( "Gamer UUID Received: " + gamer.udid );
				
				this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PRODUCT, onProduct );
				this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.PURCHASE, onPurchase );
				this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.RECEIPT, onReceipt );
				this.ouyaIap.removeEventListener( AIROUYAIAPANEEvent.GAMER, onGamer );
				
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
			//FlxG.log( "Key: " + keyStr );
		}
		
		
	}
}