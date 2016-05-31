require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'ci/reporter/rake/rspec'

id = Time.now.strftime('%d %b %y - %H:%M')
File.open('run_log.txt', 'a') {|f| f.write("\n#{id}")}

namespace :features do
  Cucumber::Rake::Task.new(:ui) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=firefox -t @ui -t ~@wip -t ~@manual'
  end

  Cucumber::Rake::Task.new(:non_ui) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=firefox -t ~@ui -t ~@sit -t ~@wip -t ~@manual'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_firefox) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=firefox -t ~@sit -t ~@wip'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_chrome) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=chrome -t ~@sit -t ~@wip'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_phantom) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=phantom -t ~@sit -t ~@wip'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_sit) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=firefox -t @sit -t ~@wip'
  end

  Cucumber::Rake::Task.new(:wip) do |t|
    t.profile = 'standard'
    t.cucumber_opts = 'browser=firefox -t @wip'
  end
end

task :integration => 'ci:setup:rspec' do
  sh 'rspec spec/'
end
