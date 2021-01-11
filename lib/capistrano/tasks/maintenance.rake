# namespace :maintenance do
#   desc 'start maintenance'
#   task :on do
#     on roles(:web) do
#       target_dir = "#{shared_path}/public/tmp"
#       target_path = "#{target_dir}/maintenance.html"
#       source_path = "#{release_path}/public/maintenance.html"
#       execute :mkdir, '-p', target_dir
#       execute :cp, '-f', source_path, target_path
#     end
#   end

#   desc 'stop maintenance'
#   task :off do
#     on roles(:web) do
#       target = "#{shared_path}/public/tmp/maintenance.html"
#       execute :rm, target if test "[ -f #{target} ]"
#     end
#   end
# end
namespace :maintenance do
  desc 'メンテナンス開始'
  task :start do
    on roles(:web), in: :sequence do
      within current_path do
        # tmp/maintenance.ymlがなければ config/ から tmp/ にコピーする
        unless test(:test, "-f tmp/maintenance.yml")
          execute :cp, 'config/maintenance.yml tmp/maintenance.yml'
        end
      end
    end
  end

  desc 'メンテナンス終了'
  task :finish do
    on roles(:web), in: :sequence do
      within current_path do
        # tmp/maintenance.ymlがあれば削除する
        if test(:test, "-f tmp/maintenance.yml")
          execute :rm, 'tmp/maintenance.yml'
        end
      end
    end
  end
end
