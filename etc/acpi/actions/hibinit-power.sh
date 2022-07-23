#!/bin/sh

# shut down system in a way that respects inhibitors
# see: https://github.com/systemd/systemd/pull/9356
dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.PowerOff boolean:false
