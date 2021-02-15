module AssetcardsHelper
    def Update_datas(type,datas,status)  #修改资产卡片信息 
        if(type=="资产领用单") 
            @assetPicking=AssetPicking.find(datas[:id]) 
            if( @assetPicking.Type_of_business=="领用")
                if(status=="领用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id])
                    @AssetPickingEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: @assetPicking.Picking_Dept,Employeeld: @assetPicking.Picking_Employeeld,Assetseat_id: i.Picking_seat) 
                    end 
                end
                if(status=="可用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id]) 
                    @AssetPickingEntry.each do |i|
                        puts i.id
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld,Assetseat_id: i.Asset_seat) 
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
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld,Assetseat_id: i.Asset_seat) 
                    end 
                end
            end
        end

        if(type=="资产借出/归还单")
            @asset_turnover_detail= AssetTurnoverDetail.find(datas[:id]) 

            puts "开始"
            if (status=="借出")
                puts "1"
                @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   datas[:id])
                @assetTurnoverDetailEntry.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(department_id: @asset_turnover_detail.Borrowing_Department,Employeeld: @asset_turnover_detail.Loaner,Assetseat_id: i.Last_seat) 
                end 
            end
            if (status=="可用")
                puts "结束"
                @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   datas[:id])
                @assetTurnoverDetailEntry.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld,Assetseat_id: i.Asset_seat) 
                end 
            end 
        end
        if (type=="资产处置单")
            @assetDisposal= AssetDisposal.find(datas[:id]) 
            if(@assetDisposal.Fbillstatus=="已审核")
                @Entry_by_AssetDisposal_id  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",  "#{datas[:id]}")
                @Entry_by_AssetDisposal_id.each do |i| 
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(Addtype_id: @assetDisposal.Disposemethod) 
                end 
            end
            if(@assetDisposal.Fbillstatus=="未审核")
                @Entry_by_AssetDisposal_id  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",  "#{datas[:id]}")
                @Entry_by_AssetDisposal_id.each do |i| 
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(Addtype_id: i.Addtype_id.lstrip.rstrip) 
                end 
            end 
        end

    end
end 