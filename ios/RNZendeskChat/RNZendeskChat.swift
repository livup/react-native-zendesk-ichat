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
 
    @objc func setVisitorInfo(_ options: NSDictionary) -> ChatAPIConfiguration {
        let chatAPIConfiguration = ChatAPIConfiguration();
        // This should remain disabled until Zendesk SDK v2 is working
        // if (options["department"] as? String) != nil {
        //     chatAPIConfiguration.department = (options["department"] as! String)
        // }
        
        
        if let name = options["name"] as? String, let email = options["email"] as? String, let phone = options["phone"] as? String {
            chatAPIConfiguration.visitorInfo = VisitorInfo(
                name: name,
                email: email,
                phoneNumber: phone
            )
        }                
        
        if let tags = options["tags"] as? [String] {
            chatAPIConfiguration.tags = tags;
        }
        
        if(Chat.instance == nil) {
            print("No chat instance")
        }
        
        return chatAPIConfiguration
    }
    
    @objc func startChat(_ options: NSDictionary) -> Void {
        DispatchQueue.main.async {
            Chat.instance?.configuration = self.setVisitorInfo(options)

            let chatEngine = try! ChatEngine.engine()
            let chatConfiguration = ChatConfiguration()

            let formConfiguration = ChatFormConfiguration(
                name: .required,
                email: (options["emailNotRequired"] != nil) ? .optional : .required,
                phoneNumber: (options["phoneNotRequired"] != nil) ? .optional : .required,
                department: (options["departmentNotRequired"] != nil) ? .optional : .required
            )

            chatConfiguration.preChatFormConfiguration = formConfiguration
            chatConfiguration.chatMenuActions = [
                ChatMenuAction.endChat
            ]
            chatConfiguration.isPreChatFormEnabled = true
            
            let chatViewController = try! Messaging.instance.buildUI(engines: [chatEngine], configs: [chatConfiguration])

            RCTPresentedViewController()?.show(chatViewController, sender: Any?.self)
        }
    }
    
    @objc func setup(_ zenDeskKey: String) -> Void {
//        This method will remain to prevent API breaking
//        self.accountKey = zenDeskKey
    }
}
