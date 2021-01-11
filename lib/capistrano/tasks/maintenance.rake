namespace :maintenance do
  desc 'start maintenance'
  task :on do
    on roles(:web) do
      target_dir = "#{shared_path}/public/tmp"
      target_path = "#{target_dir}/maintenance.html"
      source_path = "#{release_path}/public/maintenance.html"
      execute :mkdir, '-p', target_dir
      execute :cp, '-f', source_path, target_path
    end
  end

  desc 'stop maintenance'
  task :off do
    on roles(:web) do
      target = "#{shared_path}/public/tmp/maintenance.html"
      execute :rm, target if test "[ -f #{target} ]"
    end
  end
end
