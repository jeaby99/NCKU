package com.core.pool 
{
	import com.core.Item;
	/**
	 * ...
	 * @author ...
	 */
	public class ItemPoll 
	{
		static private var POOL:Vector.<Item> = new Vector.<Item>();
		
		static public function obtain():Item 
		{
			var view:Item;
			if (POOL.length > 0)
			{
				view = POOL.pop();
			}
			else
			{
				view = new Item();
			}
			view.init();
			
			return view;
		}
		
		static public function recycle(item:Item):void
		{
			if (POOL.indexOf(item) == -1)
			{
				item.destory();
				POOL.push(item);
			}
		}
	}
}