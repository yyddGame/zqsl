package view
{
	
	import event.GameEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.DisplayTool;
	
	public class ControlView extends Sprite
	{
		private var attackBtn:Button;
		private var defBtn:Button;
		private var specialBtn:Button;
		public function ControlView()
		{
			super();
			
			var texture:Texture = DisplayTool.createTexture(50,50,true,0x00ff00);
				
			attackBtn = DisplayTool.createButton(texture,"攻击");
			addChild(attackBtn);
			
			defBtn = DisplayTool.createButton(texture,"防御");
			addChild(defBtn);
			defBtn.x = 100;
			
			
			specialBtn = DisplayTool.createButton(texture,"大招");
			addChild(specialBtn);
			specialBtn.x = 50;
			specialBtn.y = -100;
			addEvent();
		}
		
		private function addEvent():void
		{
			attackBtn.addEventListener(Event.TRIGGERED,clkBtnHandler);
			defBtn.addEventListener(Event.TRIGGERED,clkBtnHandler);
			specialBtn.addEventListener(Event.TRIGGERED,clkBtnHandler);
		}
		
		private function clkBtnHandler(e:Event):void
		{
			var btnName:String = (e.target as Button).text;
			dispatchEvent(new GameEvent(GameEvent.CONTROL_ACTION,false,btnName));
			
		}
	}
}