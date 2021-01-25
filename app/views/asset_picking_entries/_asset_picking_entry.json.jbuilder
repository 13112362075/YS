json.extract! asset_picking_entry, :id, :Code, :name, :Asset_type, :Unit, :Picking_Amount, :BackQty, :CanbackQty, :PickingFor, :Asset_seat, :Picking_seat, :FSrcFbillno, :FSrcFseq, :AssetPicking_id, :created_at, :updated_at
json.url asset_picking_entry_url(asset_picking_entry, format: :json)
