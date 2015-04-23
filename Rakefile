require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

namespace :features do
  id = Time.now.strftime("%d %b %y - %H:%M")
  File.open('reporting/run_log.txt', 'a') {|f| f.write("\n#{id}")}

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_firefox) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = "browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t ~@quarantine"
  end

  Cucumber::Rake::Task.new(:cert_ce_sv_ref_chrome) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = "browser=chrome -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t ~@quarantine"
  end  
  
  Cucumber::Rake::Task.new(:cert_ce_sv_ref_sit) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = "browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t @sit -t ~@quarantine"
  end

  Cucumber::Rake::Task.new(:cert_ce_cpc_test) do |t|
    t.profile = 'cert_ce_cpc_test'
    t.cucumber_opts = "browser=firefox --format html --out reporting/latest_run.html -t ~@quarantine"
  end

  Cucumber::Rake::Task.new(:cert_ce_cpc_test_sit) do |t|
    t.profile = 'cert_ce_cpc_test'
    t.cucumber_opts = "browser=firefox --format html --out reporting/latest_run.html -t @sit -t ~@quarantine"
  end

  Cucumber::Rake::Task.new(:wip) do |t|
    t.profile = 'cert_ce_sv_ref'
    t.cucumber_opts = "browser=firefox -c --format html --out reporting/latest_run.html -f json --out reporting/latest_run.json -f junit --out reporting/junit -t @wip"
  end
end
