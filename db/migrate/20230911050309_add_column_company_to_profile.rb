class AddColumnCompanyToProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :company_name, :string
  end
end
