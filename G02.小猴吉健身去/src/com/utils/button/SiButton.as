package com.utils.button {
	import com.manager.SoundManager;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yang
	 */
	public class SiButton extends PButton
	{
		public function SiButton(displayer:DisplayObject, clickHandle:Function) 
		{			
			super(displayer, clickHandle);
		}
		
		/**
		 * 回傳 event
		 * @param	e
		 */
		override protected function onMouseClickButton(e:MouseEvent):void 
		{
			//_sm.play(SoundManager.ClickSound);
			_clickHandle(e);
		}
	}
}