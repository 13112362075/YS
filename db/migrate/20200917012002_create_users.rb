class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :account #用户名
      t.string :password  #密码
      t.string :name  #姓名
      t.string :address  #地址
      t.string :email  #邮箱
      t.string :telephone  #电话
      t.string :sex  #性别
      t.string :role  #角色
      t.integer :department_id  #所属部门
      t.integer :orgainize_id  #所属组织
      t.timestamps
    end
  end
end
