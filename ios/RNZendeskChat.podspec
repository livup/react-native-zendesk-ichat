require "json"

package = JSON.parse(File.read(File.join(__dir__, '..', 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNZendeskChat"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  wolox-zendesk-chat
                   DESC
  s.homepage     = "https://github.com/github_account/wolox-zendesk-chat"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "David Tito" => "davidtito1992@gmail.com" }
  s.platforms    = { :ios => "10.3"}
  s.source       = { :git => "https://github.com/github_account/wolox-zendesk-chat.git", :tag => "#{s.version}" }

  s.source_files  = "**/*.{h,m,swift}"

  s.requires_arc = true

  s.dependency 'React'
  s.dependency 'ZendeskChatSDK'
  s.static_framework = true
  s.swift_version '5.0'
end

