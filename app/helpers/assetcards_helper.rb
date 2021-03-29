module AssetcardsHelper
    def Update_datas(type,datas,status)  #修改资产卡片信息 
        if(type=="资产领用单") 
            #资产领用单
            @assetPicking=AssetPicking.find(datas[:id]) 
            if( @assetPicking.Type_of_business=="领用")
                if(status=="领用")  
                    #如果是领用业务，更新部门、用户、资产位置为领用部门、领用人、领用后位置
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id])
                    @AssetPickingEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: @assetPicking.Picking_Dept,Employeeld: @assetPicking.Picking_Employeeld,Assetseat_id: i.Picking_seat) 
                    end 
                end
                if(status=="可用")  
                    #如果是可用业务，更新部门、用户、资产位置为原部门、原使用人、原资产位置
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id]) 
                    @AssetPickingEntry.each do |i| 
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld,Assetseat_id: i.Asset_seat) 
                    end 
                end
            end 
            if( @assetPicking.Type_of_business=="退回") 
                 #如果是退回业务，更新部门、用户、资产位置为原部门、原使用人、原资产位置
                if(status=="可用")  
                    @AssetPickingEntry  = AssetPickingEntry.where( "AssetPicking_id =  ?",   datas[:id])
                    @AssetPickingEntry.each do |i| 
                        sql="select a.* from asset_picking_entries a  inner join asset_pickings   b  on  b.id=a.AssetPicking_id    where      b.FBillno=  '#{ i.FSrcFbillno }'  and  a.fseq = "  + i.FSrcFseq
                        @AssetPickingEntry_old =AssetPickingEntry.find_by_sql (sql) 
                        @AssetPickingEntry_old[0].update(BackQty: 1,CanbackQty:0);
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code);  
                        @assetcard_by_assetCode.update(department_id: i.Deptment,Employeeld: i.Employeeld,Assetseat_id: i.Asset_seat) 
                    end 
                end
            end
        end

 

        if (type=="资产调拨单") 
            #资产调拨单
            @assetAllocate= AssetAllocate.find(datas[:id])   
            if datas[:fbillstatus]=="审核" 
                #审核更新资产卡片部门、使用人、资产位置等于调入部门、调入使用人、调入位置
                @AssetAllocateEntry = AssetAllocateEntry.where( "Asset_Allocate_id =  ?", datas[:id])
                @AssetAllocateEntry.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(department_id: i.IMPdept.lstrip.rstrip,Employeeld: i.Newuser.lstrip.rstrip,Assetseat_id: i.IMP_seat.lstrip.rstrip) 
                end
            end
            if datas[:fbillstatus]=="反审核" 
                #审核更新资产卡片部门、使用人、资产位置等于调出部门、调出使用人、调出位置
                @AssetAllocateEntry = AssetAllocateEntry.where( "Asset_Allocate_id =  ?", datas[:id])
                @AssetAllocateEntry.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);   
                    @assetcard_by_assetCode.update(department_id: i.EXPdept.lstrip.rstrip,Employeeld: i.Employeeld.lstrip.rstrip,Assetseat_id: i.Asset_seat.lstrip.rstrip) 
                end
            end 
        end

        if (type=="资产处置单") 
            #资产处置单
            @assetDisposal= AssetDisposal.find(datas[:id])    
            if datas[:fbillstatus].lstrip.rstrip=="审核" 
                #审核更新资产卡片变动方式等于资产处置单单据头变动方式，使用状态、数量等于报废、数量-处置数量
                @AssetDisposalEntry1  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",   datas[:id])
                @AssetDisposalEntry1.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);  
                    @assetcard_by_assetCode.update(Addtype_id: @assetDisposal.Disposemethod.lstrip.rstrip,Usestate_id: "报废",Amount: i.Amount-i.DisposeAmount) 
                end
            end
            if datas[:fbillstatus].lstrip.rstrip=="反审核" 
                #反审核更新资产卡片变动方式等于资产卡片原变动方式，使用状态、数量等于原使用状态、原数量
                @AssetDisposalEntry1  = AssetDisposalEntry.where( "AssetDisposal_id =  ?",   datas[:id])
                @AssetDisposalEntry1.each do |i|
                    @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);    
                    @assetcard_by_assetCode.update(Addtype_id: i.Addtype_id.lstrip.rstrip,Usestate_id:i.Usestate_id.lstrip.rstrip ,Amount: i.Amount) 
                end
            end 
        end



        if (type=="资产借出/归还单") 
            #资产借出/归还单 
            @assetTurnoverDetail=AssetTurnoverDetail.find(datas[:id]) 
            if(@assetTurnoverDetail.Type_of_business.lstrip.rstrip=="借出") 
                if datas[:fbillstatus].lstrip.rstrip=="审核"  
                    #如果是借出业务，审核更新资产卡片部门、用户、资产位置、资产状态为借用部门、借用人、借用后位置、借出
                    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",   datas[:id])
                    @assetTurnoverDetailEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);  
                        @assetcard_by_assetCode.update(Assetseat_id: i.Last_seat.lstrip.rstrip,Usestate_id: "借出",department_id:@assetTurnoverDetail.Borrowing_Department,Employeeld:@assetTurnoverDetail.Loaner)  
                    end
                end
                if datas[:fbillstatus].lstrip.rstrip=="反审核" 
                    #如果是借出业务，反审核更新资产卡片部门、用户、资产位置、资产状态为原部门、原使用人、原资产位置、可用
                    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",datas[:id])
                    @assetTurnoverDetailEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);    
                        @assetcard_by_assetCode.update(Assetseat_id: i.Asset_seat.lstrip.rstrip,Usestate_id:"可用",department_id:i.Deptment,Employeeld:i.Employeeld) 
                    end
                end 
            end 
            if(@assetTurnoverDetail.Type_of_business.lstrip.rstrip=="归还")
                if datas[:fbillstatus].lstrip.rstrip=="审核"  
                    #如果是归还业务，反审核更新资产卡片部门、用户、资产位置、资产状态为原部门、原使用人、原资产位置、可用
                     @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  datas[:id])
                    @assetTurnoverDetailEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);    
                        @assetcard_by_assetCode.update(Assetseat_id: i.Asset_seat.lstrip.rstrip,Usestate_id:"可用",department_id:i.Deptment,Employeeld:i.Employeeld ) 
                    end 
                end
                if datas[:fbillstatus].lstrip.rstrip=="反审核"
                    #如果是借出业务，审核更新资产卡片部门、用户、资产位置、资产状态为借用部门、借用人、借用后位置、借出
                    @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  datas[:id])
                    @assetTurnoverDetailEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.assetcards_Code.lstrip.rstrip);  
                        @assetcard_by_assetCode.update(Assetseat_id: i.Last_seat.lstrip.rstrip,Usestate_id: "借出",department_id:@assetTurnoverDetail.Borrowing_Department,Employeeld:@assetTurnoverDetail.Loaner)  
                    end
                end 
            end  
        end 
    end
end 