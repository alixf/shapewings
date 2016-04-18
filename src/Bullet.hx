class Bullet {

    public var sceneObject = new h3d.scene.Object();
    var speed : h3d.Vector;

    public var alive = true;
    public var type : Int;

    var prim = cast(Game.assets.loadModel(hxd.Res.bullet), h3d.scene.Mesh).primitive;


    public function new(type : Int, speed : h3d.Vector) {


      sceneObject.name = "Bullet";
      this.type = type;
      this.speed = speed;
      var material = new h3d.mat.Material(new shaders.MeshShader());
      var bulletModel = new h3d.scene.CustomObject(prim, material);
      bulletModel.setScale(0.05);
      bulletModel.scaleY *= 3;
      bulletModel.rotate(Math.PI / 2, 0, 0);
  		sceneObject.addChild(bulletModel);
      material.mainPass.getShader(shaders.MeshShader).color = switch(type) {
        case 0 : new h3d.Vector(0,0.8,1,0.8);
        case 1 : new h3d.Vector(0.2,0.95,0.2,0.8);
        case 2 : new h3d.Vector(1,0.2,0.1,0.8);
        default : new h3d.Vector(1,0.95,0.5,0.8);
      };
    }


    public function update(dt : Float) : Void {
      sceneObject.setPos(sceneObject.x + speed.x * dt, sceneObject.y + speed.y * dt, sceneObject.z + speed.z * dt);
      if(sceneObject.z < 0.0 || sceneObject.z > 100.0)
        alive = false;
    }

    public function checkCollisionWithEnemies(enemies : Array<Enemy>, ship : Ship) {
      if(type < 0) {
          if(!ship.rolling && sceneObject.getBounds().collide(ship.sceneObject.getBounds())) {
            ship.takeDamage(this);
            alive = false;
          }
          return;
      }

      for(enemy in enemies) {
        if(sceneObject.getBounds().collide(enemy.sceneObject.getBounds())) {
          enemy.takeDamage(this);
          alive = false;
          return;
        }
      }
    }
}
