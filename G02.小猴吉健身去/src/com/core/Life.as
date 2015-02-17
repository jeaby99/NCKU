package com.core
{
    import com.greensock.*;
    import com.utils.*;
    import flash.display.*;

    public class Life
    {
        private var _view:MovieClip;
        private var _life:int;
		private var _totla:int
		
        public function Life(displayer:MovieClip)
        {
            this._view = Tools.ArrangeDisplayer(displayer);
            this._view.stop();
			
			_totla = 3;
		}
		
        public function init() : void
        {
            this._life = _totla;
            this._view.gotoAndStop(4 - _totla);
        }
		
        public function get life() : int
        {
            return this._life;
        }
		
        public function set life(v:int) : void
        {
			v = (v > _totla) ? _totla : v;
            this._life = v;
            this._view.gotoAndStop(4 - this._life);
        }
		
        public function get view() : MovieClip
        {
            return this._view;
        }
    }
}
