require 'rubygems'
require 'rake'
require 'lib/eor/version'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version = EOr::EOR_VERSION
    gem.name = "eor"
    gem.summary = "Adds #eor to the Proc class"
    gem.description =  "Proc#eor allows you to specify any number of Procs, and get the result of the first successful Proc"
    gem.email = "benweissmann@gmail.com"
    gem.homepage = "http://github.com/benweissmann/eor"
    gem.authors = ["Ben Weissmann"]
    gem.add_development_dependency "rspec", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*.rb']
end
