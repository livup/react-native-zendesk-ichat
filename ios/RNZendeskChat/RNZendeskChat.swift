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

@objc class RNZendeskChat: NSObject<RCTBridgeModule> {
    
    @objc func setVisitorInfo(options: NSDictionary) -> Void {
        let chatAPIConfiguration = ChatAPIConfiguration();
        if options["department"] {
            chatAPIConfiguration.department = options["department"];
        }
        
        chatAPIConfiguration.visitorInfo = VisitorInfo(name: options["name"], email: options{"email"}, phoneNumber: options["phone"]);
        
        if options["tags"] {
            chatAPIConfiguration.tags = options["tags"];
        }
        
        Chat.instance?.configuration = chatAPIConfiguration;
    }
    
    @objc func startChat(options: NSDictionary) -> Void {
        
        let messagingConfiguration = MessagingConfiguration()
        messagingConfiguration.name = "Chat"

        let chatConfiguration = ChatConfiguration()
        chatConfiguration.isPreChatFormEnabled = true

        // Build view controller
        let chatEngine = try ChatEngine.engine()
        let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [messagingConfiguration, chatConfiguration])

        // Present view controller
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func init(zenDeskKey: NSString) -> Void {
        Chat.initialize(accountKey: zenDeskKey)
    }
}
