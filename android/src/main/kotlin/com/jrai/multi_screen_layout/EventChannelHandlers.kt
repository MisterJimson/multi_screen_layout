package com.jrai.multi_screen_layout

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

class WindowLayoutInfoEventChannelHandler(messenger: BinaryMessenger): EventChannel.StreamHandler {
    var sink: EventChannel.EventSink? = null

    init {
        val eventChannel = EventChannel(messenger, "multi_screen_layout_layout_state_change")
        eventChannel.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}