build:
	elm make src/Main.elm --optimize --output=./index.js

dev:
	elm reactor