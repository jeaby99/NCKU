package com.core
{
	import com.core.pool.ItemPoll;
	import com.greensock.TweenLite;
	import com.utils.event.CustomEvent;
	import com.utils.event.EventCenter;
	import com.utils.resource.ResourceData;
	import com.utils.Tools;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author yang
	 */
	public class ItemManager
	{
		static private const DISPATCH_TIME:int = 500;
		static private const DISPATCH_ARRAY:Array = [];
		static public var SPEED:int = 2;
		
		private var _view:Sprite;
		private var _itemArr:Array;
		private var _ct:int;
		private var _item:Item;
		private var _player:Player;
		private var _playerBall:Sprite;
		private var _playerFoot:Sprite;
		
		private var _hasTortoise:Boolean;
		private var _tortoise:Item;
		private var _tortoiseCD:int;
		private var _tortoiseHit:Boolean;
		private var _tortoiseSide:int;
		
		private var _cwtArr:Array;
		private var _boom:MovieClip;
		
		public function ItemManager(displayer:Sprite, player:Player)
		{
			_view = displayer;
			_player = player;
			_playerBall = _player.ball;
			_playerFoot = _player.foot;
			
			_boom = Tools.ArrangeDisplayer(ResourceData.getInstance().getResouse("BOOM") as MovieClip);
			_boom.alpha = 0;
			//_boom.cacheAsBitmapMatrix = new Matrix();
			_view.addChild(_boom);
		}
		
		public function setCmd(iarr:Array, tortoise:Boolean = false):void
		{
			_itemArr = iarr;
			_hasTortoise = tortoise;
		}
		
		public function start():void
		{
			_ct = getTimer();
			_tortoiseCD = getTimer();
			_cwtArr = [];
			_itemCount = 0;
			_tortoiseHit = false;
		}
		
		private var i:int, tf:int;
		
		public function render():void
		{
			// 每n秒出一個
			if (getTimer() - _ct >= DISPATCH_TIME)
			{
				_ct = getTimer() + DISPATCH_TIME;
				
				_item = ItemPoll.obtain();
				_item.view.gotoAndStop(getItemView());
				//_item.view.gotoAndStop(6);
				_item.view.y = -30;
				_item.view.x = getItemX();
				_view.addChild(_item.view);
				_cwtArr.push(_item);
			}
			
			// 一般物品
			for (i = 0; i < _cwtArr.length; i++)
			{
				_item = _cwtArr[i];
				_item.view.y += SPEED;
				
				// recycle item
				if (_item.view.y >= 500)
				{
					_cwtArr.splice(i, 1);
					ItemPoll.recycle(_item);
				}
				else if (_item.view.hitTestObject(_playerBall))
				{
					// check player hit ball
					tf = _item.currentFrame;
					
					if (tf >= 6)
					{
						_player.cry();
					}
					
					EventCenter.dispatchEvent(new CustomEvent(CustomEvent.HIT, tf));
					_cwtArr.splice(i, 1);
					ItemPoll.recycle(_item);
					
					// 如果是炸彈
					if (_item.currentFrame == 6)
					{
						_boom.x = _item.view.x;
						_boom.y = _item.view.y;
						_boom.alpha = 1;
						
						TweenLite.killTweensOf(_boom);
						TweenLite.to(_boom, 2, {onComplete: function():void
							{
								_boom.alpha = 0;
							}});
					}
				}
			}
			
			// 烏龜CD 7秒
			if (_hasTortoise && !_tortoise && getTimer() - _tortoiseCD > 7000)
			{
				_tortoiseCD = getTimer();
				_tortoise = ItemPoll.obtain();
				_tortoise.view.gotoAndStop(8);
				_tortoise.view.y = 450;
				_view.addChild(_tortoise.view);
				// 烏龜是否從左邊發射
				_tortoiseSide = (Math.random() > 0.5) ? 1 : 2; // 1左2右
				_tortoise.view.x = (_tortoiseSide == 1) ? -30 : 600;
				_tortoise.view.scaleX = (_tortoiseSide == 1) ? 1 : -1;
			}
			
			if (_tortoise && !_tortoiseHit)
			{
				if (_tortoiseSide == 1)
				{
					_tortoise.view.x += SPEED * 3;
				}
				else
				{
					_tortoise.view.x -= SPEED * 3;
				}
				
				if (_tortoiseSide == 1 && _tortoise.view.x >= 600)
				{
					ItemPoll.recycle(_tortoise);
					_tortoise = null;
					_tortoiseHit = false;
				}
				else if (_tortoiseSide == 2 && _tortoise.view.x <= 0)
				{
					ItemPoll.recycle(_tortoise);
					_tortoise = null;
					_tortoiseHit = false;
				}
				else if (_tortoise.view.hitTestObject(_playerFoot))
				{
					// check player hit ball					
					tf = _tortoise.currentFrame;
					_tortoiseHit = true;
					_tortoise.view.gotoAndStop(9);
					_player.cry();
					TweenLite.to(_tortoise.view, 2, {onComplete: function():void
						{
							// 有可能會先被 clear 清掉
							if (_tortoise)
							{
								ItemPoll.recycle(_tortoise);
								_tortoise = null;
							}
							_tortoiseHit = false;
						}});
					
					EventCenter.dispatchEvent(new CustomEvent(CustomEvent.HIT, tf));
				}
			}
		}
		
		/**
		 * 每項物品照順序來
		 * 如果出產量超過8個 就隨機出炸彈6或大便7
		 * @return
		 */
		private var _itemCount:int;
		
		private function getItemView():int
		{
			if (++_itemCount > 8 && Tools.randomInt(1, 10) >= 9)
			{
				_itemCount = 0;
				return (Math.random() > 0.5) ? 6 : 7;
			}
			
			_itemArr.push(_itemArr.shift());
			return _itemArr[_itemArr.length - 1];
		}
		
		// 不能與上一個座標重複
		private var _preX:int = 0;
		private var _curX:int;
		
		private function getItemX():int
		{
			do
			{
				_curX = 80 + Tools.randomInt(0, 5) * 88;
			} while (_preX == _curX);
			_preX = _curX;
			
			return _curX;
		}
		
		public function clear():void
		{
			if (_cwtArr)
			{
				for (i = 0; i < _cwtArr.length; i++)
				{
					ItemPoll.recycle(_cwtArr[i]);
				}
			}
			
			if (_tortoise)
			{
				TweenLite.killTweensOf(_tortoise.view);
				ItemPoll.recycle(_tortoise);
				_tortoise = null;
			}
			
			TweenLite.killTweensOf(_boom);
			_boom.alpha = 0;
		}
	}
}