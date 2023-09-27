//
//  MainViewModel.swift
//  X32 Master Volume
//
//  Created by Adam Ware on 25/9/2023.
//

import Foundation
import Gong
import AppKit

class MainViewModel: ObservableObject {
    
    let x32MixerDevice = MIDIDevice(named: "X-USB")
    @Published var errorString: String?
    @Published var showError: Bool = false
    @Published var currentVolume: Float = 0.8 {
        didSet {
            self.updateMasterVolumeLevel(level: currentVolume)
        }
    }

    func updateMasterVolumeLevel(level: Float) {
        guard let device = x32MixerDevice, let output = MIDI.output else {
            // this doesnt actually return if the device is off
            self.showError = true
            self.errorString = "Midi device not found, or output disabled"
            return
        }
        let message: MIDIPacket.Message = .controlChange(channel: 0, controller: 70, value: return8BitMidiValue(value: level))
        let controlMessage = MIDIPacket(message)
        device.send(controlMessage, via: output)
    }
    
    func setupMidi() {
        // Method doesnt return an error
        MIDI.connect()
    }
    
    func closeApplication() {
        NSApplication.shared.terminate(self)
    }
    
    private func return8BitMidiValue(value: Float)-> UInt8 {
        return UInt8(127 * value)
    }
    
}
