package
{
	import flash.text.TextField;
	
	import starling.display.Sprite;
	
	public class ExButton extends Sprite
	{
		private var skin:Sprite;
		private var label:TextField;
		public function ExButton()
		{
			super();
			skin = new Sprite();
			
			addChild(skin);
			
			label = new TextField();
			label.width = 60;
			label.height = 22;
		}
		public function setLabel(str:String):void{
		  label.text = str;
		}
	}
}