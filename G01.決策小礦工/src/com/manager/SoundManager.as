package com.manager 
{
	import com.utils.resource.common.SoundResource;
	import com.utils.resource.ResourceManager;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author yang
	 */
	public class SoundManager 
	{
		// 音檔內容
		static public const Sound_BackgroundSound:String = "BackgroundSound";
		
		static public const Sound_Cashregister:String = "Sound_Cashregister";
		static public const Sound_HitSound:String = "Sound_HitSound";
		static public const Sound_AllStageClearSound:String = "Sound_AllStageClearSound";
		static public const Sound_FailSound:String = "Sound_FailSound";
		
		// **************************************************************
		
		private var _soundRes:SoundResource = ResourceManager.sound;
		private var _bgmSoundTransform:SoundTransform = new SoundTransform(0.3);
		
		public function SoundManager() 
		{
			
		}
		
		private var _bgmChannel:SoundChannel;
		private var _audioChannel:SoundChannel;
		private var _preAudioName:String;
		private var _bgmName:String = null;
		
		/**
		 * 播放音效
		 */
		public function play(soundname:String, loop:int = 1, vol:Number = 1):void
		{
			if (_audioChannel && (soundname == _preAudioName)) {
				_audioChannel.stop();
			}

			_audioChannel = (_soundRes.getSound(soundname) as Sound).play(0, loop, new SoundTransform(vol));
			_preAudioName = soundname;
		}
		
		private var _loopObj:Object = { };
		public function playLoop(soundname:String, loop:int = int.MAX_VALUE, vol:Number = 1):SoundChannel
		{
			if (_loopObj[soundname])
			{
				return null;
			}
			var sc:SoundChannel = (_soundRes.getSound(soundname) as Sound).play(0, loop, new SoundTransform(vol));
			_loopObj[soundname] = sc;
			return sc;
		}
		
		public function stopLoop(soundname:String):void
		{
			if (_loopObj[soundname])
			{
				_loopObj[soundname].stop();
				delete _loopObj[soundname];
			}
		}
		
		/**
		 * 會 loop，一次只有一個 BGM
		 */
		public function playBGM(soundname:String, loop:int = 999999):void
		{
			// 如果有背景音 
			if (_bgmChannel)
			{
				return;
			}
			
			stopBGM();
			
			var sound:Sound = _soundRes.getSound(soundname);
			if (sound)
			{
				_bgmChannel = sound.play(0, loop, _bgmSoundTransform);
				_bgmName = soundname;
			}
		}
		
		public function stopBGM():void
		{
			if (_bgmChannel)
			{
				_bgmChannel.stop();
				_bgmChannel = null;
				_bgmName = null;
			}
		}
		
		public function get currentBGM():String
		{
			return _bgmName;
		}
		
		public function mute(m:Boolean):void
		{
			if (m)
			{
				_bgmSoundTransform.volume = 0;
			}
			else
			{
				_bgmSoundTransform.volume = .3;
			}
			
			if (_bgmChannel)
			{
				_bgmChannel.soundTransform = _bgmSoundTransform;
			}
		}
		
		// ----------------------------------
		
		
		static private var _instance:SoundManager;
		static public function getInstance():SoundManager
		{
			_instance = _instance || new SoundManager();
			return _instance;
		}
	}
}