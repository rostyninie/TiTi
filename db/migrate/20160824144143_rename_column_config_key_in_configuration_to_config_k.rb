class RenameColumnConfigKeyInConfigurationToConfigK < ActiveRecord::Migration
  def change
    rename_column :configurations, :config_key, :config_k
  end
end
