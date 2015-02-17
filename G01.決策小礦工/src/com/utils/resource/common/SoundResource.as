package com.utils.resource.common {
	import com.utils.resource.AbstractResource;
	import flash.media.Sound;
	/**
	 * ...
	 * @author yang
	 */
	public class SoundResource extends AbstractResource
	{	
		static private var soundPool:Object = { };
		
		// ---------------------------------------------
		
		public function SoundResource() 
		{
			super();
		}
		
		public function getSound(soundName:String):Sound
		{
			if (!soundPool[soundName])
			{
				soundPool[soundName] = super.getResource(soundName);
			}
			
			return soundPool[soundName];
		}
	}
}