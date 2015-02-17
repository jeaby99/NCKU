package com.utils.resource {
	import com.core.GameData;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author yang
	 */
	public class ResourceData
	{
		private var _resourcePool:Object;
		private var _loaderQueue:LoaderMax;
		private var _onLoadedCallback:Function;
		private var _loaderCenter:LoaderCenter;
		private var _stage:Stage;
		
		public function ResourceData()
		{
			_resourcePool = {};
			LoaderMax.defaultAuditSize = false;
			
			_loaderQueue = new LoaderMax({name: "loaderQueue", onProgress: onProgress, onComplete: onComplete});
			_loaderQueue.skipFailed = false;
			
			_loaderCenter = new LoaderCenter(onLoadComplete);
			_stage = GameData.stage;
		}
		
		public function addEmbedResource(... arg):void
		{
			_loaderCenter.addEmbedResource(arg);
		}
		
		public function addResourceURL(url:String):void
		{
			var loader:SWFLoader = new SWFLoader(url);
			_resourcePool[url] = loader
			_loaderQueue.append(loader);
		}
		
		public function loadResource(callback:Function):void
		{
			//_loaderQueue.load();
			_loaderCenter.load();
			_onLoadedCallback = callback;
		}
		
		// ---------------------------------------
		
		// 全部進度
		private function onProgress(e:LoaderEvent):void
		{
			//trace("onProgress", Number(_loaderQueue.bytesLoaded / _loaderQueue.bytesLoaded) * 100);
		}
		
		// 全部完成
		private function onComplete(e:LoaderEvent):void
		{
			_onLoadedCallback();
		}
		
		private function onLoadComplete():void
		{
			_onLoadedCallback();
		}
		
		// -------------------------------------------------
		
		// 回傳Class
		public function getClass(className:String):Class
		{
			return _stage.loaderInfo.applicationDomain.getDefinition(className) as Class;
		}
		
		// 回傳實體
		public function getResouse(className:String):Object
		{
			var DataClass:Class = getClass(className);
			return new DataClass();
		}
		
		// -------------------------------------------------
		
		static private var _instance:ResourceData;		
		static public function getInstance():ResourceData
		{
			_instance = _instance || new ResourceData();
			return _instance;
		}
	}
}