Pod::Spec.new do |s|
  s.name                      = "InkPageIndicator"
  s.version                   = "2.0.4"
  s.summary                   = "InkPageIndicator"
  s.homepage                  = "https://github.com/InkPageIndicator/InkPageIndicator.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "InkPageIndicator" => "kimtaesoo188@gmail.com" }
  s.ios.deployment_target     = "10.0"
  s.source       			  = { :git => "https://github.com/InkPageIndicator/InkPageIndicator.git", :tag => s.version }
  s.default_subspec           = "Core"
  s.swift_version             = '5.0'

  s.subspec "Core" do |ss|
  ss.source_files  = "Sources/InkPage/**/*.{swift,h,m}"
  ss.framework  = "Foundation"
  end

  s.subspec "RxInkPage" do |ss|
  ss.source_files = "Sources/RxInkPage/**/*.{swift,h,m}"
  ss.dependency "InkPageIndicator/Core"
  ss.dependency "RxSwift", "~> 5.0"
  ss.dependency "RxCocoa", "~> 5.0"
  end

end
