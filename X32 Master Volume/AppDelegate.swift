//
//  AppDelegate.swift
//  X32 Master Volume
//
//  Created by Adam Ware on 26/9/2023.
//

import Foundation
import Cocoa
import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let contentView = ContentView()
        
        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 86, height: 260)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        
        // Create the status item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        
        if let button = self.statusBarItem.button {
            button.image = NSImage(named: "x32")
            button.action = #selector(togglePopover(_:))
        }
        
        setupEventListener()
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = self.statusBarItem.button {
            if popover.isShown {
                closePopover(sender: sender)
            } else {
                showPopover(sender: sender, button: button)
            }
        }
    }
    
    @objc func showPopover(sender: Any?, button: NSStatusBarButton) {
       popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
       eventMonitor?.start()
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    private func setupEventListener() {
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                strongSelf.closePopover(sender: event)
            }
        }
    }

    
}
