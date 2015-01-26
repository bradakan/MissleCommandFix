package objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Car extends Sprite 
	{
		private var _car:CarSprite;
		private var _speed:int = 5;
		
		public function Car() 
		{
			_car = new CarSprite();
			addChild(_car);
		}
		
		public function update()
		{
			this.x += _speed;
			if (this.x >= stage.stageWidth - this.width / 2)
			{
				_speed = -_speed
				this.scaleX = -scaleX;
			}
			else if (this.x <= this.width /2)
			{
				this.scaleX = -scaleX;
				_speed = -_speed;
			}
		}
		
		
	}

}