# GStreamer-Plugins
### Task 1: Read an mp4 file and display on the terminal

Pipeline:  <br/> 
```
gst-launch-1.0 filesrc location=/home/khyati/Downloads/test_video.mp4 ! qtdemux name=demux demux. ! queue ! faad ! audioconvert ! audioresample ! autoaudiosink demux. ! queue ! avdec_h264 ! videoconvert ! autovideosink 
```

Plugins Used:
filesrc  <br/> 

Description: 
