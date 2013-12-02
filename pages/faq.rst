.. link: 
.. description: 
.. category: FAQ
.. date: 2013/07/27 14:59:17
.. title: FAQ
.. slug: faq

.. sectnum::

.. contents:: 


What is this website for?
-------------------------

See `About avb.statusbar.com </>`_.

What is AVB?
------------

`Audio Video Bridging <http://en.wikipedia.org/wiki/Audio_Video_Bridging>`_ is a term for a collection of IEEE Standards for time sensitive networking which facilitates the transport of high performance audio and video on a LAN:

* `IEEE Std 802.1BA-2011 <http://standards.ieee.org/findstds/standard/802.1BA-2011.html>`_, for profiles and overview.
* `IEEE Std 802.1Q-2011 <http://standards.ieee.org/findstds/standard/802.1Q-2011.html>`_, for traffic shaping (FQTSS) and the stream reservation protocol (SRP).
* `IEEE Std 802.1AS-2011 <http://standards.ieee.org/findstds/standard/802.1AS-2011.html>`_, for time synchronization (gPTP, Generalized Precision Time Protocol).
* `IEEE Std 1722-2011 <http://standards.ieee.org/findstds/standard/1722-2011.html>`_, for the Audio Video Transport Protocol (AVTP).
* `IEEE Std 1722.1-2013 <http://standards.ieee.org/findstds/standard/1722.1-2013.html>`_, for the Audio Video Discovery, Enumeration, Connection management, and Control protocol (AVDECC)

How is media transported with AVB?
----------------------------------

IEEE Std 1722-2011 builds on the following standards for media packetization:

* `IEC 61883-6 <http://webstore.iec.ch/preview/info_iec61883-6%7Bed2.0%7Den.pdf>`_, for the transport of Audio, SMPTE Time Code, and MIDI.
* `IEC 61883-8 <http://webstore.iec.ch/preview/info_iec61883-8{ed1.0}en.pdf>`_, for the transport of Video
* `1394 Trade Association document 1999024 <http://www.1394ta.org/developers/specifications/1999024.html>`_, which details SMPTE Time Code encapsulation within IEC 61883-6
* `MIDI MMA AVB Payload Formats <http://www.midi.org/techspecs/avbtp.php>`_

What are the minimum requirements for an AVB switch?
----------------------------------------------------

An AVB Switch is required to support:

* IEEE Std. 802.1Q-2011 FQTSS and SRP.
* IEEE Std. 802.1AS-2011 on each AVB enabled ethernet port

What are the minimum requirements for an AVB device?
----------------------------------------------------

An AVB Device that is both an AVDECC Talker and AVDECC Listener is required to support:

* IEEE Std. 802.1Q-2011 FQTSS and SRP.
* IEEE Std. 802.1AS-2011 on each AVB enabled ethernet port
* IEEE Std. 1722.1-2013

What are 802.1Qav and 802.1Qat?
-------------------------------

802.1Qav and 802.1Qat are two of the ammendments to IEEE Std 802.1Q-2005 that were rolled into IEEE Std 802.1Q-2011.

* What was known as 802.1Qav is now known as IEEE Std 802.1Q-2011 Clause 34, "Forwarding and Queuing for time-sensitive streams".
* What was known as 802.1Qat is now known as IEEE Std 802.1Q-2011 Clause 35, "Stream Reservation Protocol".

Someone said that an AVB endpoint does not have to support Qav, Qat - the AVB switch can take care of it
--------------------------------------------------------------------------------------------------------

That is incorrect.  All end points are required to implement 802.1AS-2011, 802.1Qav AND 802.1Qat.  This is all defined in IEEE Std 802.1BA-2011.

Specifically see the PICS requirements for talkers defined in IEEE Std 802.1BA-2011 Clause 7.4.7,"Common requirements - Talker end stations" where it shows in Clause 7.4.7.1 the item "T-AS" requires 802.1AS, "T-SRP" requires 802.1Qat, and item "T-FQ" which requires forwarding and queuing of time sensitive streams (FQTSS) aka 802.1Qav. Further details of these requirements are in 7.4.7.2, and 7.4.7.3.

What is the difference between PTP, PTPv2, gPTP, 802.1AS and IEEE 1588?
-----------------------------------------------------------------------

* IEEE Std 1588-2008 defines the PTPv2 (Precision Time Protocol Version 2) framework and is also known as PTPv2.
* IEEE Std 802.1AS-2011 defines a specific profile of IEEE 1588-2008 with additional timing features which greatly improve timing accuracy and lock time.  This is called gPTP (Generalized Precision Time Protocol).

Can an AVB device just use IEEE 1588v2 (PTP) instead of 802.1AS?
----------------------------------------------------------------

No, IEEE 802.1AS is required to maintain the required synchronization compatibility and accuracy.

Can FQTSS be implemented in pure software?
------------------------------------------

IEEE Std 802.1Q-2011 Clause 34, "Forwarding and Queuing for time-sensitive streams (FQTSS)" is important to implement on Talkers.  For devices that need to transmit many streams at the same time, you really want hardware support in the ethernet interface to assist in scheduling the time-sensitive packets for transmission.

If you have only one stream, it is typically feasible to implement FQTSS in software - Specifically for a class A stream you need to send one packet every 125 microseconds and no faster.  You can do this on a CPU with a high frequency timer interrupt.

But if you were needing to provide 4 streams simultaneously, then it is much harder to do in software as you then need to send a time sensitive stream packet every 31 microseconds (and no sooner).

Since this can be expensive and inefficient to implement in software so ideally you want an Ethernet interface like the intel i210 ( with the driver at https://github.com/intel-ethernet/Open-AVB/tree/master/kmod/igb ) or the equivalent Broadcom ethernet chip which the Apple Mac OS X uses.

How many channels of audio can you have on a network link with AVB?
-------------------------------------------------------------------

The answer to this question depends on:

* The bandwidth of the network link (100baseT or gigabit Ethernet)
* The channels per stream
* The format of the audio media
* The count of streams

Use the `tools </tags/cat_tools.html>`_ to calculate arbitrary combinations.

For the very detailed explanations of the contents of an AVB Audio Ethernet frame, see the `Maximum AVB Channel Counts </page/presentations/maximum-avb-channel-counts/>`_ presentation.

Common examples:

One Channel Per Stream
``````````````````````


Using one channel per stream is the most inefficient but also the most flexible:  

.. container:: table-responsive

   .. table:: Maximum streams per link, 1 channel per stream
      :class: table-condensed table-striped table-bordered table-hover table

      ==========   ===========   ===============   ============   =============
      Link Speed   Sample Rate   Channels/Stream   Streams/Link   Channels/Link
      ==========   ===========   ===============   ============   =============
      100base-T    48 kHz               1               11              11
      GigE         48 kHz               1              113             113
      100base-T    96 kHz               1                9               9
      GigE         96 kHz               1               92              92
      ==========   ===========   ===============   ============   =============


Maximum Channels Per Stream
```````````````````````````

The maximum number of channels that can be put in a single stream is dependant on packet time, packet size, and audio format:

.. container:: table-responsive

   .. table:: Maximum channels per stream and per link
      :class: table-condensed table-striped table-bordered table-hover table

      ==========   ===========   ===============   ============   =============
      Link Speed   Sample Rate   Channels/Stream   Streams/Link   Channels/Link
      ==========   ===========   ===============   ============   =============
      100base-T    48 kHz              39                1              39
      GigE         48 kHz              52                7             364
      100base-T    96 kHz              21                1              21
      GigE         96 kHz              28                7             196
      ==========   ===========   ===============   ============   =============


How many AVB streams of audio can you have on an entire network?
----------------------------------------------------------------

The maximum number of streams on an AVB network depends on the streams properties.

* If the streams properties are not packable, there can be 318 streams on a network - each with 1 or more channels of audio.
* If each talker device provides streams with stream properties that are packable, there can be 318 talkers on a network each with as many streams as they can fit on their links.
* If all the stream properties across the entire network are packable, there can be much more than 318 talkers on a network.

What makes stream properties packable?
--------------------------------------

A stream has the following properties:

* Stream ID
* Destination MAC Address
* Stream Class
* Bandwidth
* MSRP Accumulated Latency

In order for two streams to be "Packable," the two streams are required to have the same Stream Class, Bandwidth, MSRP Accumulated Latency.  The two streams must have consecutive Stream ID's and Destination MAC addresses.

A Talker that provides multiple streams of the same size would typically automatically have packable stream properties.

In order to have packable streams from multiple talkers on the network the AVDECC Controller is required to use the **SET_STREAM_INFO** command to manually set the Stream ID and Destination MAC address for each talker stream source.


Are all the standards involved in AVB complete?
-----------------------------------------------

Yes, with the completion of IEEE Std 1722.1-2013 in August, 2013 all of the standards required for a full complete end user experience are completed, ratified, published, and available for download or purchase.


What additional work is being done for AVB standardization?
-----------------------------------------------------------

The `IEEE 1722 working group <http://grouper.ieee.org/groups/1722/>`_ is currently working on an amendment to IEEE Std 1722-2011 called IEEE P1722A which will include support for additional media streaming formats:

* AVTP Audio Format (allowing for more flexibility of bit widths, samples per packet, and channel counts.
* Compressed Video Format (allowing for H.264, MJPEG, and JPEG2000 formats)
* Automotive Control (allowing for real time transport of FlexRay™, CAN FD, LIN®, and MOST® messages)
* Clock Reference Streams (for transporting arbitrary clocks including video verticle and horizontal sync clocks)
* Coded Audio (allowing for Dolby™ E and other coded audio formats)
* Time Sensitive Control Streams (for transporting IEEE Std 1722-2013 and other control protocols within an AVB Stream)
* SDI Video Format (for transporting high definition uncompressed video via `SMPTE Serial Digital Interface <http://en.wikipedia.org/wiki/Serial_digital_interface>`_ )
* Active Video Format (for transporting generic video frame buffers)

IEEE P1722A also adds session based `AES-GCM encrypted <http://en.wikipedia.org/wiki/Galois/Counter_Mode>`_ streams and control messages and `Elliptic Curve Signing and Encryption using IEEE Std 1363a-2004 <http://en.wikipedia.org/wiki/IEEE_P1363>`_ for control message authentication and encryption.





