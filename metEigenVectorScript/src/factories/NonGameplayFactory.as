package factories 
{
	import objects.Car;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class NonGameplayFactory 
	{
		
		public static const CAR:String = "car";
		private var car:Car;
		
		
		public function makeCar(stageWidth:int, stageheight:int)
		{
			car = new Car();
			car.x = Math.random() * stageWidth;
			car.y = stageheight;
			return car;
		}

	}

}