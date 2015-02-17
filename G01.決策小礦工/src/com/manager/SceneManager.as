package com.manager
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author yang
	 */
	public class SceneManager
	{
		private var _container:DisplayObjectContainer;
		private var _panelSprite:Sprite;
		private var _blockScene:Sprite;
		private var _currentScene:DisplayObject;
		
		private var fadeTime:Number = .2;
		
		public function init(container:DisplayObjectContainer):void
		{
			var stageWidth:Number = container.stage.stageWidth;
			var stageHeight:Number = container.stage.stageHeight;
			
			_blockScene = new Sprite();
			_blockScene.graphics.beginFill(0x000000);
			_blockScene.graphics.drawRect(0, 0, stageWidth, stageHeight);
			_blockScene.graphics.endFill();
			_blockScene.mouseChildren = false;
			
			container.scrollRect = new Rectangle(0, 0, stageWidth, stageHeight);
			
			_container = container;
			_container.tabChildren = false;
			_container.tabEnabled = false;
		}
		
		public function addScene(scene:DisplayObject):void
		{
			scene.visible = false;
			_container.addChild(scene);
		}
		
		public function enterScene(scene:DisplayObject, onInit:Function = null, onMid:Function = null, onEnter:Function = null):void
		{
			if (onInit != null)
			{
				onInit();
			}
			
			_blockScene.visible = true;
			
			// 把黑幕變黑
			TweenMax.to(_blockScene, fadeTime, {ease: Linear.easeNone, alpha: 1, onComplete: function():void
				{
					if (_currentScene)
					{
						_currentScene.visible = false;
					}
					scene.visible = true;
					_currentScene = scene;
					
					if (onMid != null)
					{
						onMid();
					}
				}});
			
			// 把黑幕變透明
			TweenMax.to(_blockScene, fadeTime, {ease: Linear.easeNone, delay: fadeTime, alpha: 0, onComplete: function():void
				{
					if (onEnter != null)
					{
						onEnter();
					}
					
					_blockScene.visible = false;
				}});
		}
		
		// -----------------------------------------------
		
		static private var _instance:SceneManager;
		static public function getInstance():SceneManager
		{
			_instance = _instance || new SceneManager();
			return _instance;
		}
	}
}