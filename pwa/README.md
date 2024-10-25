# PWA app to run a Rails Wasm app

The app provides a Service Worker to serve requests through the Rails/Wasm app.

## Running locallly

```sh
yarn install

yarn dev
```

Then go to [http://localhost:5173](http://localhost:5173).

> [!NOTE]
> Use Chrome or another browser supporting [CookieStore API](https://caniuse.com/?search=cookiestore).

## Serving via HTTPS

Although `localhost` should work fine for development, you can also run the app over `https://` for a more production-like experience (and to attach a worker to a custom domain).

For that, we recommend using [puma-dev](https://github.com/puma/puma-dev).

Install `puma-dev` and add the port 5173 to its configuration:

```sh
echo "5173" > ~/.puma-dev/rails-wasm
```

Then, run the server as follows:

```sh
yarn dev --host 0.0.0.0
```

Go to [https://rails-wasm.test](https://rails-wasm.test) to open the app.

## Credits

The launcher HTML/JS is based on the [Yuta Saito](https://github.com/kateinoigakukun)'s work on [Mastodon in the browser](https://github.com/kateinoigakukun/mastodon/tree/katei/wasmify).
