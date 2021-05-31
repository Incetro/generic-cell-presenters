Pod::Spec.new do |spec|
  spec.name          = 'incetro-generic-cell-presenters'
  spec.module_name   = 'GenericCellPresenters'
  spec.version       = '1.0.0'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru' }
  spec.homepage      = "https://github.com/Incetro/generic-cell-presenters.git"
  spec.summary       = 'Swift micro library that simplifies dealing with lists of data in a UITableView or UICollectionView'
  spec.platform      = :ios, "12.0"
  spec.swift_version = '5.3'
  spec.source        = { git: "https://github.com/Incetro/generic-cell-presenters.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/GenericCellPresenters/**/*.{h,swift}"
end