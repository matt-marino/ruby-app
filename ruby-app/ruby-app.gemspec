Gem::Specification.new do |s|
  s.name = "Matts_First_Gem"
  s.version = "0.1.0"
  s.author = "Matt Marino"
  s.email = "mattm1265@gmail.com"
  s.homepage = ""
  s.summary = "A Simple Text Based ruby game"
  s.description = File.read(File.join(File.dirname(__FILE__), "README"))
  s.licenses = ["MIT"]

  s.files = Dir["{bin,lib,spec}/**/*"]
  s.test_files = Dir["spec/**/*"]
  s.executables = ["studio_game"]

  s.required_ruby_version = ">=1.9"
  s.add_development_dependency "rspec", "~> 2.8", ">= 2.8.0"
end
