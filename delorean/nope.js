var container, stats;
var camera, scene, renderer, particles, geometry, materials = [], parameters, i, h, color, size;
var mouseX = 0, mouseY = 0;

var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;

var time = 0; // MEGAYEARS

init();
animate();

function init() {
  container = document.createElement( 'div' );
  document.body.appendChild( container );

  camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 3000 );
  //camera.position.z = 1000;
  scene = new THREE.Scene();
  geometry = new THREE.Geometry();
  $.getJSON('data/stars.json', function(stars) {
    window.star = stars[1];

    for (var i = 0; i < stars.length; i ++ ) {
      var star = stars[i];
      var coords = star.pos;
      var vertex = new THREE.Vector3();
      vertex.x = coords[0];
      vertex.y = coords[1];
      vertex.z = coords[2];
      vertex.velocities = star.speed;

      geometry.vertices.push( vertex );
    }
    material = new THREE.PointCloudMaterial( { size: 1 } );
    particles = new THREE.PointCloud( geometry, material );
    scene.add( particles );
  });

  renderer = new THREE.WebGLRenderer();
  renderer.setSize( window.innerWidth, window.innerHeight );
  container.appendChild( renderer.domElement );

  stats = new Stats();
  stats.domElement.style.position = 'absolute';
  stats.domElement.style.top = '0px';
  container.appendChild( stats.domElement );

  // document.addEventListener( 'mousemove', onDocumentMouseMove, false );
  // document.addEventListener( 'touchstart', onDocumentTouchStart, false );
  // document.addEventListener( 'touchmove', onDocumentTouchMove, false );

  //  window.addEventListener( 'resize', onWindowResize, false );
}

function updateVertices(geometry) {
  geometry.vertices.forEach(function(v) {
    v.x += (time * v.velocities[0]);
    v.y += (time * v.velocities[1]);
    v.z += (time * v.velocities[2]);
  });

  geometry.verticesNeedUpdate = true;
}

var frames  = 0;
function animate() {

  requestAnimationFrame( animate );

  frames = frames + 1;
  console.log(time);
  render();
  stats.update();
  if(scene.children[0] && (frames % 10 == 0)) {
    time = time + 0.01;
    updateVertices(scene.children[0].geometry);
  }
}

function render() {

  // var time = Date.now() * 0.00005;
  camera.position.z = 100;

  // camera.position.x += ( mouseX - camera.position.x ) * 0.05;
  // camera.position.y += ( - mouseY - camera.position.y ) * 0.05;

  // camera.lookAt( scene.position );

  // for ( i = 0; i < scene.children.length; i ++ ) {

  //   var object = scene.children[ i ];

  //   if ( object instanceof THREE.PointCloud ) {

  //     object.rotation.y = time * ( i < 4 ? i + 1 : - ( i + 1 ) );

  //   }

  // }

  renderer.render(scene, camera);

}

// function onWindowResize() {

//   windowHalfX = window.innerWidth / 2;
//   windowHalfY = window.innerHeight / 2;

//   camera.aspect = window.innerWidth / window.innerHeight;
//   camera.updateProjectionMatrix();

//   renderer.setSize( window.innerWidth, window.innerHeight );

// }

// function onDocumentMouseMove( event ) {

//   mouseX = event.clientX - windowHalfX;
//   mouseY = event.clientY - windowHalfY;

// }

// function onDocumentTouchStart( event ) {

//   if ( event.touches.length === 1 ) {

//     event.preventDefault();

//     mouseX = event.touches[ 0 ].pageX - windowHalfX;
//     mouseY = event.touches[ 0 ].pageY - windowHalfY;

//   }

// }

// function onDocumentTouchMove( event ) {

//   if ( event.touches.length === 1 ) {

//     event.preventDefault();

//     mouseX = event.touches[ 0 ].pageX - windowHalfX;
//     mouseY = event.touches[ 0 ].pageY - windowHalfY;

//   }

// }