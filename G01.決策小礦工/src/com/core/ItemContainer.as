package com.core
{
	import com.greensock.TweenLite;
	import com.utils.Tools;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author yang
	 */
	public class ItemContainer
	{
		private var _view:MovieClip;
		private var _items:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var _item:MovieClip;
		private var _boom:MovieClip;
		private var _itemTotalNum:int;
		private var _itemCurrentNum:int;
		
		public function ItemContainer(displayer:MovieClip)
		{
			_view = displayer;
			_view.mouseChildren = false;
			_view.mouseEnabled = false;
			
			_boom = Tools.ArrangeDisplayer(_view["boom"]);
		}
		
		// 清空 items
		public function clear():void
		{
			_view.visible = false;
			_view.gotoAndStop(4);
			_items.length = 0;
			_boom.visible = false;
			TweenLite.killTweensOf(_boom);
		}
		
		private var itemView:Object = {1: [1, 1, 2, 3, 5, 6, 3, 2, 4, 1], 2: [3, 6, 4, 2, 5, 1, 3, 1, 5, 1, 5, 2, 3, 6, 4], 3: [3, 6, 4, 2, 5, 5, 5, 1, 1, 1, 3, 2, 3, 6, 4]};
		
		// 準備關卡，把每個關卡的 item 放到指定位置
		public function prepare(lv:int):void
		{
			_view.gotoAndStop(lv);
			
			var itemViewArr:Array = itemView[lv];
			_itemTotalNum = itemViewArr.length;
			for (var i:int = 0; i < itemViewArr.length; i++)
			{
				_item = _view.getChildByName("item" + (i + 1)) as MovieClip;
				_item.gotoAndStop(itemViewArr[i]);
				_item.visible = true;
				_items.push(_item);
			}
			
			_itemCurrentNum = 0;
		}
		
		public function checkHit(getterBall:Sprite):MovieClip
		{
			for each (var im:MovieClip in _items)
			{
				// 每個 item 都要設一個 hitball 感應球
				if (getterBall.hitTestObject(im["hitball"]))
				{
					_items.splice(_items.indexOf(im), 1);
					_itemCurrentNum++;
					return im;
				}
			}
			return null;
		}
		
		public function show():void
		{
			_view.visible = true;
		}
		
		public function isGetAllItem():Boolean
		{
			return _itemCurrentNum == _itemTotalNum;
		}
		
		public function showBoom(p:Point):void
		{
			_boom.visible = true;
			_boom.x = p.x;
			_boom.y = p.y;
			
			TweenLite.to(_boom, 1.5, {onComplete: function():void
				{
					_boom.visible = false;
				}});
		}
	}
}