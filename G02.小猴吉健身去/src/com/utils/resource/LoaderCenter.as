package com.utils.resource {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author ...
	 */
	public class LoaderCenter 
	{
		private var _onCompleteCallback:Function;
		private var _dataArr:Array;
		private var _loader:Loader;
		private var _context:LoaderContext;
		
		public function LoaderCenter(callback:Function) 
		{
			_onCompleteCallback = callback;			
			
			_context = new LoaderContext(false, ApplicationDomain.currentDomain);
			_context.allowCodeImport = true;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		public function addEmbedResource(arg:Array):void 
		{
			_dataArr = arg;
		}
		
		private function onLoadComplete(e:Event):void 
		{
			load();
		}
		
		public function load():void 
		{
			var DataClass:Class = _dataArr.pop();
			
			if (DataClass)
			{
				_loader.loadBytes(new DataClass, _context);
			}
			else
			{
				_onCompleteCallback();
			}
		}
	}
}