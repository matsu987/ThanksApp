require "./lib/thanks_timer.rb"
namespace :thanks do
  task :timer => :environment do
    thanks_timer = ThanksTimer.new
    thanks_timer.load
  end
end