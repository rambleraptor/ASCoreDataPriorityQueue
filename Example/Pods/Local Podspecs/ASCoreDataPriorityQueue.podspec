Pod::Spec.new do |s|
  s.name             = "ASCoreDataPriorityQueue"
  s.version          = "0.1.0"
  s.summary          = "A priority queue that uses Core Data to persist data"
  s.homepage         = "https://github.com/astephen2/ASCoreDataPriorityQueue"
  s.license          = 'MIT'
  s.author           = { "Alex Stephen" => "stepa@umich.edu" }
  s.source           = { :git => "https://github.com/astephen2/ASCoreDataPriorityQueue.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*.png'

end
