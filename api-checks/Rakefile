require 'rubygems'
require 'ci/reporter/rake/rspec'

task :integration => 'ci:setup:rspec' do
  sh 'rspec spec --color'
end
