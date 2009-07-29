package org.as3commons.logging.impl
{
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.ILoggerFactory;
	import org.codehaus.stomp.Stomp;

	public class StompLoggerFactory implements ILoggerFactory
	{
		private var stomp:Stomp;
		private var destination:String;
		
		public function StompLoggerFactory(stomp:Stomp, destination:String="/topic/StompLogger")
		{
			super();
			this.stomp = stomp;
			this.destination = destination;
		}
		
		public function getLogger(name:String):ILogger
		{
			return new StompLogger(name, stomp, destination);
		}
	}
}