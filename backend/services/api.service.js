"use strict";

const ApiGateway = require("moleculer-web");

module.exports = {
	name: "api",
	mixins: [ApiGateway],

	// More info about settings: https://moleculer.services/docs/0.13/moleculer-web.html
	settings: {
		port: process.env.PORT || 3000,

		routes: [{
			path: "/api",
			aliases : {
				"GET /hello": "greeter.service.hello",
				"GET /welcome/:name": "greeter.service.welcome"
			}
		}],

		// Serve assets from "public" folder
		assets: {
			folder: "../public"
		}
	}
};
