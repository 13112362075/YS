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

ActiveRecord::Schema.define(version: 2020_12_02_022635) do

  create_table "addtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Addtypecode"
    t.string "Name"
    t.integer "Orgainize_id"
    t.string "Description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_allocate_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Unit"
    t.integer "Amount"
    t.integer "Transfer_out_quantity"
    t.string "Asset_seat"
    t.integer "Asset_allocate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_allocates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Document_number"
    t.string "Pull_up_to_id"
    t.string "Bring_in_to_id"
    t.date "Pull_up_date"
    t.string "Allocate_reason"
    t.string "Bring_in_Number"
    t.string "Bring_in_Confirm"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_recoveries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Documentnumber"
    t.string "Type_of_business"
    t.date "Requisition_Date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_recovery_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Asset_type"
    t.string "Unit"
    t.string "Requisition_Amount"
    t.integer "Amount_returned"
    t.integer "Amount_Returnable"
    t.string "Asset_status"
    t.string "Requisition_Department"
    t.string "Requisition_Employeeld"
    t.string "Requisition_use"
    t.integer "Asset_recovery_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_scrapping_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "Name"
    t.string "Unit"
    t.integer "Amount"
    t.integer "Scrapping_Amount"
    t.string "Asset_seat"
    t.integer "Asset_Scrapping_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_scrappings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Document_number"
    t.date "Date"
    t.string "Addtype"
    t.string "Addtype_Reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_turnover_detail_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "assetcards_Code"
    t.string "assetcards_name"
    t.string "Unit"
    t.decimal "Amount", precision: 10
    t.string "Reasons_for_borrowing"
    t.date "givebackPlanDate"
    t.string "Has_Been_returned"
    t.date "givebackDate"
    t.string "Deptment"
    t.string "Employeeld"
    t.string "Asset_seat"
    t.string "Last_seat"
    t.integer "AssetTurnoverDetail_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_turnover_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Document_number"
    t.date "Borrowing_date"
    t.string "Borrowing_Department"
    t.string "Borrowed_To_id"
    t.string "Loaner"
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

  create_table "inventory_plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Document_number"
    t.string "Name"
    t.string "To_id"
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
