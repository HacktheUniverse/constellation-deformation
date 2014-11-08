var camera, scene, renderer, group, particle;

var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

var renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );
console.log('cats');
$.getJSON('data/stars.json', function(stars) {
//.fail(function(data) {
  console.log(stars);
 // var stars = JSON.parse(data.responseText);
// create the particle variables
var particleCount = stars.length,
    particles = new THREE.Geometry(),
    pMaterial = new THREE.PointCloudMaterial({
      color: 0xFFFFFF,
      size: 20000
    });

function write_new_coords(star, date) {

}
var time = 0; //THE UNITS ARE MEGAYEARS.
// now create the individual particles
for (var p = 0; p < particleCount; p++) {
  var star = stars[p];
  var coords = star['pos'];
  var velocities = star['speed'];

  var pX = coords[0] + (time * velocities[0]),
      pY = coords[1] + (time * velocities[1]),
      pZ = coords[2] + (time * velocities[2]),

      particle = new THREE.Particle(
        new THREE.Vector3(pX, pY, pZ)
      );

  var distance = Math.sqrt(Math.pow(pX,2) + Math.pow(pY,2) + Math.pow(pZ,2));
 // var flux = star.lum / (4*3.14 (Math.pow(distance,2)));

  particles.vertices.push(particle);
}

//scene.add(particles);

// create the particle system
var particleSystem = new THREE.PointCloud(
    particles,
    pMaterial);

var geometry = new THREE.BoxGeometry( 1, 1, 1 );

var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );

// camera.position.z = 5;

// add it to the scene
scene.add(particleSystem);
//scene.add(particles)
function render() { 
  requestAnimationFrame( render );
  renderer.render( scene, camera );
}
render();
});
