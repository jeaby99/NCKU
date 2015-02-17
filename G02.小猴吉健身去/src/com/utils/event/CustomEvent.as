package com.utils.event {
	import flash.events.Event;
	/**
	 * ...
	 * @author yang
	 */
	public class CustomEvent extends Event
	{
		// command
		static public const START:String = "start";
		static public const PREPARE:String = "prepare";
		static public const GAMEOVER:String = "GAMEOVER";
		static public const HIT:String = "HIT";
		static public const GESTURE:String = "GESTURE";
		
		public var data:Object;
		public function CustomEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}