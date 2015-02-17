package com.utils.resource.common {
	import com.utils.resource.AbstractResource;
	/**
	 * ...
	 * @author yang
	 */
	public class AssetResource extends AbstractResource
	{	
		public function AssetResource() 
		{
			super();
			_fileName = "asset.swf";
		}
		
		// 造型
		public function getModel():*
		{
			return super.getResource("Model");
		}
		
		public function getPopText():* 
		{
			return super.getResource("PopText");
		}
		
		public function getResourceByName(cn:String):*
		{
			return super.getResource(cn);
		}
	}
}