module   DataCheckHelper

    def  Delete_Check(type,id ) 
        if( type == "用户")
            @user=User.find(id) 
            if(@user.role=="管理员")
               return "用户名为 ：#{@user.name} 为管理员，不允许删除!\n"
            end
            if(@user.name==session[:name] )
               return "用户名为 ：#{@user.name} 为当前登录用户，不允许删除!\n"
            end
            if( Assetcard.where( " Employeeld  =  ?",  "#{ @user.name}" ).length>0)#资产卡片
                return  "用户名："+@user.name+"已被使用，不允许删除！\n" ;
            end 
            if( AssetTurnoverDetail.where( " Loaner  =  ?",  "#{id}" ).length>0)#借用、归还单
                return  "用户名："+@user.name+"已被使用，不允许删除！\n" ;
            end  
        end 

        if(type == "部门")
            @departments=Department.find(id)
            if( Assetcard.where( " department_id  =  ?",  "#{ @departments.departmentname}" ).length>0)#资产卡片
                return  "部门："+@departments.departmentname+"已被使用，不允许删除！\n" ;
            end 
            if( AssetTurnoverDetail.where( " Borrowing_Department  =  ?",  "#{id}" ).length>0)#借用、归还单
                return  "部门："+@departments.departmentname+"已被使用，不允许删除！\n" ;
            end  
        end

        if(type=="变动方式")
            @addtype=Addtype.find(id)
            if( Assetcard.where( " Addtype_id  =  ?",  "#{ @addtype.Name}" ).length>0)#资产卡片
                return  "变动方式："+@addtype.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="资产位置")
            @assetseate=Assetseate.find(id)
            if( Assetcard.where( " Assetseat_id  =  ?",  "#{ @assetseate.Name}" ).length>0)#资产卡片
                return  "资产位置:"+@assetseate.Name+"已被使用，不允许删除！\n" ;
            end 
        end

        if(type=="资产状态")
            @assetstatus=Assetstatus.find(id)
            if( Assetcard.where( " Assetstatus_id  =  ?",  "#{ @assetstatus.Name}" ).length>0)#资产卡片
                return  "资产状态:"+@assetstatus.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="资产类型")
            @assettype=Assettype.find(id)
            if( Assetcard.where( " Assettype_id  =  ?",  "#{ @assettype.Name}" ).length>0)#资产卡片
                return  "资产类型:"+@assettype.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="计量单位")  
            @unit=Unit.find(id) 
            if( Assetcard.where( " Unit_id  =  ?",  "#{ @unit.name}" ).length>0)#资产卡片
                return  "计量单位:"+@unit.name+"已被使用，不允许删除！\n" ;
            end 
        end

 


        if(type=="使用状态")
            @usestate=Usestate.find(id)
            if( Assetcard.where( " Usestate_id  =  ?",  "#{ @usestate.Name}" ).length>0)#资产卡片
                return  "使用状态:"+@usestate.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="资产卡片")
            @assetcard=Assetcard.find(id) 
            if( AssetTurnoverDetailEntry.where( "assetcards_Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#借用、归还单 
                return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许删除！\n" ;
            end  
        end 

        return "" 
    end 

    def  Save_Check_Entry(type,datas,datas_entry,index)
        resule=""
        if(type=="资产借出/归还单") 
            if(datas[:id]="") 
                if datas_entry[1][5].lstrip.rstrip==""
                    resule=resule + "第"+index.to_s + "行分录预计归还时间不允许为空!\r\n";
                else
                    if datas_entry[1][5]<datas["Borrowing_date"]
                        resule=resule +  "第" + index.to_s + "行分录预计归还时间不允许小于借出时间\r\n";
                    end
                end  
            end
            if(datas_entry[1][0].lstrip.rstrip=="")
                resule=resule +  "第" + index.to_s + "行分录资产编码为空\r\n";
            end
        end
        return resule;
    end 
    def  Save_Check(type,datas)
        resule=" "
        if(type=="资产借出/归还单")   

                if(datas[:id]="")
                    if datas["Document_number"].lstrip.rstrip==""
                        resule=resule +  "单据编号不允许为空！\r\n";
                    end
                end
                if datas["Borrowing_date"].lstrip.rstrip==""
                    resule=resule +  "借出日期不允许为空！\r\n";
                end
                if datas["Borrowing_Department"].lstrip.rstrip==""
                    resule=resule +  "借用部门不允许为空！\r\n";
                end
                if datas["Loaner"]==""
                    resule=resule +  "借用人不允许为空！\r\n";
                end   
                if (!datas.include? 'datas')
                    resule=resule +  "分录数据行数量为0\r\n";  
                end
        end
        return resule
    end  



 

    def   Update_Fbillstatus_Check_Entry(type,datas,datas_entry,index,fbillstatus)
        resule=" "
        if(type=="资产借出/归还单")   
            if (fbillstatus=="归还")
                if datas_entry[1][7].lstrip.rstrip!=""
                    if datas_entry[1][7]<datas["Borrowing_date"]
                        resule=resule +  "第" + index.to_s + "行分录归还时间不允许小于借出时间\r\n";
                    end 
                end  
            end 
        end
    end 
end
    
 
