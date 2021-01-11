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



set $maintenance false;

if ( -f $document_root/tmp/maintenance.html ) {
  set $maintenance true;
}

if ( $args ~ "mode=hogehoge" ) {  
  set $maintenance false;
}

location @maintenance {
  try_files /tmp/maintenance.html /maintenance.html;
}

location /healthcheck {               # healthcheckをしている場合
  if ( $maintenance = true ) {
    return 200;
  }
}

location / {
  index index.html;

  if ( $maintenance = true ) {
    error_page 503 @maintenance;          # メンテナンスページの設定
    return 503;
  }

  try_files $uri @app;
}

# location @app {
#   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#   proxy_set_header Host $http_host;
#   proxy_redirect off;

#   proxy_pass http://unicorn;
# }
