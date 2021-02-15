json.extract! asset_loss_entry, :id, :Code, :name, :Asset_type, :Unit, :BookQty, :CountQty, :LossQty, :Book_seat, :Book_dept, :Book_User, :Actual_seat, :Actual_dept, :Actual_User, :fseq, :Asset_Loss_id, :FSrcFbillno, :FSrcFseq, :created_at, :updated_at
json.url asset_loss_entry_url(asset_loss_entry, format: :json)
