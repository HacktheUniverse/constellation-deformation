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
  scene.fog = new THREE.FogExp2(0x000000, 0.0007);
  geometry = new THREE.Geometry();
  var orion = 
  $.getJSON('data/stars.json', function(stars) {

    window.star = stars[1];

    for (var i = 0; i < stars.length; i ++ ) {
      var star = stars[i];
      var coords = star.pos;
      var vertex = new THREE.Vector3();
      vertex.x = coords[0];
      vertex.y = coords[1];
      vertex.z = coords[2];
      vertex.x0 = coords[0];
      vertex.y0 = coords[1];
      vertex.z0 = coords[2];
      vertex.velocities = star.speed;

      geometry.vertices.push( vertex );
    }
    material = new THREE.PointCloudMaterial( { size: 3, sizeAttenuation:false } );
    particles = new THREE.PointCloud( geometry, material );
    scene.add( particles );
  }).fail(function(error){
    console.log(error)
  })

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
    v.x = (v.x0 + time * v.velocities[0]);
    v.y = (v.y0 + time * v.velocities[1]);
    v.z = (v.z0 + time * v.velocities[2]);
  });

  geometry.verticesNeedUpdate = true;
}

var frames  = 0;

  
$('input[type="range"]').rangeslider({

      // Feature detection the default is `true`.
      // Set this to `false` if you want to use
      // the polyfill also in Browsers which support
      // the native <input type="range"> element.
      polyfill: true,

      // Default CSS classes
      rangeClass: 'rangeslider',
      fillClass: 'rangeslider__fill',
      handleClass: 'rangeslider__handle',

      // Callback function

      // Callback function
      onSlide: animate

      
  });

function getBaseLog(x, y) {
    return Math.log(y) / Math.log(x);
}

function scale_time(value) {
  //if -1 return -10E-6
  //if 1 return 10E-6
  //2 return 10E-5
  //3 
  var is_negative = time < 0;

  var one_year = Math.pow(10, -6);
  var log_input = Math.pow(10, Math.abs(value))

  if (is_negative)  { log_input * -1;}
  return one_year * log_input;
}

function animate() {
  var value = document.getElementById("time_slider").value
  console.log(value);
  // console.log(value)
  time = scale_time(value)
  console.log(time)
  requestAnimationFrame( animate );

  frames = frames + 1;
  render();
  stats.update();
  
  if(scene.children[0] && (frames % 10 == 0)) {
  //   time = time + 0.0000001; //each frame increment a year.
    updateVertices(scene.children[0].geometry);
  }
}


function render() {

  // var time = Date.now() * 0.00005;

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
