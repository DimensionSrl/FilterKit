Pod::Spec.new do |s|
  s.name                      = 'FilterKit'
  s.version                   = '0.9.6'
  s.summary                   = 'Multiple filter DSL'
  s.description               = <<-DESC
  FilterKit is a component written in Swift that let you validate or filter an object, based on a set of properties listed in a dictionary.
                            DESC
  s.homepage                  = 'https://github.com/dimensionsrl/FilterKit'
  s.license                   = { :type => 'MIT', :file => 'LICENSE' }
  s.authors                   = { 'DIMENSION S.r.l.' => 'info@dimension.it', 'Matteo Gavagnin' => 'm@macteo.it' }
  s.social_media_url          = 'https://twitter.com/macteo'

  s.default_subspec = 'Watch'

  s.source                    = { :git => 'https://github.com/dimensionsrl/FilterKit.git', :tag => "v#{s.version}" }
  s.source_files              = "Sources/**/*.{swift}"
  s.requires_arc              = true

  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.9'
  s.tvos.deployment_target    = '9.0'

  s.subspec 'Watch' do |ws|
    ws.watchos.deployment_target = '2.0'
    ws.source_files             = "Sources/**/*.{swift}"
  end

  s.test_spec 'Tests' do |ts|
    ts.source_files    = 'Tests/FilterKitTests/**/*.{h,m,swift}'
    ts.resources       = 'Tests/FilterKitTests/Fixtures/*.json'
  end
end
