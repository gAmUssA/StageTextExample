package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StageTextExample extends Sprite
	{
		public function StageTextExample()
		{
			super();
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, doLayout);
		}
		
		private var nt:NativeText;
		private var randomizeButton:Button;
		private var squareButton:Button;
		private var square:Sprite;
		
		private function doLayout(e:Event):void
		{
			this.removeChildren();
			
			this.nt = new NativeText(1);
			this.nt.fontSize = 30;
			this.nt.borderThickness = 2;
			this.nt.width = this.stage.stageWidth - (this.stage.stageWidth * .1);
			this.nt.x = (this.stage.stageWidth / 2) - (this.nt.width / 2);
			this.nt.y = (this.stage.stageHeight / 3) - (this.nt.height);
			this.addChild(this.nt);
			
			this.randomizeButton = new Button("Randomize");
			this.randomizeButton.x = ((this.stage.stageWidth / 2) - randomizeButton.width) - 10;
			this.randomizeButton.y = this.stage.stageHeight - this.randomizeButton.height - 10;
			this.randomizeButton.addEventListener(MouseEvent.CLICK, onRandomize);
			this.addChild(this.randomizeButton);
			
			this.squareButton = new Button("Toggle Square");
			this.squareButton.x = (this.stage.stageWidth / 2) + 10;
			this.squareButton.y = this.stage.stageHeight - this.squareButton.height - 10;
			this.squareButton.addEventListener(MouseEvent.CLICK, onToggleSquare);
			this.addChild(this.squareButton);
			
			this.square = new Sprite();
			this.square.graphics.beginFill(0xff0000);
			this.square.graphics.drawRect(0, 0, this.stage.stageWidth * .75, this.stage.stageHeight * .75);
			this.square.x = (this.stage.stageWidth / 2) - (this.square.width / 2);
			this.square.y = (this.stage.stageHeight / 2) - (this.square.height / 2);
		}
		
		private function onRandomize(e:MouseEvent):void
		{
			if (this.isSquareVisible()) this.onToggleSquare();
			this.nt.fontSize = this.getRandomWholeNumber(12, 40);
			this.nt.color = this.getRandomHex();
			this.nt.borderColor = this.getRandomHex();
			this.nt.borderThickness = this.getRandomWholeNumber(1, 5);
			this.nt.borderCornerSize = this.getRandomWholeNumber(0, 20);
			this.nt.width = this.getRandomWholeNumber(this.stage.stageWidth / 5, this.stage.stageWidth - 10);
			this.nt.x = this.getRandomWholeNumber(10, this.stage.stageWidth - this.nt.width);
			this.nt.y = this.getRandomWholeNumber(10, (this.randomizeButton.y - this.nt.height));
		}
		
		private function getRandomWholeNumber(min:Number, max:Number):Number
		{
			return Math.round(((Math.random() * (max - min)) + min));
		}
		
		private function getRandomHex():Number
		{
			return Math.round(Math.random() * 0xFFFFFF);
		}
		
		private function onToggleSquare(e:MouseEvent = null):void
		{
			if (this.isSquareVisible())
			{
				this.removeChild(this.square);
				this.nt.unfreeze();
			}
			else
			{
				this.nt.freeze();
				this.addChild(this.square);
			}
		}
		
		private function isSquareVisible():Boolean
		{
			return (this.square != null && this.contains(this.square));
		}
	}
}