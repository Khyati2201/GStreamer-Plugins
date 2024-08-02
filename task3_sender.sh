gst-launch-1.0 filesrc location=location_to_test_video ! qtdemux name=demux demux.video_0 ! h264parse ! avdec_h264 ! videoconvert ! x264enc ! rtph264pay ! udpsink host=127.0.0.1 port=5000


