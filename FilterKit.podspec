Pod::Spec.new do |s|
  s.name                  = "FilterKit"
  s.version               = "0.9.0"
  s.summary               = "Multiple filter DSL"
  s.description           = <<-DESC
  Combine multiple filters to achive custom results.
                            DESC
  s.homepage              = "https://github.com/dimensionsrl/FilterKit"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.authors               = { "DIMENSION S.r.l." => "info@dimension.it", "Matteo Gavagnin" => "m@macteo.it" }
  s.social_media_url      = "https://twitter.com/macteo"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source                = { :git => "https://github.com/dimensionsrl/FilterKit.git", :tag => "v#{s.version}" }
  s.source_files          = "FilterKit/**/*.{swift}"
  s.requires_arc          = true
end
