package com.rnzendeskchat;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.zendesk.sdk.model.push.PushRegistrationResponse;
import com.zendesk.sdk.network.impl.ZendeskConfig;
import com.zendesk.service.ErrorResponse;
import com.zendesk.service.ZendeskCallback;

import zendesk.chat.Chat;
import zendesk.chat.ChatEngine;
import zendesk.chat.ChatProvider;
import zendesk.chat.ProfileProvider;
import zendesk.chat.ChatProvidersConfiguration;
import zendesk.chat.VisitorInfo;
import zendesk.chat.ChatConfiguration;
import zendesk.messaging.MessagingActivity;


public class RNZendeskChatModule extends ReactContextBaseJavaModule {
    private ReactContext mReactContext;

    public RNZendeskChatModule(ReactApplicationContext reactContext) {
        super(reactContext);
        mReactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNZendeskChat";
    }

    @ReactMethod
    public void setVisitorInfo(ReadableMap options) {
        VisitorInfo.Builder builder = VisitorInfo.builder();

        if (options.hasKey("name")) {
            builder.withName(options.getString("name"));
        }
        if (options.hasKey("email")) {
            builder.withEmail(options.getString("email"));
        }
        if (options.hasKey("phone")) {
            builder.withPhoneNumber(options.getString("phone"));
        }

        VisitorInfo visitorInfo = builder.build();

        ChatProvidersConfiguration.Builder chatProvidersConfiguration = ChatProvidersConfiguration.builder();
        
        chatProvidersConfiguration.withVisitorInfo(visitorInfo);

        if (options.hasKey("department")) {
            String departmentName = options.getString("department");
            chatProvidersConfiguration.withDepartment(departmentName);
        }
        
        ChatProvidersConfiguration configuredChat = chatProvidersConfiguration.build();
        Chat.INSTANCE.setChatProvidersConfiguration(configuredChat);
    }

    @ReactMethod
    public void init(String key) {
        Chat.INSTANCE.init(mReactContext, key);
    }

    @ReactMethod
    public void startChat(ReadableMap options) {    
        setVisitorInfo(options);

        ChatConfiguration chatConfiguration = ChatConfiguration.builder()
            .withPreChatFormEnabled(true)
            .build();
        
        Activity activity = getCurrentActivity();

         if (activity != null) {
            MessagingActivity.builder()
                .withEngines(ChatEngine.engine())
                .withBotLabelString("Liv Up")
                .show(activity, chatConfiguration);
        }        

    }
}
