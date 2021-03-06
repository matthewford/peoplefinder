class RemoveYamlNamespace < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE versions
      SET
        item_type = replace(item_type, 'Peoplefinder::', ''),
        object = replace(object, 'Peoplefinder::', ''),
        object_changes = replace(object_changes, 'Peoplefinder::', '');
    SQL
  end
end
