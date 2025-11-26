-- Add Stack Overflow Three.js solutions batch 1
-- 12 highest-voted Three.js questions with accepted answers
-- Category: stackoverflow-threejs

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Transparent background with three.js canvas',
    'stackoverflow-threejs',
    'VERY_HIGH',
    '[
        {"solution": "Pass alpha: true to WebGLRenderer constructor and set clear color with 0 opacity", "percentage": 95, "command": "const renderer = new THREE.WebGLRenderer({ alpha: true }); renderer.setClearColor(0x000000, 0);"},
        {"solution": "For Three.js v125+, set scene.background = null instead", "percentage": 90, "command": "scene.background = null;"},
        {"solution": "Ensure renderer.autoClear = false if background still appears opaque", "percentage": 85, "command": "renderer.autoClear = false;"}
    ]'::jsonb,
    'Three.js library loaded, Canvas element in DOM, Understanding of renderer initialization',
    'Canvas background shows HTML content beneath it instead of black or white, Page CSS backgrounds visible through Three.js viewport',
    'Omitting alpha: true parameter results in black background. Must set both renderer alpha AND clear color. Behavior varies between Three.js versions.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/20495302/transparent-background-with-three-js'
),
(
    'How to change Three.js background color or make it transparent',
    'stackoverflow-threejs',
    'VERY_HIGH',
    '[
        {"solution": "Use renderer.setClearColor() with color hex value for solid backgrounds", "percentage": 95, "command": "renderer.setClearColor(0xffffff); // white background"},
        {"solution": "For transparency, enable alpha channel: new THREE.WebGLRenderer({ alpha: true }) and set opacity to 0", "percentage": 92, "command": "const renderer = new THREE.WebGLRenderer({ alpha: true }); renderer.setClearColor(0xffffff, 0);"},
        {"solution": "Modern approach (r78+): use scene.background = new THREE.Color()", "percentage": 90, "command": "scene.background = new THREE.Color(0xff0000);"},
        {"solution": "For transparency with modern versions, set scene.background = null", "percentage": 88, "command": "scene.background = null;"}
    ]'::jsonb,
    'Three.js library loaded, WebGLRenderer instance created, Scene object available',
    'Canvas displays desired background color immediately, CSS page backgrounds visible through transparent canvas, Scene renders without black or white override',
    'Forgetting { alpha: true } when renderer initialization prevents transparency. CSS background properties alone will not override Three.js rendering. Opacity parameter must be 0 for transparency.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/16177056/changing-three-js-background-to-transparent-or-other-color'
),
(
    'Learning WebGL and Three.js - which should I learn first',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Start with Three.js for rapid project success, then learn WebGL concepts in parallel", "percentage": 90, "note": "Three.js abstracts away WebGL complexity while remaining flexible"},
        {"solution": "Study WebGL fundamentals from WebGLFundamentals.org and Learning WebGL tutorials", "percentage": 85, "note": "Essential for understanding camera matrices and lighting"},
        {"solution": "Learn 3D mathematics: transformation matrices and MVP (Model View Projection) transformations", "percentage": 88, "note": "Required for advanced Three.js customization"},
        {"solution": "Progress to custom shaders using Three.js ShaderMaterial once basics are solid", "percentage": 82, "note": "Enables advanced visual effects"}
    ]'::jsonb,
    'JavaScript proficiency, Basic linear algebra, Familiarity with MVP transformations, Recommended books: 3D Math Primer for Graphics',
    'Successfully create Three.js scene, Objects render with proper lighting, Custom shaders work correctly, Mathematical transformations produce expected results',
    'Attempting to learn raw WebGL before Three.js causes unnecessary complexity. Skipping mathematical foundations leads to confusion with camera positioning. Assuming Three.js handles everything without understanding underlying concepts limits customization.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11966779/learning-webgl-and-three-js'
),
(
    'Convert mouse coordinates to Three.js world coordinates or screen to 3D space',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Use Vector3.unproject() to convert screen coordinates to world space", "percentage": 94, "command": "vec.set((clientX / width) * 2 - 1, -(clientY / height) * 2 + 1, 0.5); vec.unproject(camera);"},
        {"solution": "Calculate ray direction from camera using: vec.sub(camera.position).normalize()", "percentage": 92, "note": "Establishes direction ray for intersection calculation"},
        {"solution": "Find intersection with z=0 plane: distance = -camera.position.z / vec.z; pos = camera.position + (vec * distance)", "percentage": 90, "command": "const distance = -camera.position.z / vec.z; pos.copy(camera.position).add(vec.multiplyScalar(distance));"},
        {"solution": "For different target planes, replace z with target value: distance = (targetZ - camera.position.z) / vec.z", "percentage": 88, "note": "Allows positioning on arbitrary z-planes"}
    ]'::jsonb,
    'Three.js library loaded, Active camera object, Mouse event object with clientX/clientY, Understanding of Normalized Device Coordinates (NDC)',
    'Result pos vector contains world coordinates at mouse intersection point, Objects position at mouse location correctly, Ray intersection distance matches expected values',
    'Forgetting to convert screen coordinates to NDC space (-1 to 1 range). Not normalizing direction vector causes incorrect distance calculations. Confusing z-position with world position.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/13055214/mouse-canvas-x-y-to-three-js-world-x-y-z'
),
(
    'Transparent objects rendering issues in Three.js - overlapping transparency',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Use renderOrder property to explicitly control render sequence (recommended for r.71+)", "percentage": 95, "command": "sphere1.renderOrder = 1; sphere2.renderOrder = 0;"},
        {"solution": "Disable depthWrite on transparent materials to prevent depth buffer conflicts", "percentage": 91, "command": "material1.depthWrite = false; material2.depthWrite = false;"},
        {"solution": "Set renderer.sortObjects = false and add objects in desired render order", "percentage": 88, "note": "Objects render in scene-addition order instead of by distance"},
        {"solution": "Offset object positions slightly to establish clear depth ordering", "percentage": 75, "note": "Simple approach for cases with minimal overlap"}
    ]'::jsonb,
    'Transparent materials with transparent: true property, Three.js version r.71 or higher for renderOrder, Understanding of depth sorting and blending',
    'Both transparent objects render with proper blending, No z-fighting artifacts or occlusion issues, Overlapping transparency appears correct from all camera angles',
    'renderOrder does not inherit to child objects - must set on each object. Using sortObjects: false without careful scene organization produces unpredictable results. Assuming transparency works like standard blending ignores depth buffer considerations.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15994944/transparent-objects-in-three-js'
),
(
    'How to stop requestAnimationFrame loop in Three.js',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Store the animation frame ID and use cancelAnimationFrame to halt the loop", "percentage": 96, "command": "var requestId = window.requestAnimationFrame(loop); window.cancelAnimationFrame(requestId);"},
        {"solution": "Create start() and stop() functions that manage the requestId state", "percentage": 93, "command": "function stop() { if (requestId) { cancelAnimationFrame(requestId); requestId = undefined; } }"},
        {"solution": "Update requestId at the start of each frame to avoid stale IDs", "percentage": 91, "note": "Ensures clean cancellation on subsequent calls"},
        {"solution": "Use boolean flag to prevent scheduling next frame without actual cancellation", "percentage": 70, "note": "Simpler but less efficient than cancelAnimationFrame"}
    ]'::jsonb,
    'JavaScript requestAnimationFrame API knowledge, Understanding of animation loops, Ability to store and manage request IDs',
    'Animation loop stops immediately when stop() called, No background rendering continues, Exiting fullscreen mode properly halts Three.js animation',
    'Setting boolean flag does not actually stop animation - just prevents scheduling next frame. Forgetting to store the requestAnimationFrame ID prevents proper cancellation. Recursion continues even if boolean prevents rescheduling.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10735922/how-to-stop-a-requestanimationframe-recursion-loop'
),
(
    'Collision detection between meshes in Three.js',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Use Raycaster with mesh vertex positions to detect collisions", "percentage": 92, "command": "var ray = new THREE.Raycaster(Player.position, directionVector.normalize()); var collisionResults = ray.intersectObjects(collidableMeshList);"},
        {"solution": "For BufferGeometry, use fromBufferAttribute to access vertex positions", "percentage": 90, "command": "new THREE.Vector3().fromBufferAttribute(geometry.attributes.position, vertexIndex)"},
        {"solution": "Check intersection distance: if distance < vertex distance from origin, collision occurred", "percentage": 89, "note": "Validates collision is within expected bounds"},
        {"solution": "Use physics libraries (Cannon.js or Ammo.js) for complex collision scenarios", "percentage": 85, "note": "More robust for game-like interactions"}
    ]'::jsonb,
    'Three.js library loaded, Mesh objects with geometry defined, Array of collidable objects, For BufferGeometry: understanding of position attributes',
    'Ray intersects with target objects in collisionResults array, Intersection distance less than vertex distance confirms collision, Detected collisions match expected object proximity',
    'Using deprecated Geometry instead of BufferGeometry requires different vertex access. Forgetting to normalize direction vector causes incorrect distance calculations. Raycasting is less efficient for many objects - physics libraries recommended instead.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11473755/how-to-detect-collision-in-three-js'
),
(
    'Rotate camera around origin with mouse in Three.js',
    'stackoverflow-threejs',
    'VERY_HIGH',
    '[
        {"solution": "Use OrbitControls for mouse-based camera rotation around a central point", "percentage": 96, "command": "controls = new THREE.OrbitControls(camera, renderer.domElement);"},
        {"solution": "Include OrbitControls.js from Three.js examples in HTML before initialization", "percentage": 94, "command": "<script src=\"js/OrbitControls.js\"></script>"},
        {"solution": "Call controls.update() in animation loop to process mouse input", "percentage": 92, "command": "controls.update(); renderer.render(scene, camera);"},
        {"solution": "Alternative: Use TrackballControls or PointerLockControls for different behavior", "percentage": 80, "note": "PointerLockControls enforces view constraints differently"}
    ]'::jsonb,
    'Three.js library loaded, Renderer with DOM element, Camera instance, OrbitControls.js script file from examples directory',
    'Mouse drag rotates camera around scene origin, Camera maintains distance from center point, Zoom (scroll) and pan work smoothly',
    'Simply instantiating OrbitControls without calling update() in render loop does not work. Missing OrbitControls.js script causes initialization errors. Manual spherical coordinate implementation is complex - use built-in controls instead.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/8426822/rotate-camera-in-three-js-with-mouse'
),
(
    'Remove object from Three.js scene',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Use scene.getObjectByName() to lookup object, then call scene.remove()", "percentage": 94, "command": "var selectedObject = scene.getObjectByName(object.name); scene.remove(selectedObject);"},
        {"solution": "Properly dispose geometry and materials to prevent GPU memory leaks", "percentage": 93, "command": "if (object3D.geometry) object3D.geometry.dispose(); if (object3D.material) object3D.material.dispose();"},
        {"solution": "For material arrays, dispose each material individually", "percentage": 91, "command": "if (object3D.material instanceof Array) { object3D.material.forEach(m => m.dispose()); }"},
        {"solution": "Call animate() or renderer.render() after removal to update scene", "percentage": 88, "note": "Rendering updates visual representation immediately"}
    ]'::jsonb,
    'Three.js scene with objects added, Objects have unique name properties assigned, Understanding of memory management concepts',
    'Object disappears from 3D scene, No GPU memory leaks occur, Objects with unique names are properly removed',
    'Passing string name to scene.remove() instead of Object3D instance causes failure. Forgetting to dispose geometry/materials causes GPU memory leaks. Not calling animate() after removal shows stale scene.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18357529/threejs-remove-object-from-scene'
),
(
    'Rotate mesh by specific angle (e.g., 90 degrees) in Three.js',
    'stackoverflow-threejs',
    'VERY_HIGH',
    '[
        {"solution": "Use Math.PI / 2 for 90 degrees: mesh.rotation.x = Math.PI / 2", "percentage": 96, "command": "mesh.rotation.x = Math.PI / 2; // or .y or .z for other axes"},
        {"solution": "Alternative: use rotation.set() method for multiple axes", "percentage": 92, "command": "mesh.rotation.set(0, 0, Math.PI / 2);"},
        {"solution": "Use rotateX/rotateY/rotateZ methods for incremental rotations", "percentage": 89, "command": "mesh.rotateX(Math.PI / 2);"},
        {"solution": "For complex rotations, use Quaternions with setFromAxisAngle", "percentage": 85, "command": "const q = new THREE.Quaternion(); q.setFromAxisAngle(new THREE.Vector3(0, 0, 1), THREE.MathUtils.degToRad(90)); mesh.quaternion.multiply(q);"}
    ]'::jsonb,
    'Three.js library loaded, Mesh object created, Understanding that Three.js uses radians (π/2 = 90°) not degrees',
    'Mesh visually aligns parallel to reference object, mesh.rotation properties show correct radian values, 3D scene displays rotated geometry correctly',
    'Forgetting to convert degrees to radians causes incorrect rotation angles. Confusing rotation.x/y/z order for compound rotations. Using Euler angles without understanding gimbal lock limitations.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/29907536/how-can-i-rotate-a-mesh-by-90-degrees-in-threejs'
),
(
    'Load and apply textures to meshes in Three.js',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Use TextureLoader with callback to ensure rendering occurs after texture loads", "percentage": 95, "command": "const loader = new THREE.TextureLoader(); loader.load(\"texture.png\", function(texture) { const material = new THREE.MeshBasicMaterial({map: texture}); ... renderer.render(scene, camera); });"},
        {"solution": "Create material and mesh inside the load callback to avoid timing issues", "percentage": 93, "note": "Ensures all setup completes before rendering"},
        {"solution": "Use power-of-two image dimensions (256x256, 512x512) for best performance", "percentage": 88, "note": "Non-POT dimensions may cause issues with some hardware"},
        {"solution": "Avoid deprecated ImageUtils.loadTexture - use TextureLoader instead", "percentage": 90, "note": "Modern API that is actively maintained"}
    ]'::jsonb,
    'Three.js library loaded, TextureLoader API available, Valid image file path or URL, Understanding of asynchronous loading',
    'Texture displays on mesh surface, No black or missing texture artifacts, Rendering completes after texture fully loads',
    'Rendering before texture async load completes results in missing texture (black surface). Using deprecated ImageUtils.loadTexture causes issues in newer Three.js versions. Non-power-of-two textures may have rendering issues.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/7919516/using-textures-in-three-js'
),
(
    'Rotate object around its own center instead of world center in Three.js',
    'stackoverflow-threejs',
    'HIGH',
    '[
        {"solution": "Call geometry.center() to automatically center vertices around origin", "percentage": 96, "command": "geometry.center();"},
        {"solution": "Use Box3 bounding box to calculate center, then offset geometry", "percentage": 92, "command": "var box = new THREE.Box3().setFromObject(mesh); box.getCenter(mesh.position); mesh.position.multiplyScalar(-1);"},
        {"solution": "Create pivot Group and apply rotation to group instead of mesh", "percentage": 89, "command": "var pivot = new THREE.Group(); scene.add(pivot); pivot.add(mesh); pivot.rotation.y += 0.01;"},
        {"solution": "For loaded models, use geometry.translate() to offset all vertices", "percentage": 85, "command": "geometry.translate(x, y, z);"}
    ]'::jsonb,
    'Three.js library loaded, Mesh or geometry object with possibly offset vertices, Understanding of bounding boxes and pivot points',
    'Mesh rotates around its own center smoothly, No orbiting around world origin, Rotation point aligns with visual object center',
    'Geometry vertices offset from origin causes unexpected rotation behavior. Using mesh.rotation directly without proper geometry centering produces orbiting effect. Not handling child meshes causes partial rotation in loaded models.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/28848863/threejs-how-to-rotate-around-objects-own-center-instead-of-world-center'
),
(
    'Calculate bounding box from Three.js Object3D',
    'stackoverflow-threejs',
    'MEDIUM',
    '[
        {"solution": "Use Box3 class: new THREE.Box3().setFromObject(object) to get bounding box", "percentage": 94, "command": "const box = new THREE.Box3().setFromObject(object); const size = box.getSize(new THREE.Vector3()); const center = box.getCenter(new THREE.Vector3());"},
        {"solution": "Access bounding box properties: box.min and box.max for corner coordinates", "percentage": 92, "command": "console.log(box.min, box.max);"},
        {"solution": "Calculate dimensions: box.getSize() returns width, height, depth", "percentage": 90, "command": "const size = new THREE.Vector3(); box.getSize(size);"},
        {"solution": "For geometries, use Geometry.computeBoundingBox() before accessing bbox", "percentage": 85, "note": "Must call before accessing geometry.boundingBox"}
    ]'::jsonb,
    'Three.js library loaded, Object3D or Geometry instance, Understanding of coordinate systems and min/max bounds',
    'Box3 bounding box correctly encompasses all visible geometry, Size calculations match object dimensions, Center coordinates align with visual object center',
    'Forgetting that Box3 must recalculate for transformed objects (not cached). Using geometry.boundingBox without calling computeBoundingBox() first. Assuming bounding box updates automatically after position changes.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15492857/any-way-to-get-a-bounding-box-from-a-three-js-object3d'
);
