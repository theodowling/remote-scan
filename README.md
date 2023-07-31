# RemoteScan

This project is a super simple standalone Elixir server that responds to http call - and triggers scan command on my rasperry-pi connected to a scanning device.

The actual scannning is happening [via SANE](http://www.sane-project.org/man/scanimage.1.html)

The scanned image is then put in a consume folder on [paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) instance, to be auto classified and categorised.

## Background

I wanted to build this with no dependencies needed - so decided to implement http server from scratch - as a learning opportunity also.

## Installation

Run locally using `mix run --no-halt`

## Deployment

Build executable file using `mix release` which will then output the relevant options for you to run this as a daemon on the target device

