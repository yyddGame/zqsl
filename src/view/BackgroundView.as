package view
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	/**
	 * 背景层
	 */	
	public class BackgroundView extends Sprite
	{
		[Embed(source = "/../outSource/bg/1.png")]
		public var bg1:Class;
		[Embed(source = "/../outSource/bg/1.png")]
		public var bg2:Class;
		
		private var imgContainer:Sprite;
		private var inBoundary:Boolean;
		
		public function BackgroundView()
		{
			super();
			
			imgContainer = new Sprite();
			addChild(imgContainer);
			
			var img1:Image;
			var img2:Image;
			img1 = new Image(Texture.fromBitmap(new bg1()));
			imgContainer.addChild(img1);
			
			img2 = new Image(Texture.fromBitmap(new bg2()));
			imgContainer.addChild(img2);
			img2.x = img1.x + img1.width;
		}
		
		public function move(direction:int):void
		{
			inBoundary = false;
			if(direction == 1)
			{
				if(imgContainer.x >=0)
				{
					imgContainer.x = 0;
					inBoundary = true
					return;
				}
				imgContainer.x +=5;
			}
			else
			{
				if(imgContainer.x <= stage.stageWidth - imgContainer.width)
				{
					imgContainer.x = stage.stageWidth - imgContainer.width;
					inBoundary = true
					return;
				}
				imgContainer.x -=5;
				
			}
			
		}
		public function get isInboundary():Boolean{
			return inBoundary;
		}
	}
}