# GStreamer-Plugins
### Task 1: Read an mp4 file and display on the terminal

####**Pipeline:** <br/> 
```
gst-launch-1.0 filesrc location=location_to_test_video ! qtdemux name=demux demux. ! queue ! faad ! audioconvert ! audioresample ! autoaudiosink demux. ! queue ! avdec_h264 ! videoconvert ! autovideosink 
```

####**Plugins Used:**  <br/> 
#####filesrc  <br/> 
Description: Read data from a file in the local file system.
             It is a source element.
