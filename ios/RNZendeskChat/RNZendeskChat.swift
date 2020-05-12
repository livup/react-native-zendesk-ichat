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
import MessagingAPI

@objc(RNZendeskChat)
class RNZendeskChat: RCTViewManager {
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    var accountKey: String = "4dJHyAkYBAqJqjJusiThkeCnPH6tMmda"
    
    @objc func setVisitorInfo(_ options: NSDictionary) -> Void {
        let chatAPIConfiguration = ChatAPIConfiguration();
        
        if (options["department"] as? String) != nil {
            chatAPIConfiguration.department = (options["department"] as! String);
        }
        
        chatAPIConfiguration.visitorInfo = VisitorInfo(
            name: options["name"] as! String,
            email: options["email"] as! String,
            phoneNumber: options["phone"] as! String);
        
        if (options["tags"] != nil) {
            chatAPIConfiguration.tags = (options["tags"] as? [String])!;
        }
        
        if(Chat.instance == nil) {
            print("No chat instance")
        }
        
        Chat.instance?.configuration = chatAPIConfiguration;
    }
    
    @objc func startChat(_ options: NSDictionary) -> Void {
        DispatchQueue.main.async {
            Chat.initialize(accountKey: self.accountKey)
            self.setVisitorInfo(options)

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
            
            let chatViewController = try! Messaging.instance.buildUI(engines: [chatEngine], configs: [chatConfiguration])

            RCTPresentedViewController()?.show(chatViewController, sender: Any?.self)
        }
    }
    
    @objc func setup(_ zenDeskKey: String) -> Void {
        self.accountKey = zenDeskKey
    }
}
