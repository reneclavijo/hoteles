namespace :deploy do
    desc "Recargando la base de datos con el archivo SEED"
    task :semilla do
        on roles(:all) do
            within release_path do
                execute :bundle, :exec, 'rails', 'db:seed', 'RAILS_ENV=production'
            end
        end
    end
end

after "deploy:migrate", "semilla"
