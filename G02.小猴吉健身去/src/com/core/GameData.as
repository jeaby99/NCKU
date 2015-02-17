package com.core
{
	import com.panel.*;
	import flash.display.*;

    public class GameData extends Object
    {
        public static var index:IndexPanel;
        public static var stage:Stage;
        public static var MUSIC_OFF:Boolean = false;
        public static var KEY_ACTIVE:Boolean;
		public static var IS_WIN:Boolean = true;
		
		public static const STAGE_Y:int = 450;
		public static const STAGE_X:int = 295;
		public static const FRAMERATE:int = 20;
    }
}
