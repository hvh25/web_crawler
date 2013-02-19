class AddSourcetypeAndJobrowcssAndCompanycssAndLocationcssAndDescriptioncssAndRequirementcssAndAvailabilitycssAndJobtypecssToBaseUrls < ActiveRecord::Migration
  def change
    add_column :base_urls, :sourcetype, :string
    add_column :base_urls, :jobrowcss, :string
    add_column :base_urls, :companycss, :string
    add_column :base_urls, :locationcss, :string
    add_column :base_urls, :descriptioncss, :string
    add_column :base_urls, :requirementcss, :string
    add_column :base_urls, :availabilitycss, :string
    add_column :base_urls, :jobtypecss, :string
  end
end
