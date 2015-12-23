package utils
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.textures.Texture;

	public class DisplayTool
	{
		public function DisplayTool()
		{
		}
		
		public static function createQuad(w:Number,h:Number,color:uint,isAlpha:Boolean = true):Quad
		{
			var quad:Quad = new Quad(w,h,color,isAlpha);
			return quad;
		}
		
		/**
		 * 创建一个Button
		 * @param upState
		 * @param text
		 * @param downState
		 * @param overState
		 * @param disabledState
		 * @return 
		 * 
		 */		
		public static function createButton(upState:Texture, text:String="", downState:Texture=null,overState:Texture=null, disabledState:Texture=null):Button											
		{
			var button:Button = new Button(upState,text,downState,overState,disabledState);			
			return button;
		}
		
		/**
		 * 创建一个Texture
		 * @param w
		 * @param h
		 * @param transparent
		 * @param color
		 * @return 
		 * 
		 */		
		public static function createTexture(w:Number,h:Number,transparent:Boolean = true,color:uint = 0):Texture
		{
			var bdata:BitmapData = createBitmapData(w,h,transparent,color);
			var shape:Shape = createShape(w,h,color);
			bdata.draw(shape);
			var texture:Texture = Texture.fromBitmapData(bdata);			
			return texture;
		}
		
		/**
		 *创建一个BitmapData 
		 * @param w
		 * @param h
		 * @param transparent
		 * @param color
		 * @return 
		 * 
		 */		
		public static function createBitmapData(w:Number,h:Number,transparent:Boolean,color:uint):BitmapData
		{
			var bdata:BitmapData = new BitmapData(w,h,transparent,color);			
			return bdata;
		}
		
		public static function createShape(w:Number,h:Number,color:uint,alpha:Number = 1):Shape
		{
			var shape:Shape = new Shape();	
			shape.graphics.clear();
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0,0,w,h);
			shape.graphics.endFill();
			shape.alpha = alpha;
			return shape;
		}
		
		
	}
}