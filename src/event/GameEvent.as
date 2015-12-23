package event
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		public static const CONTROL_ACTION:String = "CONTROL_ACTION";
		
		public function GameEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}