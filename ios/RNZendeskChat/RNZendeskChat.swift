//
//  RNZendeskChat.swift
//  RNZendeskChat
//
//  Created by Adalberto da Silva on 07/05/20.
//  Copyright © 2020 TaskRabbit. All rights reserved.
//

import Foundation

import ChatSDK
import ChatProvidersSDK
import MessagingSDK

@objc(RNZendeskChat)
class RNZendeskChat: RCTViewManager {
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func setVisitorInfo(_ options: NSDictionary) -> Void {
        let chatAPIConfiguration = ChatAPIConfiguration();
        if options["department"] != nil {
            chatAPIConfiguration.department = options["department"] as? String;
        }
        
        chatAPIConfiguration.visitorInfo = VisitorInfo(
            name: options["name"] as! String,
            email: options["email"] as! String,
            phoneNumber: options["phone"] as! String);
        
        if (options["tags"] != nil) {
            chatAPIConfiguration.tags = options["tags"] as! [String];
        }
        
        Chat.instance?.configuration = chatAPIConfiguration;
    }
    
    @objc func startChat(_ options: NSDictionary) -> Void {
        DispatchQueue.main.async {
            let messagingConfiguration = MessagingConfiguration()
            messagingConfiguration.name = "Chat"

            let chatConfiguration = ChatConfiguration()
            chatConfiguration.isPreChatFormEnabled = true

            // Build view controller
            let chatEngine = try! ChatEngine.engine()
            let chatViewController = try! Messaging.instance.buildUI(engines: [chatEngine], configs: [messagingConfiguration, chatConfiguration])
            
            RCTPresentedViewController()?.navigationController?.pushViewController(chatViewController, animated: true)
        }
    }
    
    @objc func `init`(_ zenDeskKey: String) -> Void {
        Chat.initialize(accountKey: zenDeskKey)
    }
}
