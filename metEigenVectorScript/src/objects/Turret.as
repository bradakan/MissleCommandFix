package  objects
{
	
	import flash.display.MovieClip;
	import utils.MathVector;
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Turret extends MovieClip
	{
		var _location : MathVector;
		var _turret : PlayerShootPoint;
		var _barrel : Barrel;
		var _distanceToMouse : MathVector;
		var _rotationRadians : Number;
		
		public function Turret(x:Number,y:Number) 
		{
			_distanceToMouse = new MathVector(0,0);
			_turret = new PlayerShootPoint();
			_barrel = new Barrel();
			this.x = x;
			this.y = y;
			_location = new MathVector(this.x, this.y);
			addChild(_turret);
			addChild(_barrel);
		}
		
		public function update():void
		{
			//difference between mouse and the barrel wich has to rotate
			_distanceToMouse.dx = _barrel.x - mouseX;
			_distanceToMouse.dy = _barrel.y - mouseY;
			//getting the radians
			_rotationRadians = Math.atan2(_distanceToMouse.dx, _distanceToMouse.dy);
			//making degrees of the radians
			_barrel.rotation = - _rotationRadians * (180 / Math.PI);
		}
	}

}