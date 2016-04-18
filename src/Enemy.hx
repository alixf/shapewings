class Enemy {

    public var sceneObject = new h3d.scene.Object();
    var speed = new h3d.Vector(0,0,-0.05);

    public var alive = true;
    public var hp = 5;
    var reward = 7.5;
    public var type : Int;
    public var stopAt = -100.0;

    static var textures : Array<h3d.mat.Texture>;
    static var shootSounds : Array<hxd.res.Sound>;
    static var crashSound : hxd.res.Sound;

    static var hitSound : hxd.res.Sound;
    static var blockSound : hxd.res.Sound;

    public static function preload() {
        if(hitSound == null)
          hitSound = hxd.Res.hit;
        if(blockSound == null)
          blockSound = hxd.Res.block;

        if(textures == null) {
          textures = [
            hxd.Res.enemy2_0.toTexture(),
            hxd.Res.enemy2_1.toTexture(),
            hxd.Res.enemy2_2.toTexture()
          ];
        }
        if(shootSounds == null) {
          shootSounds = [hxd.Res.shoot, hxd.Res.shoot2, hxd.Res.shoot3];
        }
        if(crashSound == null) {
          crashSound = hxd.Res.crash1;
        }
    }

    public function new(type : Int) {


      sceneObject.name = "Enemy";
      this.type = type;
      var shipMesh : h3d.scene.Mesh = cast Game.assets.loadModel(hxd.Res.enemy2);
      var material = new h3d.mat.Material(new shaders.BaseTexturedMesh());
      material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1,1);
      material.mainPass.getShader(shaders.BaseTexturedMesh).ambient = new h3d.Vector(0.5,0.5,0.5,1);
      material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = textures[type];
      var shipModel = new h3d.scene.CustomObject(shipMesh.primitive, material);
      shipModel.scale(0.1);
      shipModel.rotate(0, Math.PI, 0);
  		sceneObject.addChild(shipModel);
      sceneObject.setPos(0, 0, 3);
    }

    public function update(dt : Float) : Void {
      if(sceneObject.z > stopAt)
        sceneObject.setPos(sceneObject.x + speed.x * dt, sceneObject.y + speed.y * dt, sceneObject.z + speed.z * dt);

      cooldownClock += dt;
      shoot();

      if(sceneObject.z < 2.5)
        alive = false;
    }

    public function takeDamage(bullet : Bullet) : Void {
      if(bullet.type == type) {
        hp--;
        if(hp <= 0) {
          alive = false;
          Game.instance.ship.powerUp += reward;
          crashSound.play(false, 0.66);
        } else {
          hitSound.play(false, 0.5);
        }
      } else {
        blockSound.play(false, 0.5);
      }
    }


    public var cooldownClock = 0.0;
    public var cooldown = 120.0;
    function shoot() {

      if(cooldownClock <= cooldown || Game.instance.gameOver)
        return;

      shootSounds[Std.random(shootSounds.length)].play(false, 0.4);
      cooldownClock = 0.0;
      var shipPosition = new h3d.Vector(Game.instance.ship.sceneObject.x, Game.instance.ship.sceneObject.y, Game.instance.ship.sceneObject.z);
      var enemyPosition = new h3d.Vector(sceneObject.x, sceneObject.y, sceneObject.z);
      enemyPosition = enemyPosition.sub(shipPosition);
      enemyPosition.normalize();
      enemyPosition.scale3(-0.15);
      var bullet = new Bullet(-1, enemyPosition);
      bullet.sceneObject.setPos(sceneObject.x, sceneObject.y, sceneObject.z);
      Game.instance.addBullet(bullet);
    }

}
