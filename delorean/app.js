var ExampleApplication = React.createClass({
  render: function() {
    var elapsed = Math.round(this.props.elapsed  / 100);
    var seconds = elapsed / 10 + (elapsed % 10 ? '' : '.0' );
    var message =
      'React has been successfully running for ' + seconds + ' seconds.';

    return <p>{message}</p>;
  }
});

var start = new Date().getTime();

setInterval(function() {
  React.render(
    <ExampleApplication elapsed={new Date().getTime() - start} />,
    document.getElementById('container')
  );
}, 50);

var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

var renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

// create the particle variables
var particleCount = stars.length,
    particles = new THREE.Geometry(),
    pMaterial = new THREE.PointCloudMaterial({
      color: 0xFFFFFF,
      size: 20000
    });

function write_new_coords(star, date) {

}
var time = 0;

// now create the individual particles
for (var p = 0; p < particleCount; p++) {
  var star = stars[p];
  var coords = star['pos'];
  console.log(coords);

  var velocities = star['speed']
  console.log(velocities)


  var pX = coords[0] * ,
      pY = coords[1],
      pZ = coords[2],
      particle = new THREE.Particle(
        new THREE.Vector3(pX, pY, pZ)
      );

  // add it to the geometry
  particles.vertices.push(particle);
}
console.log(particles.vertices);
// create the particle system
var particleSystem = new THREE.PointCloud(
    particles,
    pMaterial);
var geometry = new THREE.BoxGeometry( 1, 1, 1 );
var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );

camera.position.z = 5;

// add it to the scene
scene.add(particleSystem);

function render() { 
  requestAnimationFrame( render );
  renderer.render( scene, camera );
}
render();

