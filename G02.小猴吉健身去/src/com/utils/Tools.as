package com.utils {
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author yang
	 */
	public class Tools
	{
		static public function traceObj(obj:Object, idx:int = 0):String
		{
			var msg:String = "";
			
			trace(" ===================== ");
			function t(obj:Object, idx:int = 0):void
			{
				for (var key:String in obj)
				{
					if (idx != 0)
					{
						var tab:String = "";
						for (var i:int = 0; i < idx; i++)
							tab += "	";
						trace(tab + "[key]:", key, "[value]:", obj[key]);
						msg += tab + "[key]:" + key + "[value]:" + obj[key] + "\n";
					}
					else
					{
						trace("[key]:", key, "[value]:", obj[key]);
						msg += "[key]:" + key + "[value]:" + obj[key] + "\n";
					}
					
					if (typeof(obj[key]) == "object")
					{
						t(obj[key], idx + 1);
					}
				}
			}
			
			t(obj, idx);
			trace(" --------------------- ");
			
			return msg;
		}
		
		static public function alert(... arg):void
		{
			var msg:String = "";
			while (arg.length)
			{
				msg += arg.shift().toString() + " ";
			}
			trace(msg);
			
			if (ExternalInterface.available)
			{
				ExternalInterface.call("alert('" + msg + "')");
			}
		}
		
		static public function setHandler(target:IEventDispatcher, eventtype:String, callback:Function):void
		{
			function onEventHandle(e:*):void
			{
				target.removeEventListener(eventtype, onEventHandle);
				callback();
			}
			
			target.addEventListener(eventtype, onEventHandle);
		}
		
		/**
		 * 從 x 到 y 的隨機正負數 (不包含 y)
		 */
		static public function randomNum(x:int, y:int):Number
		{
			return (Math.random() * (y - x)) + x;
		}
		
		/**
		 * 從 x 到 y 的隨機正負整數
		 */
		static public function randomInt(x:int, y:int):int
		{
			return Math.floor(Math.random() * (1 + y - x)) + x;
		}
		
		/**
		 * 求 p1 點跟 p2 點(原點)的角度
		 * @param	soucePoint
		 * @param	targetPoint
		 * @return
		 */
		static public function ConvertPositionAngel(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			return Math.atan2(dy, dx) / Math.PI * 180;
		}
		
		/**
		 * 角度轉弧度(徑度)
		 */
		static public function deg2rad(degree:Number):Number
		{
			return degree * (Math.PI / 180);
		}
		
		/**
		 * 弧度(徑度)轉角度
		 */
		static public function rad2deg(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		static public function ArrangeDisplayer(view:DisplayObjectContainer):*
		{
			view.mouseChildren = false;
			view.mouseEnabled = false;
			
			return view;
		}
	}
}