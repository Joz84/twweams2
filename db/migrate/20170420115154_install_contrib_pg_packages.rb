class InstallContribPgPackages < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
    execute "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;"
    execute "CREATE EXTENSION IF NOT EXISTS unaccent;"
  end

  def down
    execute "DROP EXTENSION IF EXISTS pg_trgm;"
    execute "DROP EXTENSION IF EXISTS fuzzystrmatch;"
    execute "DROP EXTENSION IF EXISTS unaccent;"
  end
end

# You should install those packages manually with super user powers
# sudo -u postgres psql twweams2_development
# CREATE EXTENSION IF NOT EXISTS pg_trgm;
# CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
# CREATE EXTENSION IF NOT EXISTS unaccent;
