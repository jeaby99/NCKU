package com.utils.button {
	import com.manager.SoundManager;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yang
	 */
	public class PButton //extends EventDispatcher
	{
		private var _view:DisplayObject;
		private var _active:Boolean;
		
		protected var _sm:SoundManager = SoundManager.getInstance();
		protected var _clickHandle:Function;
		
		public function PButton(displayer:DisplayObject, clickHandle:Function)
		{
			_view = displayer;
			_view.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_view.addEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			
			_clickHandle = clickHandle;
			active = true;
		}
		
		public function destroy():void
		{
			_view.removeEventListener(MouseEvent.ROLL_OVER, onMouseRollOver);
			_view.removeEventListener(MouseEvent.CLICK, onMouseClickButton);
			_view = null;
			_clickHandle = null;
		}
		
		private function onMouseRollOver(e:MouseEvent):void
		{
			//_sm.play(SoundManager.Sound_MouseOver);
		}
		
		/**
		 * 滑鼠按下
		 */
		protected function onMouseClickButton(e:MouseEvent):void
		{
			//_sm.play(SoundManager.Sound_MouseOver);
			_clickHandle(this);
		}
		
		public function set active(value:Boolean):void
		{
			_view["mouseEnabled"] = value;
		}
		
		public function set visible(value:Boolean):void
		{
			_view.visible = value;
		}
		
		public function get visible():Boolean
		{
			return _view.visible;
		}
		
		public function get view():DisplayObject
		{
			return _view;
		}
	}
}