Pod::Spec.new do |s|
  s.name                      = "InkPageIndicator"
  s.version                   = "1.0.0"
  s.summary                   = "InkPageIndicator"
  s.homepage                  = "git@github.com:kimtaesu/InkPageIndicator.git"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Tyler" => "kimtaesoo188@gmail.com" }
  s.ios.deployment_target     = "8.0"
  s.source       			  = { :git => "https://github.com/kimtaesu/InkPageIndicator.git", :tag => s.version }
  s.default_subspec           = "Core"
  s.swift_version             = '5.0'

  s.subspec "Core" do |ss|
  ss.source_files  = "Sources/InkPage/**/*"
  ss.framework  = "Foundation"
  end

  s.subspec "RxInkPage" do |ss|
  ss.source_files = "Sources/RxInkPage/**/*"
  ss.dependency "kimtaesu/Core"
  ss.dependency "RxSwift", "~> 5.0"
  end

end
