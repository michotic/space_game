import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const protocol = location.protocol === "https:" ? "wss" : "ws";
const socket = new WebSocket(`${protocol}://${location.host}/game`);

socket.addEventListener("open", () => {
    console.log("Connected");
});


window.addEventListener("keydown", (e) => {
    socket.send(JSON.stringify({
        type: "keydown",
        key: e.key
    }));
});

const scene = new THREE.Scene();

// const camera = new THREE.OrthographicCamera(
//   -10, 10, 10, -10, 0.1, 1000
// );

const camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 0.1, 1000);

camera.position.z = 10;
camera.position.x = 0;
camera.position.y = 0;

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// Sun light
const skyColor = 0xFFFFFF;
const groundColor = 0x808080;
const sunIntensity = 1;
const light = new THREE.HemisphereLight(skyColor, groundColor, sunIntensity);

// Add light + temp cube to scene
scene.add(light);
// scene.add(cube);


socket.addEventListener("message", (event) => {
    console.log("event.data => ", event.data);
    const msg = JSON.parse(event.data);
    console.log("Received:", msg);
    if ("tiles" in msg) {
        console.log(msg["tiles"]);
        for (let i = 0; i < msg["tiles"].length; i++) {
            let tileX = msg["tiles"][i][0];
            let tileY = msg["tiles"][i][1];
            let tileType = msg["tiles"][i][2];
            console.log("tile x => ", tileX);
            console.log("tile y => ", tileY);
            console.log("tile type => ", tileType);
            let geometry = new THREE.BoxGeometry(1, 1, 1);
            let material;
            if (tileType == 1) {
                material = new THREE.MeshPhongMaterial({ color: 0x404040 });
                material.wireframe = true;
            }
            if (tileType == 2) {
                material = new THREE.MeshPhongMaterial({ color: 0x30ff00 });
                material.wireframe = true;
            }

            let cube = new THREE.Mesh(geometry, material);
            cube.position.x = tileX;
            cube.position.y = tileY;
            scene.add(cube);
        }
    }
});

// Orbital controls
const controls = new OrbitControls(camera, renderer.domElement);
controls.target.set(0, 0, 0);
controls.update();

function animate() {
    requestAnimationFrame(animate);
    renderer.render(scene, camera);
}

animate();


