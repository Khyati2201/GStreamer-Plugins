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
*Properties:* 'name' assigns an alias for the demuxer.   

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

*Description:* Automatically detects an appropriate video sink to use. It is done by scanning for elements with Sink" and "Video" in the class field of their element information. It is a sink element.

### Task 2: Capture data from camera and write it into an mp4 file

#### **Pipeline:** <br/> 
```
gst-launch-1.0 -e v4l2src ! videoconvert ! x264enc tune=zerolatency bitrate=500 speed-preset=superfast ! queue ! mp4mux name=mux ! filesink location=output.mp4 \
    alsasrc ! audioconvert ! audioresample ! voaacenc bitrate=128000 ! queue ! mux.
```
#### **Plugins Used:**  <br/> 
**v4l2src**

*Description:* Used to capture video from v4l2 devices(e.g.-webcam). It is a source element.

**x264enc** <br/> 

*Description:* Encodes raw video into h.264 format. <br/> 
*Properties:* <br/> 
* tune=zerolatency: Optimizes for low latency. <br/> 
* bitrate=500: Sets the bitrate to 500 kbps. <br/> 
* speed-preset=superfast: Uses the superfast encoding preset for faster processing.  <br/> 

*Video encoding is the process of compressing the size of RAW video files into smaller file sizes to enable quick and efficient transposition of video content over the internet.* <br/>

*Bitrate is the rate at which bits are transmitted or processed per unit of time*

**mp4mux**

*Description:* It merges streams (audio and video) into ISO MPEG-4 (.mp4) files. <br/> 
*Propoerties*: 'name' assigns an alias for referencing the muxer.

**filesink**

*Description:* Writes incoming data to a file in the local file system. It is a sink element. <br/>
*Properties:* 'location' specifies the output file path

**alsasrc** <br/> 

*Description:* Captures audio from an ALSA (Advanced Linux Sound Architecture) device. It is a source element.

**voaacenc:** <br/> 

*Description:* This plugin encodes raw audio stream into AAC format for efficient storage. <br/> 
*Properties:* bitrate=128000 sets the encoding bitrate to 128 kbps.

*AAC (Advanced Audio Coding) is an audio coding standard for lossy digital audio compression.*
### Task 3: Read an mp4 file and send the data over udpsink. Receive the same data via udpsource and display on the screen.

#### Sender Pipeline: <br/> 
```
gst-launch-1.0 filesrc location=location_to_test_video ! qtdemux name=demux demux.video_0 ! h264parse ! avdec_h264 ! videoconvert ! x264enc ! rtph264pay ! udpsink host=127.0.0.1 port=5000
```
#### **Plugins Used:**  <br/> 
**h264parse** <br/> 
*Description:* Parses h.264 streams, ensuring that the raw h.264 bitstream from the file is correctly prepared and formatted for the h.264 decoder (avdec_h264) <br/> 
(H.264 bitsream -> bytestream) <br/>

**rtph264pay** <br/>

*Description:* Takes h.264 video as input and turns it into into RTP (Real-time Transport Protocol) packets for network transmission. RTP is a standard format used to send many types of data over a network, including video.

**udpsink**  <br/>

*Description:* It is a network sink that sends UDP(User Datagram Protocol) packets to the network. Here, it is combined with rtph264pay to implement RTP streaming. <br/>
*Properties:*
* 'host' specifies the destination IP address.(IP address 127.0. 0.1 is called the loopback address/localhost and is used by a computer to refer to itself)
* 'port' specifies the destination port.

*UDP is a communication protocol used across the internet for time-sensitive transmissions such as video playback. Since it is a connectionless protocol, there is no need to establish a connection before data transfer, thus establishing low-latency and loss-tolerating connections over the network.*

#### Receiver Pipeline: <br/>
```
gst-launch-1.0 udpsrc port=5000 caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264" ! rtph264depay ! avdec_h264 ! videoconvert ! autovideosink
```
#### **Plugins Used:**  <br/> 
**udpsrc** <br/> 

*Description:* It is a network source that reads UDP packets(containing the h.264 video stream) from the network. Here, it is combined with rtph264depay to implement RTP streaming. <br/>

*Properties:*
* port- specifies the port to receive the packets from.
* caps- defines the capabilities of the stream, specifying it as RTP with h.264 encoding.

**rtph264depay** <br/> 

*Description:* Extracts H.264 video from RTP packets.

### Task 4: Receive video from udpsource and write into an mp4 file
#### Sender Pipeline: <br/> 
```
gst-launch-1.0 filesrc location=location_to_test_video ! qtdemux name=demux demux.video_0 ! h264parse ! avdec_h264 ! videoconvert ! x264enc ! rtph264pay ! udpsink host=127.0.0.1 port=5000
```

#### Receiver Pipeline: <br/>
```
gst-launch-1.0 udpsrc port=5000 caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264" ! rtph264depay ! avdec_h264 ! x264enc ! mp4mux ! filesink location=task_4.mp4
```


