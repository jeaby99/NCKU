package com.utils.resource {
	import com.greensock.loading.data.DataLoaderVars;
	import com.utils.Tools;
	import flash.events.PressAndTapGestureEvent;
	import flash.system.Security;
	/**
	 * ...
	 * @author yang
	 */
	public class AbstractResource 
	{
		private var _resourceData:ResourceData;		
		public function AbstractResource() 
		{
			_resourceData = ResourceData.getInstance();
		}
		
		protected function getResource(className:String):Object
		{	
			var data:* = _resourceData.getResouse(className);
			
			if (!data)
			{
				Tools.alert("GetClassError", className);
				throw new Error("GetClassError");
			}
			
			return data;
		}
		
		protected function getResourceClass(className:String):Class
		{	
			return _resourceData.getClass(className);
		}
	}
}