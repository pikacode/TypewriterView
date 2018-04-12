

Pod::Spec.new do |s|

  s.name         = "TypewriterView"
  s.version      = "1.0.0"
  s.summary      = "A simple but usefull typewriter view subclass of UITextView."
  s.homepage     = "https://github.com/pikacode/TypewriterView"
  s.license      = "MIT"
  s.author	 = { "pikacode" => "pikacode@qq.com" }
  s.platform     = :ios, "8.0"

  
  s.source       = { :git => "https://github.com/pikacode/TypewriterView.git", :tag => "#{s.version}" }


   s.source_files  = "TypewriterView/*.{swift}"

#   s.public_header_files = "TypewriterView/*.{swift}"


  
   s.frameworks = "UIKit", "Foundation"
  
   s.requires_arc = true

end
