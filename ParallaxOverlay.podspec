Pod::Spec.new do |s|
  s.name         = "ParallaxOverlay"
  s.version      = "0.1"
  s.summary      = "ParallaxOverlay creates some slick parallax animation"
  s.description  = <<-DESC
  HugeTabBarButton lets you create a tab bar button with as huge of an image as you want
                   DESC

  s.homepage      = "https://github.com/fortmarek/ParallaxOverlay"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { 'Marek Fort' => 'marekfort@me.com' }
  s.source        = { :git => "https://github.com/fortmarek/ParallaxOverlay.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/"
  s.swift_version = "5.1"
  s.ios.deployment_target = "9.0"
  
end

