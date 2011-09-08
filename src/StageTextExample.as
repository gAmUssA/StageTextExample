//  Adobe(R) Systems Incorporated Source Code License Agreement
//  Copyright(c) 2006-2011 Adobe Systems Incorporated. All rights reserved.
//	
//  Please read this Source Code License Agreement carefully before using
//  the source code.
//	
//  Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, 
//  no-charge, royalty-free, irrevocable copyright license, to reproduce,
//  prepare derivative works of, publicly display, publicly perform, and
//  distribute this source code and such derivative works in source or 
//  object code form without any attribution requirements.    
//	
//  The name "Adobe Systems Incorporated" must not be used to endorse or promote products
//  derived from the source code without prior written permission.
//	
//  You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
//  against any loss, damage, claims or lawsuits, including attorney's 
//  fees that arise or result from your use or distribution of the source 
//  code.
//  
//  THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT 
//  ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
//  BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  ALSO, THERE IS NO WARRANTY OF 
//  NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.  IN NO EVENT SHALL ADOBE 
//  OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
//  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.ReturnKeyLabel;
	
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
			this.nt.returnKeyLabel = ReturnKeyLabel.DONE;
			this.nt.autoCorrect = true;
			this.nt.fontSize = 40;
			this.nt.borderThickness = 1;
			this.nt.fontFamily = "Arial";
			this.nt.text = "This is native text.";
			this.nt.width = this.stage.stageWidth - (this.stage.stageWidth * .1);
			this.nt.x = (this.stage.stageWidth / 2) - (this.nt.width / 2);
			this.nt.y = (this.stage.stageHeight / 3) - (this.nt.height);
			this.addChild(this.nt);
			
			this.randomizeButton = new Button("Randomize", (this.stage.stageWidth / 2) - 20, Ruler.mmToPixels(Ruler.MIN_BUTTON_SIZE_MM), (Ruler.mmToPixels(Ruler.MIN_BUTTON_SIZE_MM) * .5));
			this.randomizeButton.x = ((this.stage.stageWidth / 2) - randomizeButton.width) - 10;
			this.randomizeButton.y = this.stage.stageHeight - this.randomizeButton.height - 10;
			this.randomizeButton.addEventListener(MouseEvent.CLICK, onRandomize);
			this.addChild(this.randomizeButton);
			
			this.squareButton = new Button("Square", (this.stage.stageWidth / 2) - 20, Ruler.mmToPixels(Ruler.MIN_BUTTON_SIZE_MM), (Ruler.mmToPixels(Ruler.MIN_BUTTON_SIZE_MM) * .5));
			this.squareButton.x = (this.stage.stageWidth / 2) + 10;
			this.squareButton.y = this.stage.stageHeight - this.squareButton.height - 10;
			this.squareButton.addEventListener(MouseEvent.CLICK, onToggleSquare);
			this.addChild(this.squareButton);
			
			this.square = new Sprite();
			this.square.graphics.beginFill(0xff0000, 1);
			this.square.graphics.drawRect(0, 0, this.stage.stageWidth * .8, this.randomizeButton.y * .9);
			this.square.x = (this.stage.stageWidth / 2) - (this.square.width / 2);
			this.square.y = (this.randomizeButton.y / 2) - (this.square.height / 2);
		}
		
		private function onRandomize(e:MouseEvent):void
		{
			if (this.isSquareVisible()) this.onToggleSquare();
			this.nt.fontSize = this.getRandomWholeNumber(12, 50);
			this.nt.color = this.getRandomHex();
			this.nt.borderColor = this.getRandomHex();
			this.nt.borderThickness = this.getRandomWholeNumber(1, 10);
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