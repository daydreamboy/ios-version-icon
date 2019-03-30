Pod::Spec.new do |s|
  s.name                      = 'VersionIcon'
  s.module_name               = 'VersionIcon'
  s.version                   = '0.9.2'
  s.summary                   = 'A Swift 3 based reimplementation of the Apple HUD (Volume, Ringer, Rotation,…) for iOS 8 and up'
  s.homepage                  = 'https://github.com/DanielCech/VersionIcon'
  s.license                   = 'MIT'
  s.author                    = { "Daniel Čech" => "daniel.cech@gmail.com" }
  s.platform                  = :ios, '8.0'
  s.ios.deployment_target     = '8.0'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/DanielCech/VersionIcon.git', :tag => s.version.to_s }
  s.source_files              = 'Sources/**/*'
  # s.resource_bundle           = { 'PKHUDResources' => 'PKHUD/*.xcassets' }
  s.swift_version             = '4.0'
end
