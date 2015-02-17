package com.core
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author yag
	 */
	public class Gesture
	{
		private var _stage:Stage;
		private var _isPress:Boolean;
		private var _gestureVec:Vector.<int>;
		
		public function Gesture(stg:Stage)
		{
			_stage = stg;
			_gestureVec = new Vector.<int>(4);
			clear();
		}
		
		public function clear():void
		{
			_gestureVec[0] = 0;	// 上
			_gestureVec[1] = 0; // 下
			_gestureVec[2] = 0; // 左
			_gestureVec[3] = 0; // 右
		}
		
		public function start():void
		{
			_isPress = false;
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, onMousePress);
			_stage.addEventListener(MouseEvent.MOUSE_UP, onMouseRelease);
			_stage.addEventListener(Event.ENTER_FRAME, onframe);
		}
		
		public function stop():void
		{
			_isPress = false;
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMousePress);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseRelease);
			_stage.removeEventListener(Event.ENTER_FRAME, onframe);
		}
		
		private function onMousePress(e:MouseEvent):void
		{
			_isPress = true;
			_px = _stage.mouseX;
			_py = _stage.mouseY;
		}
		
		private function onMouseRelease(e:MouseEvent):void
		{
			_isPress = false;
			_gestureVec[0] = 0;	// 上
			_gestureVec[1] = 0; // 下
			_gestureVec[2] = 0; // 左
			_gestureVec[3] = 0; // 右
		}
		
		private var _px:Number, _py:Number, _dx:Number, _dy:Number;
		private var _distance:Number, _angle:Number;
		
		private function onframe(e:Event):void
		{
			if (_isPress)
			{
				_dx = _px - _stage.mouseX;
				_dy = _py - _stage.mouseY;
				_distance = _dx * _dx + _dy * _dy;
				
				if (_distance > 400)
				{
					_angle = Math.atan2(_dy, _dx) * 57.2957795;
					
					if (_angle >= -22 && _angle < 23)
					{
						//string_dir = "Left\n";
						_gestureVec[0] = 0;	// 上
						_gestureVec[1] = 0; // 下
						_gestureVec[2] = 1; // 左
						_gestureVec[3] = 0; // 右
					}
					if (_angle >= 23 && _angle < 68)
					{
						//string_dir = "Up Left\n";
						_gestureVec[0] = 1;	// 上
						_gestureVec[1] = 0; // 下
						_gestureVec[2] = 1; // 左
						_gestureVec[3] = 0; // 右
					}
					if (_angle >= 68 && _angle < 113)
					{
						//string_dir = "Up\n";
						_gestureVec[0] = 1;	// 上
						_gestureVec[1] = 0; // 下
						_gestureVec[2] = 0; // 左
						_gestureVec[3] = 0; // 右
					}
					if (_angle >= 113 && _angle < 158)
					{
						//string_dir = "Up Right\n";
						_gestureVec[0] = 1;	// 上
						_gestureVec[1] = 0; // 下
						_gestureVec[2] = 0; // 左
						_gestureVec[3] = 1; // 右
					}
					if (_angle >= 158 || _angle < -157)
					{
						//string_dir = "Right\n";
						_gestureVec[0] = 0;	// 上
						_gestureVec[1] = 0; // 下
						_gestureVec[2] = 0; // 左
						_gestureVec[3] = 1; // 右
					}
					if (_angle >= -157 && _angle < -112)
					{
						//string_dir = "Down Right\n";
						_gestureVec[0] = 0;	// 上
						_gestureVec[1] = 1; // 下
						_gestureVec[2] = 0; // 左
						_gestureVec[3] = 1; // 右
					}
					if (_angle >= -112 && _angle < -67)
					{
						//string_dir = "Down\n";
						_gestureVec[0] = 0;	// 上
						_gestureVec[1] = 1; // 下
						_gestureVec[2] = 0; // 左
						_gestureVec[3] = 0; // 右
					}
					if (_angle >= 67 * -1 && _angle < 22 * -1)
					{
						//string_dir = "Down Left\n";
						_gestureVec[0] = 0;	// 上
						_gestureVec[1] = 1; // 下
						_gestureVec[2] = 1; // 左
						_gestureVec[3] = 0; // 右
					}
					
					_px = _stage.mouseX;
					_py = _stage.mouseY;
				}
			}
		}
		
		public function isLeft():Boolean 
		{
			return _gestureVec[2] == 1;
		}
		
		public function isRight():Boolean 
		{
			return _gestureVec[3] == 1;
		}
		
		public function isUp():Boolean 
		{
			return _gestureVec[0] == 1;
		}		
		public function isDown():Boolean 
		{
			return _gestureVec[1] == 1;
		}		
	}
}