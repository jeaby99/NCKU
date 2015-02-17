package com.utils {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yang
	 */
	public class SiButton extends EventDispatcher
	{
		private var _view:DisplayObject;
		private var _clcikHandle:Function;
		private var _active:Boolean;
		
		public function SiButton(displayobject:DisplayObject, clcikHandle:Function = null)
		{
			_view = displayobject;
			_view.addEventListener(MouseEvent.CLICK, onMouseClickButton);
			_view.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_clcikHandle = clcikHandle;
			active = true;
		}
		
		private function onRemoveFromStage(e:Event):void
		{
			_view.removeEventListener(MouseEvent.CLICK, onMouseClickButton);
			_view.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		/**
		 * 滑鼠按下
		 */
		private function onMouseClickButton(e:MouseEvent):void
		{
			if (_clcikHandle != null)
				_clcikHandle(e);
			dispatchEvent(e);
		}
		
		public function set active(value:Boolean):void
		{
			_view["mouseEnabled"] = value
		}
		
		public function set visible(value:Boolean):void
		{
			_view.visible = value;
		}
		
		public function get view():DisplayObject
		{
			return _view;
		}
	}
}