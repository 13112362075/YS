# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_06_084218) do

  create_table "addtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Addtypecode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "Description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assetcards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "assetCode"
    t.string "assetname"
    t.string "Assettype_id"
    t.string "Unit_id"
    t.integer "Amount"
    t.string "Assetstatus_id"
    t.string "Addtype_id"
    t.date "BuyDate"
    t.string "Usestate_id"
    t.string "description"
    t.integer "Orgainize_id"
    t.date "Entrydate"
    t.decimal "Price", precision: 10
    t.decimal "Lastprice", precision: 10
    t.integer "Expectedperiod"
    t.integer "CNOSP"
    t.string "barcode"
    t.string "Mould"
    t.string "Assetseat_id"
    t.string "Client"
    t.string "Supplier"
    t.string "department_id"
    t.string "Employeeld"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assetseates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Assetseatecode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "Description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assetstatuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Assetstatuscode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assettypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Assettypecode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "departmentcode"
    t.string "departmentname"
    t.integer "organize_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Unitcode"
    t.string "name"
    t.integer "Unitaccuracy"
    t.string "Roundingtype"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "account"
    t.string "password"
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "telephone"
    t.string "sex"
    t.string "role"
    t.string "departmentname"
    t.integer "orgainize_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usestates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Usestatecode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "Description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
