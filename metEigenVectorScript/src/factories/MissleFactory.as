package  factories
{
	import flash.events.Event;
	import objects.ExplosionClass;
	import objects.MissleClass;
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class MissleFactory 
	{
		
		public static const ENEMY_1 : String = "enemy1";
		public static const PLAYER_MISSLE : String = "playerMissle";
		public static const EXPLOSION : String = "explosion";
		public function makeMissle(targetX:Number, targetY:Number, type:String, startX:Number, startY:Number, stageWidth : Number):MissleClass 
		{
			
			var missle : MissleClass;
			if (type == ENEMY_1)
			{
				missle = new MissleClass(targetX, targetY, Missle, Math.random() * stageWidth, -50 + Math.random() * 20);
			}
			else if(type == PLAYER_MISSLE)
			{

				missle = new MissleClass(targetX, targetY, PlayerMissle, startX, startY);
			}
			return missle;
		}
		
		public function makeExplosion(X:Number,Y:Number)
		{
			var explosion : ExplosionClass = new ExplosionClass;
			explosion.x = X;
			explosion.y = Y;
			return explosion;
		}
		
	}

}