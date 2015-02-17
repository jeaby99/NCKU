package com.core 
{
	import com.utils.resource.ResourceData;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author yang
	 */
	public class Item 
	{
		private var _view:MovieClip;
		
		public function Item() 
		{
			_view = ResourceData.getInstance().getResouse("Item") as MovieClip;
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			_view.cacheAsBitmap = true;
		}
		
		public function init():void
		{
			_view.gotoAndStop(1);
		}
		
		public function get view():MovieClip
		{
			return _view;
		}
		
		public function get currentFrame():int
		{
			return _view.currentFrame;
		}
		
		public function destory():void 
		{
			_view.parent.removeChild(_view);
		}
	}
}