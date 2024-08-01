# GStreamer-Plugins
### Task 1: Read an mp4 file and display on the terminal

#### **Pipeline:** <br/> 
```
gst-launch-1.0 filesrc location=location_to_test_video ! qtdemux name=demux demux. ! queue ! faad ! audioconvert ! audioresample ! autoaudiosink demux. ! queue ! avdec_h264 ! videoconvert ! autovideosink 
```

#### **Plugins Used:**  <br/> 
**filesrc**  <br/> 

*Description:* Read data from a file in the local file system.
             It is a source element.
*Properties:* location specifies the file path   

**qtdemux**

*Description:* Demuxes a QuickTime file format(scuh as mp4) into raw or compressed audio and/or video streams.   <br/> 
*Properties:* name assigns an alias for the demuxer.   

Here, demuxing essentially involves reading multi-part stream and saving each part, i.e., audio and video into individual streams. The two demuxed streams are then processed separately: <br/> 
##### The audio stream is sent to faad (AAC decoder) <br/> 
##### The video stream is sent to avdec_h264 (H.264 decoder)   <br/> 

**faad**

