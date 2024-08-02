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
*The audio stream is sent to faad (AAC decoder) <br/> 
The video stream is sent to avdec_h264 (H.264 decoder)*   <br/> 

**faad**

*Description:* Decodes AAC stream(audio)

*Video decoding is the process of converting a compressed video file into a format that can be displayed or manipulated by the device. It is used to obtain the original video frames which were compressed when the video was stored.*

**audioconvert**

*Description:* Converts raw audio between different formats, sample types, and channel orders. <br/> 
*Usage:* It ensures that audio stream is in a suitable format for further processing.

**audioresample** <br/> 

*Description:* Resamples raw audio to different sample rates. <br/> 
*Usage:* Adjusts the sample rate of the audio stream to match the requirements of the audio sink.

**autoaudiosink** <br/> 

*Description:* Automatically detects an appropriate audio sink to use. It is done by scanning for elements with Sink" and "Audio" in the class field of their element information.

**avdec_h264** <br/> 

*Description:* decodes h.264 video streams, i.e converts demuxed h.264 video stream into raw video.

**videoconvert** <br/> 

*Description:* Converts video frames between a great variety of video formats.  <br/> 
*Usage:* Here it is needed to ensure compatibility between avdec_h264's source and autovideosink's sink pads.

**autovideosink**

*Description:* Automatically detects an appropriate video sink to use. It is done by scanning for elements with Sink" and "Video" in the class field of their element information.

### Task 2: Capture data from camera and write it into an mp4 file

#### **Pipeline:** <br/> 
```
gst-launch-1.0 -e v4l2src ! videoconvert ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! queue ! mp4mux ! filesink location=output.mp4
```
