package org.as3commons.logging.impl
{
	import org.as3commons.logging.formatter.IFormatter;
	import org.as3commons.logging.impl.FormattedLogger;
	
	import org.codehaus.stomp.Stomp;
	import org.codehaus.stomp.event.ConnectedEvent;

	public class StompLogger extends FormattedLogger
	{
		private var stomp:Stomp;
		private var destination:String;
		private var cache:Array;
		private var isConnected:Boolean=false;
		
		public function StompLogger(name:String, stomp:Stomp, destination:String)
		{
			super(name);
			this.stomp = stomp;
			this.destination = destination;
			
			if(stomp.connectTime) {
				isConnected = true;
			} else {
				stomp.addEventListener(ConnectedEvent.CONNECTED, onStompConnected);
			}
		}
		
		override protected function logInternal(text:String):void {
			if(!isConnected) {
				if(!cache) {
					cache = new Array();
				}
				cache.push(text);
			} else {
				transmit(text);
			}
		}
		
		private function onStompConnected(event:ConnectedEvent):void {
			event.target.removeEventListener(ConnectedEvent.CONNECTED, onStompConnected);
			isConnected = true;
			for each(var value:String in cache) {
				transmit(value);
			}
			cache = null;
		}
		
		private function transmit(value:String):void {
			stomp.send(destination, value);
		}
	}
}