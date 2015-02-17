/**
 * ...
 * @author     : Bayu Rizaldhan Rayes
 * web         : http://www.bayubayu.com
 * email       : games@bayubayu.com
 *
 * Description : Class for animated text score
 *
 */

package com.utils {
	import com.utils.resource.ResourceData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import flash.utils.getTimer;
	
	public class PopText
	{
		static private const ALPHA_PARM:Number = 0.12;
		static private const MOTION_PARM:Number = 3;
		static private var UTime:Number = 300;
		static private var STime:Number = 600;
		static private var DTime:Number = 900;
		
		private var view:Sprite;
		private var message:TextField;
		private var status:int = 0;
		private var startTime:Number = 0;
		
		public function PopText()
		{
			view = ResourceData.getInstance().getResouse("PopText") as Sprite;
			message = view["message"];
			view.mouseChildren = false;
			view.mouseEnabled = false;
			view.tabChildren = false;
			view.tabEnabled = false;
		}
		
		public function show(container:Sprite, cX:Number, cY:Number, msgStr:String, color:uint = 0xffffff, size:int = -1):void
		{
			view.x = cX;
			view.y = cY;
			
			view.alpha = 0;
			startTime = getTimer();
			status = 0;
			
			if (size > 1)
			{
				var tft:TextFormat = new TextFormat();
				tft.size = size;
				message.defaultTextFormat = tft;
			}
			
			message.mouseEnabled = false;
			message.autoSize = "center";
			message.text = msgStr;
			message.textColor = color
			
			message.x = -message.width / 2;
			message.y = -message.height / 2;
			
			container.addChild(view);
			view.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void
		{
			switch (status)
			{
				case 0: 
					view.y -= MOTION_PARM;
					view.alpha += ALPHA_PARM;
					if (getTimer() - startTime > UTime)
					{
						status = 1;
					}
					break;
				
				case 1: 
					if (getTimer() - startTime > STime)
					{
						status = 2;
					}
					break;
				
				case 2: 
					view.y -= MOTION_PARM;
					view.alpha -= ALPHA_PARM;
					if (getTimer() - startTime > DTime)
					{
						status = 3;
					}
					break;
				
				case 3: 
					if (view.parent)
					{
						view.parent.removeChild(view);
						view.removeEventListener(Event.ENTER_FRAME, enterFrame);
					}
					break;
			}
		}
	}
}