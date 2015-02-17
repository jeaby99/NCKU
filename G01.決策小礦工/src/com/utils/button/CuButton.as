package com.utils.button {
	import com.manager.SoundManager;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yang
	 */
	public class CuButton extends PButton
	{
		public function CuButton(displayer:DisplayObject, clickHandle:Function)
		{
			super(displayer, clickHandle);
		}
		
		/**
		 * 回傳自己
		 * @param
		 */
		override protected function onMouseClickButton(e:MouseEvent):void
		{
			//_sm.play(SoundManager.ClickSound);
			_clickHandle(this);
		}
	}
}