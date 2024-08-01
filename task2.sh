gst-launch-1.0 -e v4l2src ! videoconvert ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! queue ! mp4mux name=mux ! filesink location=output.mp4 \
    alsasrc ! audioconvert ! audioresample ! voaacenc bitrate=128000 ! queue ! mux.
