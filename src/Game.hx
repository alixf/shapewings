import hxd.Res;
import hxd.Event;
import h3d.scene.*;
import h3d.*;
import h3d.col.*;
import h3d.prim.*;

class Game extends hxd.App {

	public static var instance(default, null) : Game;
	public static var assets(default, null) : ModelCache;

	var cache : ModelCache;
	public var ship : Ship;
	var ground : CustomObject;
	var bullets = new Array<Bullet>();
	public var enemies = new Array<Enemy>();
	public var animations = new Array<Float -> Bool>();
	var ui : UI;
	var levels : Levels;
	public var gameOver(default, null) = false;
	var clouds : Clouds;

	override function init() {
		Enemy.preload();

		instance = this;
		assets = new ModelCache();
		engine.backgroundColor = 0xFF0080FF;

		// Camera setup
		s3d.camera.pos.set(0, 0, 0);
		s3d.camera.target.set(0, 0, 1);
		s3d.camera.up.set(0, 1, 0);

		ship = new Ship();
		s3d.addChild(ship.sceneObject);

		var gridMesh = new h3d.prim.Grid(1, 1);
		gridMesh.uvs = [for( y in 0...2 ) for( x in 0...2 ) new h3d.prim.UV(x, 1-y)];
		gridMesh.addNormals();
		var sky = new h3d.scene.CustomObject(gridMesh, new h3d.mat.Material(new shaders.BaseTexturedMesh()));
		sky.material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1,1);
		sky.material.mainPass.getShader(shaders.BaseTexturedMesh).ambient = new h3d.Vector(1,1,1,1);
		sky.material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = hxd.Res.sky.toTexture();
		sky.name = "Sky";
		s3d.addChild(sky);
		sky.setScale(100);
		sky.setPos(-50, -50, 100);

		var groundTexture = hxd.Res.ground.toTexture();
		var gridMesh = new h3d.prim.Grid(1, 1);
		gridMesh.uvs = [for( y in 0...2 ) for( x in 0...2 ) new h3d.prim.UV(x * 1, (1-y) * 1)];
		ground = new h3d.scene.CustomObject(gridMesh, new h3d.mat.Material(new shaders.GroundShader()));
		ground.material.mainPass.getShader(shaders.GroundShader).color = new h3d.Vector(1,1,1,1);
		ground.material.mainPass.getShader(shaders.GroundShader).diffuse = groundTexture;
		ground.name = "Ground";
		s3d.addChild(ground);
		ground.setScale(20);
		ground.setPos(-10, -1, 20);
		ground.rotate(-Math.PI / 2, 0, 0);

		// UI
		ui = new UI(s2d);
		ship.onHPChange = ui.setHP;
		ship.onShieldChange = ui.setShield;
		ship.onPowerUpChange = ui.setPowerUp;
		ship.onSwitchShape = ui.switchShape;

		levels = new Levels();

		clouds = new Clouds();
		s3d.addChild(clouds.sceneObject);

		// add lights and setup materials
		var dir = new DirLight(new Vector( -1, 3, -10), s3d);
		dir.name = "Directional Light";
		s3d.lightSystem.ambientLight.set(0.1, 0.1, 0.5);
		var shadow = cast(s3d.renderer.getPass("shadow"), h3d.pass.ShadowMap);
		shadow.power = 20;
		dir.enableSpecular = true;
		hxd.Stage.getInstance().addEventTarget(onEvent);
	}

	public function shakeCamera(duration : Float) : Void {
		var clock = 0.0;
		animations.push(function(dt : Float) {
			clock += dt;
			s3d.camera.pos.set(s3d.camera.pos.x, s3d.camera.pos.y + Math.sin(clock) * 0.002, s3d.camera.pos.z);
			return clock >= duration;
		});
	}

	public function addBullet(bullet : Bullet) : Void {
		bullets.push(bullet);
		s3d.addChild(bullet.sceneObject);
	}

	public function addEnemy(enemy : Enemy) : Void {
		enemies.push(enemy);
		s3d.addChild(enemy.sceneObject);
	}

	var clock = 0.0;
	var enemySpawnClock = 0.0;
	override function update(dt : Float) {

		// update ship, enemies and bullets
		ship.update(dt);
		for(enemy in enemies) {
			enemy.update(dt);
		}
		for(bullet in bullets) {
			bullet.update(dt);
			bullet.checkCollisionWithEnemies(enemies, ship);
		}

		// Check dead bullets
		for(bullet in bullets) {
			if(!bullet.alive) {
				s3d.removeChild(bullet.sceneObject);
				bullets.remove(bullet);
			}
		}
		// Check dead enemies
		for(enemy in enemies) {
			if(!enemy.alive) {
				shakeCamera(10);
				s3d.removeChild(enemy.sceneObject);
				enemies.remove(enemy);
			}
		}

		levels.update(dt);

		// move the camera along with the player's ship
		s3d.camera.pos.set(-ship.sceneObject.x / 10, -ship.sceneObject.y / 10, 0);

		if(ship.hp <= 0 && !gameOver) {
			gameOver = true;
			ship.canMove = false;
			ui.showGameOver();
		}

		// play animations
		for(animation in animations) {
			var finished = animation(dt);
			if(finished)
				animations.remove(animation);
		}

		clouds.update(dt);
	}

var titleOk = false;
	public function onEvent(e : Event) {
		ship.onEvent(e);
		ui.onEvent(e);
		if(e.kind == EKeyDown && e.keyCode == 88) {
			printSceneGraph();
		}

	    switch(e.kind) {
	      case EKeyDown :
	        switch(e.keyCode) {
	          case 13: // Enter
	            if(!titleOk) {
	              titleOk = true;
	            } else {
								if(gameOver) {
									restart();
									ui.hideGameOver();
									gameOver = false;
									ship.canMove = false;
								}
								if(ship.canMove == false) {
									ship.canMove = true;
									levels.startLevel(0);
								}
	            }
						case 88 : printSceneGraph(); // X
	          default :
	        }
	        default:
	    }
	}

	function restart() {
		for(bullet in bullets)
				s3d.removeChild(bullet.sceneObject);
		for(enemy in enemies)
				s3d.removeChild(enemy.sceneObject);
		bullets = new Array<Bullet>();
		enemies = new Array<Enemy>();
		ship.restart();
		animations = new Array<Float -> Bool>();
	}

	function printSceneGraph(?target : h3d.scene.Object, ?level : Int) {
		if(target == null)
			target = s3d;
		if(level == null)
			level = 0;
		for(i in 0...target.numChildren) {
			var child = target.getChildAt(i);
			var spacing = "";
			for(j in 0...level)
				spacing += "  ";
			trace(spacing+"- "+child.name+" - "+Type.getClassName(Type.getClass(child))
				+" - ("+child.x+", "+child.y+", "+child.z+")");
			printSceneGraph(child, level+1);
		}
	}

	public function cleanEnemiesAndBullets() : Void {
		for(enemy in enemies)
			enemy.alive = false;
		for(bullet in bullets)
			bullet.alive = false;
	}

	static function main() {
		Res.initEmbed();
		new Game();
	}
}
