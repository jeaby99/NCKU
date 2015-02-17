package com.core 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author jeaby
	 */
	public class KeyManager 
	{
		private var keyobj:Object;
		
		public function KeyManager(stage:Stage) 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);
		}
		
		private function onKeyPress(e:KeyboardEvent):void 
		{
			keyobj[e.keyCode] = true;
		}
		
		private function onKeyRelease(e:KeyboardEvent):void 
		{
			delete keyobj[e.keyCode];
		}
		
		public function isPress(keycode:uint):Boolean
		{
			return keyobj[keycode];
		}
		
		public function clear():void
		{
			keyobj = { };
		}
	}
}