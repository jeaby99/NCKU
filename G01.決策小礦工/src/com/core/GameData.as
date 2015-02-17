package com.core
{
    import com.panel.*;
    import flash.display.*;

    public class GameData extends Object
    {
        public static var index:IndexPanel;
        public static var stage:Stage;
        public static var MUSIC_OFF:Boolean = false;
        public static var FAILD_RANGE:Number = 10;
        public static var SUCCESS_RANDE:Number = 20;
        public static var DIE:Boolean;
        public static var KEY_ACTIVE:Boolean;
		public static var FRAMERATE:int = 20;
		public static var IS_WIN:Boolean = true;
    }
}
