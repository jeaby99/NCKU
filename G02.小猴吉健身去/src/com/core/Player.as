package com.core
{
	import com.greensock.TweenLite;
	import com.utils.Tools;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author yang
	 */
	public class Player
	{
		static public const LEFT:String = "left";
		static public const RIGHT:String = "right";
		static public const J_LEFT:String = "jleft";
		static public const J_RIGHT:String = "jright";
		static public const CRY:String = "cry";
		
		private var _view:MovieClip;
		private var _isJump:Boolean;
		private var _isCry:Boolean;
		private var _side:int;
		
		private var _ball:Sprite;
		private var _foot:Sprite;
		
		static public var SPEED:Number = 5;
		
		public function Player(displayer:MovieClip)
		{
			_view = Tools.ArrangeDisplayer(displayer);
			//_view.cacheAsBitmap = true;
			
			_ball = Tools.ArrangeDisplayer(_view["ball"]);
			_foot = Tools.ArrangeDisplayer(_view["foot"]);
		}
		
		public function init():void
		{
			_view.gotoAndStop(LEFT);
			_view.x = GameData.STAGE_X;
			_view.y = GameData.STAGE_Y;
			_isJump = _isCry = false;
			_side = 1;
			TweenLite.killTweensOf(_view);
		}
		
		public function jump():void
		{
			if (_isJump)
				return;
			
			_isJump = true;
			TweenLite.to(_view, 0.3, {y: "-50", onComplete: function():void
				{
					TweenLite.to(_view, 0.3, {y: GameData.STAGE_Y, onComplete: function():void
						{
							_isJump = false;
						}});
				}});
		}
		
		public function goLeft():void
		{
			_side = 1;
			if (_view.x >= 40)
			{
				_view.x -= SPEED;
			}
		}
		
		public function goRight():void
		{
			_side = 2;
			if (_view.x <= 560)
			{
				_view.x += SPEED;
			}
		}
		
		public function cry():void
		{
			_view.gotoAndStop(CRY);
			_isCry = true;
			TweenLite.to(_view, 2, {onComplete: function():void
				{
					_isCry = false;
					render();
				}});
		}
		
		public function render():void
		{
			if (_isCry)
			{
				_view.gotoAndStop(CRY);
			}
			else if (_isJump)
			{
				if (_side == 1)
				{
					_view.gotoAndStop(J_LEFT);
				}
				else
				{
					_view.gotoAndStop(J_RIGHT);
				}
			}
			else
			{
				if (_side == 1)
				{
					_view.gotoAndStop(LEFT);
				}
				else
				{
					_view.gotoAndStop(RIGHT);
				}
			}
		}
		
		public function get ball():Sprite
		{
			return _ball;
		}
		
		public function get foot():Sprite
		{
			return _foot;
		}
	}
}