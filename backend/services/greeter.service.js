"use strict";

module.exports = {
	name: "greeter",
	settings: {
	},
	dependencies: [],	
	actions: {
		hello() {
			return "Hello Moleculer";
		},
		welcome: {
			params: {
				name: "string"
			},
			handler(ctx) {
				return `Welcome, ${ctx.params.name}`;
			}
		}
	},
	events: {
	},
	methods: {
	},
	created() {
	},
	started() {
	},
	stopped() {
	}
};