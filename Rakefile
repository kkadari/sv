require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

namespace :features do
  Cucumber::Rake::Task.new(:cert_ce_sv_ref_firefox) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = 'browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t ~@quarantine -t ~@manual'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_chrome) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = 'browser=chrome -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t ~@quarantine -t ~@manual'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_phantom) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = 'browser=phantom -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t ~@quarantine -t ~@manual'
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_sit) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = 'browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t @sit -t ~@quarantine -t ~@manual'
  end

  Cucumber::Rake::Task.new(:wip) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = 'browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t @wip -t ~@manual'
  end
end


