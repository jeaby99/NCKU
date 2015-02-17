package 
{
    import com.core.*;
    import com.manager.*;
    import com.panel.*;
    import com.utils.resource.*;
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;

	[SWF(backgroundColor="0x000000", width="800", height="480", frameRate="30")]
    public class main extends Sprite
    {
		[Embed(source="../asset/asset.swf", mimeType="application/octet-stream")]
        public var AssetClass:Class;

        public function main()
        {
            Security.allowDomain("*");
            if (stage)
            {
                this.init();
            }
            else
            {
                this.addEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
			}
		}
		
        private function onAddToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
            this.init();
		}

        private function init() : void
        {
            GameData.stage = stage;
            ResourceData.getInstance().addEmbedResource(this.AssetClass);
            ResourceData.getInstance().loadResource(this.onResourceLoaded);
        }
		
        private function onResourceLoaded() : void
        {
            ContextMenuManager.init(this);
            GameData.index = new IndexPanel();
            SceneManager.getInstance().init(this);
            SceneManager.getInstance().addScene(GameData.index);
            SceneManager.getInstance().enterScene(GameData.index, null, GameData.index.init, GameData.index.onEnter);
		}
    }
}
