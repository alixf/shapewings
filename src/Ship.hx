class Ship
{
  public var sceneObject = new h3d.scene.Object();
	var speed = new h3d.Vector(0,0,0,0);
	var acceleration = new h3d.Vector(0,0,0,0);
  var shooting = false;
  var shipModel : h3d.scene.CustomObject;

  var meshes : Array<h3d.scene.Mesh>;
  var textures : Array<h3d.mat.Texture>;
  var shield : h3d.scene.CustomObject;
  public var canMove = false;

  public var onHPChange : Int -> Void;
  public var onShieldChange : Int -> Void;
  public var onPowerUpChange : Float -> Void;
  public var onSwitchShape : Int -> Void;

  public var hp(default, set) = 3;
  public function set_hp(value : Int) : Int {
    crashSound.play(false, value > 0 ? 0.1 : 0.66);
    hp = cast Math.max(0, value);
    if(onHPChange != null) {
      onHPChange(hp);
    }
    return hp;
  };

  var shiftClock = 0.0;
  // PowerUps
  public var powerUp(default, set) = 0.0;
  public function set_powerUp(value : Float) : Float {
    powerUp = Math.min(100, value);
    if(onPowerUpChange != null)
      onPowerUpChange(powerUp);
    return powerUp;
  };
  var hasDoubleShot = false;
  var shieldCharges(default, set) = 0;
  public function set_shieldCharges(value : Int) : Int{
    shieldCharges = value;
    shield.setScale(shieldCharges > 0 ? 0.33 : 0);
    if(onShieldChange != null)
      onShieldChange(shieldCharges);
    return shieldCharges;
  };
  var hasTripleShot = false;
  var hasBomb = false;

  var shootSounds = new Array<hxd.res.Sound>();
  var crashSound : hxd.res.Sound;

  public function new() {

    sceneObject.name = "Ship";
    meshes = [cast Game.assets.loadModel(hxd.Res.ship),
              cast Game.assets.loadModel(hxd.Res.ship2),
              cast Game.assets.loadModel(hxd.Res.ship3)];
    textures = [hxd.Res.ship1Texture.toTexture(),
                hxd.Res.ship2Texture.toTexture(),
                hxd.Res.ship3Texture.toTexture()];
    shootSounds = [hxd.Res.shoot, hxd.Res.shoot2, hxd.Res.shoot3];
    crashSound = hxd.Res.crash2;

    var material = new h3d.mat.Material(new shaders.BaseTexturedMesh());
    shipModel = new h3d.scene.CustomObject(meshes[0].primitive, material);
    shipModel.scale(0.17);
    shipModel.rotate(Math.PI / 2, 0,  Math.PI);
		sceneObject.addChild(shipModel);
    sceneObject.setPos(0, -0.5, 3);
    material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1,1);
    material.mainPass.getShader(shaders.BaseTexturedMesh).ambient = new h3d.Vector(0.25,0.25,0.25,1);
    material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = textures[0];

    var shieldMaterial = new h3d.mat.Material(new shaders.MeshShader());
    shieldMaterial.mainPass.getShader(shaders.MeshShader).color = new h3d.Vector(0, 0.33, 1, 0.33);
    shieldMaterial.mainPass.blend(SrcAlpha, OneMinusSrcAlpha);
    var shieldSphere = new h3d.prim.Sphere(1,32,32);
    shieldSphere.addNormals();
    shield = new h3d.scene.CustomObject(shieldSphere, shieldMaterial);
    shield.setScale(0.0);
    sceneObject.addChild(shield);

  }

  public function restart() {
    shieldCharges = 0;
    hp = 3;
    hasDoubleShot = false;
    hasTripleShot = false;
    shooting = false;
    shiftIndex = 0;
    shipModel.primitive = meshes[0].primitive;
    shipModel.material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = textures[0];
    sceneObject.setPos(0, -0.5, 3);
    acceleration = new h3d.Vector(0,0,0,0);
    speed = new h3d.Vector(0,0,0,0);
    powerUp = 0.0;
  }

  var shiftIndex = 0;

  public function shift(direction : Int) : Void {
    shiftIndex = (shiftIndex + (-direction) + meshes.length) % meshes.length;
    shipModel.primitive = meshes[shiftIndex].primitive;
    shipModel.material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = textures[shiftIndex];
    shifted = true;

    if(onSwitchShape != null)
      onSwitchShape(shiftIndex);

    hasDoubleShot = false;
    shieldCharges = 0;
    hasTripleShot = false;

    shiftClock = 0.0;
    if(powerUp >= 25) {
      hasDoubleShot = true;
    }
    if(powerUp >= 50) {
      shieldCharges = 3;
    }
    if(powerUp >= 75) {
      hasTripleShot = true;
    }
    if(powerUp >= 100) {
      Game.instance.cleanEnemiesAndBullets();
    }

    powerUp = 0.0;
  }


  public function update(dt : Float) : Void {

    if((sceneObject.x <= -movementRangeX && acceleration.x < 0) || (sceneObject.x >= movementRangeX && acceleration.x > 0))
      acceleration.x = 0;
    if((sceneObject.y <= -movementRangeY && acceleration.y < 0) || (sceneObject.y >= movementRangeY && acceleration.y > 0))
      acceleration.y = 0;


    if(hp <= 0)
      acceleration.y = -0.5;


    if(acceleration.length() != 0) {
			speed.x += acceleration.x * dt * accelerationFactor;
			speed.y += acceleration.y * dt * accelerationFactor;
    } else {
			drag(dt);
    }

    if(speed.length() > maxSpeed) {
      speed.normalize();
      speed.scale3(maxSpeed);
    }

    sceneObject.setRotate(-speed.y * 0.75, 0, -speed.x * 0.5);

		sceneObject.x += speed.x * dt * speedFactor;
		sceneObject.y += speed.y * dt * speedFactor;

    cooldownClock += dt;
    if(shooting && hp > 0)
      shoot();

    barrelRollLeftClock += dt;
    barrelRollRightClock += dt;
    if(rolling)
      rollAnimation(dt);
  }

  var shifted = false;
  var rollAnimationClock = 0.0;
  var rollAnimationFactor = 1.0;
  function rollAnimation(dt : Float) {
    rollAnimationClock += dt;
    var animationFactor = rollAnimationClock / 45;

    if(animationFactor > 0.2 && !shifted)
      shift(cast rollAnimationFactor);
    if(animationFactor > 1.0) {
      shifted = false;
      rolling = false;
      rollAnimationClock = 0.0;
      sceneObject.setRotate(0, 0, 0);
    } else {
      sceneObject.setRotate(0, 0, rollAnimationFactor * Math.PI * 2 * Math2.easeOutBack(animationFactor,0,1,1));
    }
  }

  var dragFactor = 0.02;
  var accelerationFactor = 0.1;
  var speedFactor = 0.1;
  var maxSpeed = 0.33;
  var movementRangeX = 0.6;
  var movementRangeY = 0.31;

  public function drag(dt : Float) {
    if(speed.x > 0) {
      speed.x -= dt * dragFactor;
      if(speed.x < 0)
        speed.x = 0;
    }
    if(speed.x < 0) {
      speed.x += dt * dragFactor;
      if(speed.x > 0)
        speed.x = 0;
    }
    if(speed.y > 0) {
      speed.y -= dt * dragFactor;
      if(speed.y < 0)
        speed.y = 0;
    }
    if(speed.y < 0) {
      speed.y += dt * dragFactor;
      if(speed.y > 0)
        speed.y = 0;
    }
  }

  var cooldown = 10.0;
  var cooldownClock = 0.0;
  function shoot() {
    if(cooldownClock <= cooldown || rolling)
      return;

    shootSounds[Std.random(shootSounds.length)].play(false, 0.2);
    cooldownClock = 0.0;
    if(hasTripleShot) {
      var bullet1 = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      var bullet2 = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      var bullet3 = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      bullet1.sceneObject.setPos(sceneObject.x - 0.1, sceneObject.y, sceneObject.z);
      bullet2.sceneObject.setPos(sceneObject.x + 0.1, sceneObject.y, sceneObject.z);
      bullet3.sceneObject.setPos(sceneObject.x, sceneObject.y + 0.1, sceneObject.z);
      Game.instance.addBullet(bullet1);
      Game.instance.addBullet(bullet2);
      Game.instance.addBullet(bullet3);
    } else if(hasDoubleShot) {
      var bullet1 = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      var bullet2 = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      bullet1.sceneObject.setPos(sceneObject.x - 0.15, sceneObject.y, sceneObject.z);
      bullet2.sceneObject.setPos(sceneObject.x + 0.15, sceneObject.y, sceneObject.z);
      Game.instance.addBullet(bullet1);
      Game.instance.addBullet(bullet2);
    } else {
      var bullet = new Bullet(shiftIndex, new h3d.Vector(0, 0, 0.8));
      bullet.sceneObject.setPos(sceneObject.x, sceneObject.y, sceneObject.z);
      Game.instance.addBullet(bullet);
    }
  }

  var barrelRollLeftClock = 0.0;
  var barrelRollLeftStep = 0;
  var barrelRollRightClock = 0.0;
  var barrelRollRightStep = 0;
  public var rolling = false;
  function handleBarrelRoll(right : Bool, keyPressed : Bool) {
    if(barrelRollLeftClock > 15.0) {
      barrelRollLeftStep = 0;
    }
    if(barrelRollRightClock > 15.0) {
      barrelRollRightStep = 0;
    }
    if(!rolling) {
      if(right) {
        if(barrelRollLeftStep == 0 && keyPressed) {
          barrelRollLeftClock = 0.0;
          barrelRollLeftStep++;
        }
        if(barrelRollLeftStep == 1 && !keyPressed) {
          barrelRollLeftClock = 0.0;
          barrelRollLeftStep++;
        }
        if(barrelRollLeftStep == 2 && keyPressed) {
          barrelRollLeftClock = 0.0;
          barrelRoll(right);
          rollAnimationFactor = -1.0;
        }
      }
      else {
        if(barrelRollRightStep == 0 && keyPressed) {
          barrelRollRightClock = 0.0;
          barrelRollRightStep++;
        }
        if(barrelRollRightStep == 1 && !keyPressed) {
          barrelRollRightClock = 0.0;
          barrelRollRightStep++;
        }
        if(barrelRollRightStep == 2 && keyPressed) {
          barrelRollRightClock = 0.0;
          barrelRoll(right);
          rollAnimationFactor = 1.0;
        }
      }
    }
  }

  public function barrelRoll(right : Bool) {
    rolling = true;
  }

  public function takeDamage(bullet : Bullet) {
    if(shieldCharges > 0) {
      shieldCharges--;
    } else {
      hp--;
    }
    Game.instance.shakeCamera(20);
  }

  public function onEvent(e : hxd.Event) : Void {
    if(canMove) {
      switch(e.kind) {
  			case EKeyDown :
  				switch(e.keyCode) {
  					case 37: acceleration.x += -1; handleBarrelRoll(false, true); // Left
  					case 38: acceleration.y += 1; // Up
  					case 39: acceleration.x += 1; handleBarrelRoll(true, true); // Right
  					case 40: acceleration.y += -1;// Right
  					case 32: shooting = true; // Space
  					default :  barrelRollRightStep = 0;
  				}
  				case EKeyUp :
  					switch(e.keyCode) {
  						case 37: acceleration.x = 0; handleBarrelRoll(false, false); // Left
  						case 38: acceleration.y = 0; // Up
  						case 39: acceleration.x = 0; handleBarrelRoll(true, false); // Right
  						case 40: acceleration.y = 0; // Down
    					case 32: shooting = false;// Space
  						default : trace('unhandled keycode : ${e.keyCode}');
  					}
  				default :
  		}
    }
  }
}
