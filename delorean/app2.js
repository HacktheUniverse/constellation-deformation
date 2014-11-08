var camera, scene, renderer, time = 0,
// to keep track of the mouse position
	mouseX = 0, mouseY = 0,
// an array to store our particles in
	particles = [];
// let's get going! 
init();

function init() {
	// Camera params : 
	// field of view, aspect ratio for render output, near and far clipping plane. 
	camera = new THREE.PerspectiveCamera(80, window.innerWidth / window.innerHeight, 1, 4000 );

	// move the camera backwards so we can see stuff! 
	// default position is 0,0,0. 
	// camera.position.z = 1000;
	// the scene contains all the 3D object data
	scene = new THREE.Scene();
	
	// camera needs to go in the scene 
	scene.add(camera);

	renderer = new THREE.CanvasRenderer();
	renderer.setSize( window.innerWidth, window.innerHeight );

	// the renderer's canvas domElement is added to the body
	document.body.appendChild( renderer.domElement );
	makeParticles(); 

	// add the mouse move listener
	document.addEventListener( 'mousemove', onMouseMove, false );
	
	// render 30 times a second (should also look 
	// at requestAnimationFrame) 
	setInterval(update,1000/30); 

}
// the main update function, called 30 times a second
function update() {
	time += 1000;
	updateParticles();
	// and render the scene from the perspective of the camera
	renderer.render( scene, camera );
}
// creates a random field of Particle objects

function makeParticles() { 
		var particle, material; 
		stars.forEach(function(star) {
			material = new THREE.ParticleCanvasMaterial( { color: 0xffffff, program: particleRender } );
			particle = new THREE.Particle(material);
			var coords = star['pos'];
			var velocities = star['speed'];
			
	
			particle.position.x = coords[0] + (time * velocities[0])
			particle.position.y = coords[1] + (time * velocities[1])
			particle.position.z	= coords[2] + (time * velocities[2])
	
			// add it to the scene
			scene.add( particle );
			// and to the array of particles. 
			particles.push(particle); 


		})	
}

function particleRender( context ) {
	
	// we get passed a reference to the canvas context
	context.beginPath();
	// and we just have to draw our shape at 0,0 - in this
	// case an arc from 0 to 2Pi radians or 360º - a full circle!
	context.arc( 0, 0, 1, 0,  Math.PI * 2, true );
	context.fill();
};

// moves all the particles dependent on mouse position

function updateParticles() { 
	
	// iterate through every particle
	for(var i=0; i<particles.length; i++) {
		
		particle = particles[i];
		console.log(particle)
		
		
		var star = stars[i];
		console.log(star)

		var coords = star['pos'];
		var velocities = star['speed'];

		particle.x = coords[0] + (time * velocities[0])
		particle.y = coords[1] + (time * velocities[1])
		particle.z = coords[2] + (time * velocities[2])

		//var distance = Math.sqrt(Math.pow(particle.x,2) + Math.pow(particle.y,2) + Math.pow(particle.z,2))
		//var flux = star['lum'] / (4*3.14 (Math.pow(distance,2)));
		//do something with flux.

	} 		
}

function onMouseMove( event ) {
	// store the mouseX and mouseY position 
	mouseX = event.clientX;
	time = mouseX * 1000;

}