require 'premailer'

premailer = Premailer.new('latest_run.html', :warn_level => Premailer::Warnings::SAFE)

email = File.open("email.html", "w")
email.puts premailer.to_inline_css
email.close