package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.*;
    import flash.text.TextField; 
    public class jump extends Sprite
    {
        public function jump()
        {
            var params:Object=root.loaderInfo.parameters;
			var _jump:URLRequest = new URLRequest(params.url);
			var _type:String = params.type;
			navigateToURL(_jump ,_type);
        }
    }
}