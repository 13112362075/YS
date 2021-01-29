module AssetcardsHelper
    def Update_datas(type,datas,status)  #修改资产卡片信息 
        if(type=="资产领用单") 
            @assetPicking=AssetPicking.find(datas[:id]) 
            if( @assetPicking.Type_of_business=="领用")
                if(status=="领用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id])
                    @AssetPickingEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: @assetPicking.Picking_Dept,Employeeld: @assetPicking.Picking_Employeeld) 
                    end 
                end
                if(status=="可用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id]) 
                    @AssetPickingEntry.each do |i|
                        puts i.id
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld) 
                    end 
                end
            end 
            if( @assetPicking.Type_of_business=="退回") 
                if(status=="可用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id])
                    @AssetPickingEntry.each do |i| 
                        sql="select a.* from asset_picking_entries a  inner join asset_pickings   b  on  b.id=a.AssetPicking_id    where      b.FBillno=  '#{ i.FSrcFbillno }'  and  a.fseq = "  + i.FSrcFseq
                        puts sql
                        @AssetPickingEntry_old =AssetPickingEntry.find_by_sql (sql) 
                        @AssetPickingEntry_old[0].update(BackQty: 1,CanbackQty:0);
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld) 
                    end 
                end
            end
        end
    end
end 