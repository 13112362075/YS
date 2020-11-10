class ChangeColumnToAssetcardColumns < ActiveRecord::Migration[6.0]
  def change
    change_column  :assetcards, :Assettype_id,:string
    change_column  :assetcards, :Unit_id ,:string
    change_column  :assetcards, :Assetstatus_id,:string
    change_column  :assetcards, :Addtype_id,:string
    change_column  :assetcards, :Usestate_id ,:string
    change_column  :assetcards, :Assetseat_id ,:string
    change_column  :assetcards, :department_id ,:string
    change_column  :assetcards, :Employeeld, :string
  end
  
end
