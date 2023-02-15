class CreateSearchResults < ActiveRecord::Migration[7.0]
  def change
    create_table :search_results do |t|
      t.string :search_term
      t.jsonb :result_hash
      t.integer :fetch_count, default: 0

      t.timestamps
    end
    add_index :search_results, :search_term, unique: true
  end
end
