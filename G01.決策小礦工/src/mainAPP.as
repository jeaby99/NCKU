package
{
	import com.core.GameData;
	import com.manager.SceneManager;
	import com.panel.IndexPanel;
	import com.utils.resource.ResourceData;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author yang
	 */
	[SWF(backgroundColor="0x000000",width="800",height="480",frameRate="20")]
	
	public class mainAPP extends Sprite
	{
		[Embed(source="../asset/asset.swf",mimeType="application/octet-stream")]
		public var AssetClass:Class;
		
		private var _view:Sprite;
		
		public function mainAPP():void
		{
			(stage) ? init() : this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			GameData.stage = stage;
			stage.frameRate = GameData.FRAMERATE;
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.ACTIVATE, onActivateHandler);
			
			if (stage.fullScreenHeight > stage.fullScreenWidth)
			{
				stage.setOrientation(StageOrientation.ROTATED_RIGHT);
			}
			
			if (Capabilities.version.toLowerCase().indexOf("win") > -1)
			{
				GameData.IS_WIN = true;
			}
			else
			{
				GameData.IS_WIN = false;
				IndexPanel.TURN_SPEED = 1.5;
			}
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			
			setView();
		}
		
		private function setView():void
		{
			var viewMask:Sprite = getAssetView();
			viewMask.mouseChildren = false;
			viewMask.mouseEnabled = false;
			viewMask.cacheAsBitmap = true;
			viewMask.cacheAsBitmapMatrix = new Matrix();
			
			_view = getAssetView();
			_view.tabChildren = false;
			_view.tabEnabled = false;
			//_view.cacheAsBitmap = true;			
			_view.mask = viewMask;
			_view.addChild(viewMask);
			_view.x = 0;
			_view.y = 0;
			stage.addChild(_view);
			
			ResourceData.getInstance().addEmbedResource(this.AssetClass);
			ResourceData.getInstance().loadResource(this.onResourceLoaded);
		}
		
		private function onResourceLoaded():void
		{
			GameData.index = new IndexPanel();
			SceneManager.getInstance().init(_view);
			SceneManager.getInstance().addScene(GameData.index);
			SceneManager.getInstance().enterScene(GameData.index, null, GameData.index.init, GameData.index.onEnter);
		}
		
		private function onActivateHandler(e:Event):void
		{
			stage.frameRate = (e.type == Event.ACTIVATE) ? GameData.FRAMERATE : 0.000000000000001;
		}
		
		private function onKeyPress(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.BACK)
			{
				e.preventDefault();
				NativeApplication.nativeApplication.exit();
			}
		}
		
		private function getAssetView():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0);
			sp.graphics.drawRect(0, 0, 800, 480);
			sp.graphics.endFill();
			return sp;
		}
	}
}