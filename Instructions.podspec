Pod::Spec.new do |s|
  s.name             = "Instructions"
  s.version          = "0.2.1"
  s.summary          = "Easily add customizable coach marks into you iOS project."
  s.homepage         = "https://github.com/ephread/Instructions"
  s.license          = 'MIT'
  s.author           = { "Frédéric Maquin" => "fred@ephread.com" }
  s.source           = { :git => "https://github.com/ephread/Instructions.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Instructions', 'Source/*.swift'
  s.resources = ["Source/*.xcassets"]
end
