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
