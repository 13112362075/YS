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

ActiveRecord::Schema.define(version: 2021_02_25_030333) do

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
    t.string "Model"
    t.decimal "Amount", precision: 10
    t.string "EXPdept"
    t.string "Employeeld"
    t.string "Asset_seat"
    t.decimal "EXPQTY", precision: 10
    t.string "IMPdept"
    t.string "Newuser"
    t.string "IMP_seat"
    t.string "fseq"
    t.string "Asset_allocate_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_allocates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "FBillno"
    t.datetime "Expdate"
    t.string "Allocate_reason"
    t.string "FBillstatus"
    t.string "Creator"
    t.string "Approver"
    t.datetime "CREATEDATE"
    t.datetime "APPROVEDATE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_countingreport_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Asset_type"
    t.string "Unit"
    t.string "Model"
    t.string "Asset_status"
    t.decimal "BookQty", precision: 10
    t.decimal "CountQty", precision: 10
    t.decimal "Variance", precision: 10
    t.string "Book_seat"
    t.string "Book_dept"
    t.string "Book_User"
    t.string "Invent_seat"
    t.string "Invent_dept"
    t.string "InventUser"
    t.datetime "CountDate"
    t.string "Headnote"
    t.string "fseq"
    t.string "Asset_Countingreport_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_countingreports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "BillNo"
    t.string "description"
    t.string "Creator"
    t.datetime "CREATEDATE"
    t.string "Approver"
    t.string "APPROVEDATE"
    t.string "fbillstatus"
    t.datetime "fdate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_disposal_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Unit"
    t.decimal "Amount", precision: 10
    t.decimal "DisposeAmount", precision: 10
    t.string "Asset_seat"
    t.decimal "DisposePrice", precision: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fseq"
    t.string "AssetDisposal_id"
    t.string "Addtype_id"
    t.string "Usestate_id"
  end

  create_table "asset_disposals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "FBillno"
    t.date "DisposeDate"
    t.string "Disposemethod"
    t.string "DisposeReason"
    t.string "Fbillstatus"
    t.string "Creator"
    t.string "Approver"
    t.datetime "CreateDate"
    t.datetime "ApproveDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_gain_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Asset_type"
    t.string "Unit"
    t.decimal "BookQty", precision: 10
    t.decimal "CountQty", precision: 10
    t.decimal "GainQty", precision: 10
    t.string "Book_seat"
    t.string "Book_dept"
    t.string "Book_User"
    t.string "Actual_seat"
    t.string "Actual_dept"
    t.string "Actual_User"
    t.string "fseq"
    t.string "Asset_Gain_id"
    t.string "FSrcFbillno"
    t.string "FSrcFseq"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_gains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "BillNo"
    t.string "description"
    t.datetime "fdate"
    t.string "fbillstatus"
    t.string "Creator"
    t.string "Approver"
    t.string "CREATEDATE"
    t.string "APPROVEDATE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_loss_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Asset_type"
    t.string "Unit"
    t.decimal "BookQty", precision: 10
    t.decimal "CountQty", precision: 10
    t.decimal "LossQty", precision: 10
    t.string "Book_seat"
    t.string "Book_dept"
    t.string "Book_User"
    t.string "Actual_seat"
    t.string "Actual_dept"
    t.string "Actual_User"
    t.string "fseq"
    t.string "Asset_Loss_id"
    t.string "FSrcFbillno"
    t.string "FSrcFseq"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_losses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "BillNo"
    t.string "description"
    t.datetime "fdate"
    t.string "fbillstatus"
    t.string "Creator"
    t.string "Approver"
    t.string "CREATEDATE"
    t.string "APPROVEDATE"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asset_picking_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Code"
    t.string "name"
    t.string "Asset_type"
    t.string "Unit"
    t.decimal "Picking_Amount", precision: 10
    t.decimal "BackQty", precision: 10
    t.decimal "CanbackQty", precision: 10
    t.string "PickingFor"
    t.string "Asset_seat"
    t.string "Picking_seat"
    t.string "FSrcFbillno"
    t.string "FSrcFseq"
    t.string "AssetPicking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "Deptment"
    t.string "Employeeld"
    t.string "assetstatus"
    t.string "fseq"
  end

  create_table "asset_pickings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "FBillno"
    t.string "Type_of_business"
    t.datetime "Picking_Date"
    t.string "Picking_Dept"
    t.string "Picking_Employeeld"
    t.string "Fbillstatus"
    t.string "Creator"
    t.string "Approver"
    t.datetime "CreateDate"
    t.datetime "ApproveDate"
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
    t.string "Deptment"
    t.string "Employeeld"
    t.string "Asset_seat"
    t.string "Last_seat"
    t.integer "AssetTurnoverDetail_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "FSrcFbillno"
    t.string "FSrcFseq"
    t.string "fseq"
  end

  create_table "asset_turnover_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Document_number"
    t.date "Borrowing_date"
    t.string "Borrowing_Department"
    t.string "Borrowed_To_id"
    t.string "Loaner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "Creator"
    t.datetime "Createdate"
    t.string "Approver"
    t.datetime "Approverdate"
    t.string "fbillstatus"
    t.string "Type_of_business"
  end

  create_table "assetalter_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Altertype"
    t.string "Information_Old"
    t.string "Information_New"
    t.integer "Assetalter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "assetalters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "Fbillno"
    t.string "assetCode"
    t.string "assetname"
    t.string "Assettype_id"
    t.string "Unit_id"
    t.integer "Amount"
    t.string "Assetstatus_id"
    t.string "Addtype_id"
    t.datetime "BuyDate"
    t.string "description"
    t.string "Orgainize_id"
    t.datetime "Entrydate"
    t.decimal "Price", precision: 10
    t.decimal "Lastprice", precision: 10
    t.integer "Expectedperiod"
    t.string "CNOSP"
    t.string "barcode"
    t.string "Mould"
    t.string "Assetseat_id"
    t.string "Client"
    t.string "Supplier"
    t.string "department_id"
    t.string "Employeeld"
    t.string "assetCode_Old"
    t.string "assetname_Old"
    t.string "Assettype_id_Old"
    t.string "Unit_id_Old"
    t.integer "Amount_Old"
    t.string "Assetstatus_id_Old"
    t.string "Addtype_id_Old"
    t.datetime "BuyDate_Old"
    t.string "description_Old"
    t.string "Orgainize_id_Old"
    t.datetime "Entrydate_Old"
    t.decimal "Price_Old", precision: 10
    t.decimal "Lastprice_Old", precision: 10
    t.integer "Expectedperiod_Old"
    t.string "CNOSP_Old"
    t.string "barcode_Old"
    t.string "Mould_Old"
    t.string "Assetseat_id_Old"
    t.string "Client_Old"
    t.string "Supplier_Old"
    t.string "department_id_Old"
    t.string "Employeeld_Old"
    t.string "fbillstatus"
    t.string "Creator"
    t.datetime "Createdate"
    t.string "Approver"
    t.datetime "Approverdate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "Usestate_id"
    t.string "Usestate_id_Old"
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
    t.string "fbillstatus"
    t.string "Creator"
    t.datetime "Createdate"
    t.string "Approver"
    t.datetime "Approverdate"
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
    t.string "fbillstatus"
    t.string "Creator"
    t.datetime "CreateDate"
    t.string "Approver"
    t.datetime "ApproverDate"
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
