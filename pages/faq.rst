.. link: 
.. description: 
.. category: FAQ
.. date: 2014/02/10 08:08:00
.. title: General AVB FAQ
.. slug: faq

.. sectnum::

.. contents:: 


What is this website for?
-------------------------

See `About avb.statusbar.com </>`_.

What is AVB?
------------

`Audio Video Bridging <http://en.wikipedia.org/wiki/Audio_Video_Bridging>`_ is a term for a collection of IEEE Standards for time sensitive networking which facilitates the transport of high performance audio and video on a LAN.

For details of the standards involved, see the `AVB Developer FAQ </page/developer-faq>`_.

What are the minimum requirements for an AVB switch?
----------------------------------------------------

An AVB Switch is required to support:

* IEEE Std. 802.1Q-2011 `FQTSS <developer#fqtss>`_ and `SRP <developer#srp>`.
* IEEE Std. 802.1AS-2011 `gPTP <developer#gptp>`_ on each AVB enabled ethernet port

`AVnu Compliance <http://avnu.org>`_ is important for a switch to have in order to ensure correct operation of your AVB network.

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

   .. table:: Maximum streams per link, 1 channel per stream using async packetization
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

   .. table:: Maximum channels per stream and per link using async packetization
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


Are all the standards involved in AVB complete?
-----------------------------------------------

Yes, with the completion of IEEE Std 1722.1-2013 in August, 2013 all of the standards required for a full complete end user experience are completed, ratified, published, and available for download or purchase.



