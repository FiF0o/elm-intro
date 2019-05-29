build:
	elm make src/Main.elm --optimize --output=./public/index.js

debug:
	elm make src/Main.elm --debug --output=./public/index.js

dev:
	cd backend && npm run dev