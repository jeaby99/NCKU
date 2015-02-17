package com.utils {
    import flash.external.*;

    public class Console
    {
        static public var enabled:Boolean = true;		
        static public function log(... args):void
        {
			trace(args);
            if (!enabled || !ExternalInterface.available)
            {
                return;
            }
			
            ExternalInterface.call('console.log', args);
            return;
        }
    }
}