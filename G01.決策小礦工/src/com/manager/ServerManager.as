package com.manager
{
	import com.utils.Console;
	import flash.display.Stage;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author yang
	 */
	public class ServerManager
	{
		private var _url:String;
		private var _lv:int;
		
		public function ServerManager()
		{
		
		}
		
		public function init(stg:Stage):void
		{
			_url = stg.loaderInfo.parameters["url"];
			_lv = stg.loaderInfo.parameters["lv"];
			
			if (!_lv)
				_lv = 1;
		}
		
		public function send(score:int, life:int, lextlevel:Boolean, actorLife:int):void
		{
			var _dm:DateManager = DateManager.getInstance();
			
			var lifescoretotal:int;
			var request:URLRequest = new URLRequest(_url);
			var variables:URLVariables = new URLVariables();
			
			variables.t1 = score; // 遊戲得分
			variables.t2 = life; // 生命值
			variables.t3 = lextlevel; // ture: 有玩30秒加分關。 false: 沒玩加分關。 無資料預帶 false
			variables.t4 = _lv; // 現在第幾關
			variables.t5 = actorLife; // 打錯的次數
			variables.gametype = "flashgame15"; // 水銃仔大戰
			variables.ymd = _dm.startDate; // 遊戲日期                           		 --> 新增加
			variables.tm1 = _dm.startTime; // 開始遊戲時間 字串格式: hh:mm       		--> 新增加
			variables.tm2 = _dm.getCurrentTime(); // 結束遊戲時間 字串格式: hh:mm        --> 新增加
			
			Console.log("t1:", variables.t1);
			Console.log("t2:", variables.t2);
			Console.log("t3:", variables.t3);
			Console.log("t4:", variables.t4);
			Console.log("t5:", variables.t5);
			Console.log("gametype:", variables.gametype);
			Console.log("ymd:", variables.ymd);
			Console.log("tm1:", variables.tm1);
			Console.log("tm1:", variables.tm2);
			
			request.data = variables;
			request.method = "POST";
			try
			{
				navigateToURL(request, "_self");
			}
			catch (err:Error)
			{
				Console.log(err.message)
			}
		}
		
		// -----------------------------------------------		
		static private var _instance:ServerManager;
		
		static public function getInstance():ServerManager
		{
			_instance = _instance || new ServerManager();
			return _instance;
		}
	}
}