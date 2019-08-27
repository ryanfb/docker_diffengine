# docker_diffengine

## Supported Tags

  * `latest`: x86
  * `arm64v8`: compatible with Raspberry Pi 4 64-bit builds
  * `arm32v7`: compatible with Raspberry Pi 2, 3, & 4 32-bit builds
  * `arm32v5`: compatible with Raspberry Pi 1, 2, 3, & 4 32-bit builds

## Description

This is a Docker image for running [`diffengine`](https://github.com/docnow/diffengine) instances.

It uses a `cron` job set to run `run-diffengine.sh` every minute - this script in turn uses `flock` and `timeout` to obtain an exclusive lock and only run diffengine for the time specified by the `DIFFENGINE_TIMEOUT` environment variable (default `1h` = 1 hour). Basically this ensures there will always be one (and only one) `diffengine` instance running per container, with each `diffengine` instance running no longer than `DIFFENGINE_TIMEOUT`.

It uses a host-mapped data volume at `/diffengine` to store and persist the `diffengine` configuration and data.

PhantomJS should be installed and available at `/usr/local/bin/phantomjs`.

Run the initial configuration with:

    docker run -ti -v /path/to/diffengine/directory:/diffengine ryanfb/diffengine diffengine /diffengine


Run a configured instance as a daemon with the following (or change `-d` back to `-ti` for an interactive run):

    docker run -d -v /path/to/diffengine/directory:/diffengine ryanfb/diffengine


Or override `DIFFENGINE_TIMEOUT` with e.g.:

    docker run -d -v /path/to/diffengine/directory:/diffengine -e DIFFENGINE_TIMEOUT=2h ryanfb/diffengine

You can also set the `CRON_SCHEDULE` environment variable to specify a custom [cron schedule expression](https://crontab.guru/) for how frequently you want `diffengine` to be run (default: `* * * * *`, i.e. every minute).


