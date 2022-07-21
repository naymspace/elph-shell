# Elph-Shell

A development/demo project to provide an example how to use [elph](https://github.com/naymspace/elph), while providing convenience for its development.

Beware: Elph is a headless cms and this project does not have a frontend - just an api. A demo frontend will be available soon.

Since elph has no authentication right now (this will be added as an optional module in the future) this app uses coherence for authentication.

It has a custom content-type defined (static_page) and uses a custom controller to show them publicly, if they are `published`. Everything else needs authenticated requests.

## Quickstart
This project uses docker and docker-compose.

### Configuration/Setup
Just run `docker-compose up`. No previous steps required - everything is configured in the `docker-compose.yml`

After the first start you will end up with a running, but empty container. Run `mix ecto.seed` in the `phoenix` container to seed your database with some demo data (see [Entering the Container](#entering-the-container) for details).

#### Entering the container
Many commands will need to be issued from within the running container, not your local machine. While `docker-compose up` is running you can open a second terminal window and run `docker-compose exec phoenix bash` to get a console from within the container.
### Start
Just run `docker-compose up` and you're good to go.

The container is setup not to close, if the phoenix executable exits. This is useful, if you want to have a more direct control over what happens. You can enter the container from another shell with `docker-compose exec phoenix bash`. With `iex -S mix` you can now spawn a shell with all modules loaded. You can also kill the existing erlang binary and run `iex -S mix phx.server` in case you want control over the whole server (to use `IEx.pry()` for example)


## Access application
The default URL is `http://localhost:4000/api/`.

You can look at an example of a static page here: `http://localhost:4000/api/static/home`

The default login is `admin@example.com`:`password`.

## API Documentation

This project grew with its uses, so right now there is no concise api-documentation yet. This will change in the future.

## Environment variables

Everything is already setup in the `docker-compose.yml`.
For reference:
- **DATABASE_URL** - The url for phoenix to connect to the database.
- **TEST_DATABASE_URL** (optional) - The url to use for the tests. If not set, it will fallback to **DATABASE_URL**.
- **SMTP_HOST** - The host to use as smtp relay.
- **SMTP_PORT** - The port to use for the smtp relay.
- **SECRET_KEY_BASE** - The secret key base for phoenix to secure its tokens.
## Building and Deployment

Since this is only a development/demo environment, there is nothing to deploy.

## Automatic tests

Tests need a fully migrated, but empty database. For this reason a second database is started automatically by `docker-compose`.

> **_NOTE:_** The following commands need to be run from within the `phoenix` container.

Run `mix test.setup`  once to setup the test database. This needs to be rerun, when migrations change, of course.

After that you can run tests with `mix test`. If you need a coverage report just run `mix test --cover` instead.

## Major dependencies

- [Phoenix Framework](https://www.phoenixframework.org/)
- [Elph](https://gitlab.naymspace.de/naymspace/elph)


## Development
This project adds some convenience for the development of elph.
- Elph is automatically recompiled, whenever it is changed. This will work for the phoenix hot-reloading as well as when calling `recompile` from within `iex`.
  - There will be lots of warnings, when elph-stuff is recompiled, but it doesn't seem to break anything.
- `mix test`, `mix credo` and `mix format` are all configured to run for the toplevel project, as well as for the `elph` dependency.
### Adding new contexts
After adding a new context you'll need to change some settings to be compatible with the way everything works.

- After you created a context with `mix phx.gen.json <Something something>` add the route as suggested to `ElphWeb.Router`.
- Afterwards open up your newly created `Elph.<Something>Context` and do the following:
  - remove `alias Elph.Repo`
  - replace it with `def repo, do: Application.get_env(:elph, :repo)`
  - replace all calls to `Repo` with `repo()` in the created code
- Now open your newly created `ElphWeb.<Something>Controller and
  - replace `action_fallback FallbackController` with `action_fallback Application.get_env(:elph, :fallback_controller, ElphWeb.FallbackController)`
- Now you can develop everything as you would in your usual phoenix app.

### Code location

It is not recommended to develop directly in `deps/elph` as this could potentially be overwritten by mix. A better way is to develop in another directory and copy your code changes into that directory. This can be automated with various tools.

One possiblity of automation is using `chokidar-cli`. This requires you to have `node` and `npm` installed on your machine. Assuming `elph` and `elph-shell` are in the same parent directory, you can just run the `./syncElph.sh` script.

> **_NOTE:_** The mix.lock file is excluded from the above sync script. If you run `mix deps.get` or similar directly in the `deps/elph` folder you'll need to copy the file back to your external `elph` folder.
