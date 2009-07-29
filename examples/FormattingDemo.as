package
{
	import flash.display.Sprite;
	
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.as3commons.logging.formatter.FormatterRegistry;
	import org.as3commons.logging.impl.FormattedLoggerFactory;

	public class FormattingDemo extends Sprite
	{
		public function FormattingDemo()
		{
			LoggerFactory.loggerFactory = new FormattedLoggerFactory();
			var logger:ILogger = LoggerFactory.getLogger("FormattingDemo");

			logger.info("Formatted by the default formatter");
			FormatterRegistry.setFormatter(logger, XMLFormatter);
			logger.info("Formatted by XMLFormatter");
		}
	}
}

import org.as3commons.logging.formatter.impl.DefaultFormatter;
import org.as3commons.logging.LogLevel;
import org.as3commons.logging.util.MessageUtil;

internal class XMLFormatter extends DefaultFormatter {
	override public function format(level:uint, message:String, params:Array):String {
		var doc:XML = new XML("<logentries></logentries>");

		doc.logentry = new XML("<logentry><![CDATA[" + MessageUtil.toString(message, params) + "]]></logentry>");
		doc.logentry.@ts = int((new Date()).getTime()/1000);
		doc.logentry.@category = contextDict['loggerName'];
		doc.logentry.@level = LogLevel.toString(level);

		return "<?xml version='1.0'>\n" + doc.toXMLString();
	}
}