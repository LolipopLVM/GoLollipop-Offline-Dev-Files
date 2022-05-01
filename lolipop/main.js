// Core part of Lolipop: Offline
const RPC = require("discord-rpc");
require("./server");


// Loads env.json for Wrapper version and build number
const env = Object.assign(process.env,
	require('./env'));
// env.json variables
let version = env.LOLIPOP_VER;
let build = env.LOLIPOP_BLD;


// Discord rich presence
const rpc = new RPC.Client({
	transport: "ipc"
});
rpc.on("ready", () => {
	// Sets RPC activity
	rpc.setActivity({
		state: "Making a video/character",
		details: "Version " + version + ", build " + build,
		startTimestamp: new Date(),
		largeImageKey: "large",
		largeImageText: "Lolipop: Offline (DEV)",
		smallImageKey: "small",
		smallImagetext: "Lolipop: Offline",
	});
	// Logs "Rich presence is on!" in the console
	console.log("Rich presence is on!")
});
// Connects RPC to app
rpc.login({
	clientId: "853604354019950593"
});
