package com.manager 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * 右鍵按鈕管理員
	 * @author jeaby
	 */
	public class ContextMenuManager 
	{		
		// 
		static public var so:SharedObject;
		
		static private var _content:DisplayObjectContainer;
		static private var _menu:ContextMenu;
		
		
		/**
		 * 
		 * @param	label	右鍵按鈕名稱
		 * @param	func	callback
		 */
		static public function init(content:DisplayObjectContainer):void
		{
			_content = content;
			
			_menu = new ContextMenu();
			_menu.hideBuiltInItems();
			_content.contextMenu = _menu;
			
			// 第一次使用，先設定靜音與否
			so = SharedObject.getLocal("NCKU", "/");
			if (so.data.music_enable == undefined || so.data.music_enable == true)
			{
				so.data.music_enable = true;
				so.flush();
				SoundManager.getInstance().mute(false);
			}
			else
			{
				so.data.music_enable = false;
				so.flush();
				SoundManager.getInstance().mute(true);
			}
			
			// -------------------------------------------------
			
			var cmoff:ContextMenuItem = addContextMenuItem("music OFF", function(e:Event):void
			{
				so.data.music_enable = false;
				so.flush();
				SoundManager.getInstance().mute(true);
				checkOff();
			});
			
			var cmon:ContextMenuItem = addContextMenuItem("music ON", function(e:Event):void
			{
				so.data.music_enable = true;
				so.flush();
				SoundManager.getInstance().mute(false);
				checkOff();
			});
			
			function checkOff():void
			{
				_menu.customItems = [];
				
				if (so.data.music_enable) 
				{
					_menu.customItems.push(cmoff);
				} else {
					_menu.customItems.push(cmon);
				}
			}
			
			checkOff();
		}
		
		static public function addContextMenuItem(label:String, func:Function):ContextMenuItem
		{		
			var menuItem:ContextMenuItem = new ContextMenuItem(label);
			_menu.customItems.push(menuItem);
			menuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:ContextMenuEvent):void
			{
				func(e);
			});
			
			return menuItem;
		}
	}
}