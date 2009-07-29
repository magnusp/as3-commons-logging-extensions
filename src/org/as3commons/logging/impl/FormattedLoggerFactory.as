package org.as3commons.logging.impl
{
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.ILoggerFactory;

	public class FormattedLoggerFactory implements ILoggerFactory
	{
		public function getLogger(name:String):ILogger {
			return new FormattedLogger(name);
        }
	}
}