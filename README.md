# qd-front
The very front of 2123.io and the whole qd-platform


## dev
To run `qd-front` on your local machine:

1. add `127.0.0.1       2123.qd` to your `hosts`;
2. clone this repo;
3. put `fullchain.pem` and `privkey.pem` from 21/23 Google Drive storage into `./cert/` directory;
4. `sh build.dev.sh`;
5. `sh run.dev.sh`;
6. open in your browser `https://2123.dq/`;

In `dev` no UI is built, so in order to see *qd UI - go to the appropriate repo and run `npm run build:local`.


## prod
To deploy `qd-front`:

1. clone this repo;
2. put `fullchain.pem` and `privkey.pem` from 21/23 Google Drive storage into `./cert/` directory;
3. `sh build.sh`
4. `sh run.sh`

## Critical thing to be done:
- `envsubst` should be used to configure reverse proxy's URI


## FAQ
### `dev` vs `prod` - what is the difference?

`dev`:
- uses certificates from `./cert/`, doen't generate new ones;
- reverse proxy is pointed back to the host machine;
- has no pre-built UIs. Each UI should be built separately;

`prod`:
- runs weekly cron job to refresh certificates;
- reverse proxy is pointed back to the **2123** ultra machine;
- builds all the UIs and automatically starts to serve;

### Why do you need `.lua` scripts?

To keep static data in one place. The reverse-proxied backend only verifies a single client request and responses with appropriate HTTP status code. Lua scripts just handle these codes and either redirect to login page or send to the client the required file. This helps to store static data only in one place - `qd-front`.

### What the heck is `qd-front-scripts`?

Alpine linux image is very limited. `qd-front` container inherits from `openresty` which already has its own CMD. So in order not to hardcode `openresty` start command, but at the same time be able to run more than one process - `run(.dev).sh` executes also some predefined scripts.

### Why do I need to put some certificates to `./cert/` directory?

For `dev` - they are required to work with `https:` on local machine. For `prod` - they're required to run initial `nginx` which is needed for certificates refresh.