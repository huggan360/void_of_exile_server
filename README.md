# Void of Exile server

The dedicated server for [Void of Exile](https://void.plainshow.se). Anyone with an account can run one, for
friends or for everyone. Releases here have the same version as the game (`v26.0-beta`, ...): a server only
takes players whose game has the same version.

## Run it from the launcher (easiest)

1. Open the Void of Exile launcher and sign in.
2. Pick **Server** at the top. Install it (it shares most files with the game, so it is a small download when the
   game is already installed).
3. Set the name, message, players, player contact, memory and port, then **Start**.
4. While it runs, the page lists who is on (class, level, where, ping) with a **Kick** button, and shows the
   server's log.

The launcher asks the account service for a server key tied to your account and keeps it in the server's
config. Only Linux (x86_64) builds exist for now, like the game.

## Run it by hand

Download `VoidOfExileServer-<version>-linux-x86_64.tar.gz` from the releases, unpack it, put `run_server.sh`
from this repo next to `VoidOfExileServer.x86_64`, and:

```sh
./run_server.sh                    # config in ./config (server.cfg is written on first start)
./run_server.sh --port=24600 --name="Night Realm"
```

or without the script: `./VoidOfExileServer.x86_64 --headless -- --dedicated --config=./config`.

A server needs a key: sign in to the launcher once and start it from the Server page (that writes the key), or
copy `server_key` from a launcher-made `server.cfg`. `server.cfg.example` lists every setting a server may
change.

For players outside your network, forward **UDP 24565 and 24566** (game and status ping, or your port and
port+1) on the router.

## The rules

- **Release servers are locked.** They play exactly like the official servers: enemies, loot, spawns, XP,
  godmode, test kits and network tuning can't be changed. Only the host's own settings can: name, message,
  max players, player contact, memory limit, port, public listing and LAN discovery.
- **The account service decides.** Characters, items and Dots live there. A player-hosted server is not trusted
  like the official servers: every save is compared with the last one, saves that gain more than play can are
  refused, unusual ones are logged, and Dots awards are capped. Developer commands (`/give`, `/lvl`, `/max`)
  only work for accounts the account service marks as developers.
- A host whose server breaks the rules loses hosting (its key stops working).

## For the developers

The server is the game's own code (`scripts/net/` in the game repo); a release build is the game's export under
the name `VoidOfExileServer`, which starts as a locked dedicated server by itself. `tools/release/publish.sh` in
the game repo builds both and publishes the release here with the same version. See the game repo's
`docs/DEVELOPING.md` for how the repos fit together.

| Here | What |
| --- | --- |
| `run_server.sh` | Start a release build in this folder |
| `server.cfg.example` | The settings a host may change |
| `dev/run_from_source.sh` | Start the server from the game's source (unlocked: `--test`, tuning files) |
| `dev/tuning/` | Reference tuning files (enemies, bosses, loot, spawns, player); only an unlocked server from source reads them, from its config folder |

Hosts and their audit log, on the account server (`void_of_exile_account`):

```sh
python3 void_accounts.py hosts                 # who hosts, with audit counts
python3 void_accounts.py audit --limit 40      # unusual and refused saves
python3 void_accounts.py revoke-host NAME      # close hosting for an account (allow-host opens it again)
```
