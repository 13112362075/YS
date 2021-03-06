module   DataCheckHelper

    #删除检验
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
                #审核状态不允许删除！
                if(@departments.fbillstatus.lstrip.rstrip=="已审核")
                    return "名称为 ：#{@departments.departmentname} 为审核状态，不允许删除!\n"
                end
            if( Assetcard.where( " department_id  =  ?",  "#{ @departments.departmentname}" ).length>0)#资产卡片
                return  "部门："+@departments.departmentname+"已被使用，不允许删除！\n" ;
            end 
            if( AssetTurnoverDetail.where( " Borrowing_Department  =  ?",  "#{id}" ).length>0)#借用、归还单
                return  "部门："+@departments.departmentname+"已被使用，不允许删除！\n" ;
            end  
        end

        if(type=="变动方式")
            @addtype=Addtype.find(id)
                     #审核状态不允许删除！
                     if(@addtype.fbillstatus.lstrip.rstrip=="已审核")
                        return "名称为 ：#{@addtype.Name} 为审核状态，不允许删除!\n"
                    end
            if( Assetcard.where( " Addtype_id  =  ?",  "#{ @addtype.Name}" ).length>0)#资产卡片
                return  "变动方式："+@addtype.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="资产位置")
            @assetseate=Assetseate.find(id) 
            #审核状态不允许删除！
            if(@assetseate.fbillstatus.lstrip.rstrip=="已审核")
               return "名称为 ：#{@assetseate.Name} 为审核状态，不允许删除!\n"
           end
            if( Assetcard.where( " Assetseat_id  =  ?",  "#{ @assetseate.Name}" ).length>0)#资产卡片
                return  "资产位置:"+@assetseate.Name+"已被使用，不允许删除！\n" ;
            end 
        end

        if(type=="资产状态")
            @assetstatus=Assetstatus.find(id) 
            #审核状态不允许删除！
            if(@assetstatus.fbillstatus.lstrip.rstrip=="已审核")
               return "名称为 ：#{@assetstatus.Name} 为审核状态，不允许删除!\n"
           end
            if( Assetcard.where( " Assetstatus_id  =  ?",  "#{ @assetstatus.Name}" ).length>0)#资产卡片
                return  "资产状态:"+@assetstatus.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="资产类型")
            @assettype=Assettype.find(id)
                  #审核状态不允许删除！
                  if(@assettype.fbillstatus.lstrip.rstrip=="已审核")
                    return "名称为 ：#{@assettype.Name} 为审核状态，不允许删除!\n"
                end
            if( Assetcard.where( " Assettype_id  =  ?",  "#{ @assettype.Name}" ).length>0)#资产卡片
                return  "资产类型:"+@assettype.Name+"已被使用，不允许删除！\n" ;
            end 
        end


        if(type=="计量单位")  
            @unit=Unit.find(id) 
                      #审核状态不允许删除！
                      if(@unit.fbillstatus.lstrip.rstrip=="已审核")
                        return "名称为 ：#{@unit.name} 为审核状态，不允许删除!\n"
                    end
            if( Assetcard.where( " Unit_id  =  ?",  "#{ @unit.name}" ).length>0)#资产卡片
                return  "计量单位:"+@unit.name+"已被使用，不允许删除！\n" ;
            end 
        end

 


        if(type=="使用状态")
            @usestate=Usestate.find(id) 
            #审核状态不允许删除！
            if(@usestate.fbillstatus.lstrip.rstrip=="已审核")
              return "名称为 ：#{@usestate.Name} 为审核状态，不允许删除!\n"
          end
            if( Assetcard.where( " Usestate_id  =  ?",  "#{ @usestate.Name}" ).length>0)#资产卡片
                return  "使用状态:"+@usestate.Name+"已被使用，不允许删除！\n" ;
            end 
        end
 

        if(type=="资产领用单")
            @assetPicking=AssetPicking.find(id) 
            if( @assetPicking.Fbillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetPicking.FBillno+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产借用/归还单")
            @assetTurnoverDetail=AssetTurnoverDetail.find(id) 
            if( @assetTurnoverDetail.fbillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetTurnoverDetail.Document_number+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产调拨单")
            @assetAllocate=AssetAllocate.find(id) 
            if( @assetAllocate.FBillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetAllocate.FBillno+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产变更单")
            @assetalter=Assetalter.find(id) 
            if( @assetalter.fbillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetalter.Fbillno+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产处置单")
            @assetDisposal=AssetDisposal.find(id) 
            if( @assetDisposal.Fbillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetDisposal.FBillno+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产作业单")
            @assetCountingreport=AssetCountingreport.find(id) 
            if( @assetCountingreport.fbillstatus=="已审核")#借用、归还单 
                return  "单据编号为："+@assetCountingreport.BillNo+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        if(type=="资产盘亏单")
            @assetLoss=AssetLoss.find(id) 
            if( @assetLoss.fbillstatus=="已审核")#资产盘亏单
                return  "单据编号为："+@assetLoss.BillNo+"为已审核状态，不允许删除！\n" ;
            end   
        end 


        if(type=="资产盘盈单")
            @AssetGain=AssetGain.find(id) 
            if( @AssetGain.fbillstatus=="已审核")#资产盘亏单
                puts "单据编号为："+@AssetGain.BillNo+"为已审核状态，不允许删除！\n" ;
                return  "单据编号为："+@AssetGain.BillNo+"为已审核状态，不允许删除！\n" ;
            end   
        end 

        return "" 
    end 

    #单据体保存检验
    def  Save_Check_Entry(type,datas,datas_entry,index)
        resule=""
        if(type=="资产处置单")
            if(datas_entry[1][0].lstrip.rstrip=="")
                resule=resule +  "第" + index.to_s + "行分录资产编码为空\r\n";
            end
            if(datas_entry[1][3].lstrip.rstrip.to_i==0)
                resule=resule +  "第" + index.to_s + "行分录处置数量不允许等于0\r\n";
            else
                if(datas_entry[1][3].lstrip.rstrip.to_i<datas_entry[1][4].lstrip.rstrip.to_i)
                    resule=resule +  "第" + index.to_s + "行分录处置数量不允许大于数量\r\n";
                end
            end 
        end
        if(type=="资产调拨单")
            if(datas_entry[1][0].lstrip.rstrip=="")
                resule=resule +  "第" + index.to_s + "行分录资产编码为空\r\n";
            end
            if(datas_entry[1][9].lstrip.rstrip=="双击选择调入部门")
                resule=resule +  "第" + index.to_s + "行分录调入部门为空\r\n";
            end 
            if(datas_entry[1][10].lstrip.rstrip=="双击选择现使用人")
                resule=resule +  "第" + index.to_s + "行分录现使用人为空\r\n";
            end 
            if(datas_entry[1][11].lstrip.rstrip=="双击选择资产位置")
                resule=resule +  "第" + index.to_s + "行分录资产位置为空\r\n";
            end 
        end
       

        if(type=="资产借出/归还单") 
            if(datas[:id]="")  
            end
            if(datas_entry[1][0].lstrip.rstrip=="")
                resule=resule +  "第" + index.to_s + "行分录资产编码为空\r\n";
            end

            if(datas_entry[1][8].lstrip.rstrip=="双击选择资产位置")
                resule=resule +  "第" + index.to_s + "行分录资产位置为空\r\n";
            end 
 
        end
 
        if(type=="资产领用单")
            if(datas_entry[1][0].lstrip.rstrip=="")
                resule=resule +  "第" + index.to_s + "行分录资产编码为空\r\n";
            end
            if(datas_entry[1][12].lstrip.rstrip=="双击选择资产位置")
                resule=resule +  "第" + index.to_s + "行分录资产位置为空\r\n";
            end 
        end

        return resule;
    end 

    #单据头保存检验
    def  Save_Check(type,datas)
        resule=" " 

        if(type=="资产处置单")
            if datas["FBillno"].lstrip.rstrip==""
                resule=resule +  "单据编号不允许为空！\r\n"; 
            end
            if datas["DisposeDate"].lstrip.rstrip==""
                resule=resule +  "处置日期不允许为空！\r\n"; 
            end
            if(datas[:id].lstrip.rstrip =="")
                @assetDisposal=AssetDisposal.where("FBillno = ?" , datas["FBillno"]) 
                if @assetDisposal.length>0
                    resule=resule +  "单据编码在系统已存在！\r\n";
                end 
            end 
            if (!datas.include? 'datas')
                resule=resule +  "分录数据行数量为0\r\n";  
            end 
        end

        if(type=="资产调拨单")
            if datas["FBillno"].lstrip.rstrip==""
                resule=resule +  "单据编号不允许为空！\r\n"; 
            end
            if datas["Expdate"].lstrip.rstrip==""
                resule=resule +  "调拨日期不允许为空！\r\n"; 
            end
            if(datas[:id].lstrip.rstrip =="")
                @assetAllocate=AssetAllocate.where("FBillno = ?" , datas["FBillno"]) 
                if @assetAllocate.length>0
                    resule=resule +  "单据编码在系统已存在！\r\n";
                end 
            end 
            if (!datas.include? 'datas')
                resule=resule +  "分录数据行数量为0\r\n";  
            end 
        end


        if(type=="资产领用单")
            if datas["FBillno"].lstrip.rstrip==""
                resule=resule +  "单据编号不允许为空！\r\n"; 
            end
            if datas["Picking_Date"].lstrip.rstrip==""
                resule=resule +  "领用日期不允许为空！\r\n"; 
            end
            if datas["Picking_Dept"].lstrip.rstrip==""
                resule=resule +  "领用部门不允许为空！\r\n"; 
            end
            if datas["Picking_Employeeld"].lstrip.rstrip==""
                resule=resule +  "领用人不允许为空！\r\n"; 
            end 
            if(datas[:id].lstrip.rstrip =="")
                @assetPicking=AssetPicking.where("FBillno = ?" , datas["FBillno"]) 
                if @assetPicking.length>0
                    resule=resule +  "单据编码在系统已存在！\r\n";
                end 
            end 

            if(datas[:Type_of_business]=="退回")  
                @asset_picking = AssetPicking.where("FBillno = ?" , datas[:datas].values[0][13])  
    
                if(datas[:Picking_Date] < @asset_picking[0].Picking_Date)
                    resule=resule + "退回日期不能小于源单资产领用单领用日期！\r\n";
                end
            end
            if (!datas.include? 'datas')
                resule=resule +  "分录数据行数量为0\r\n";  
            end 
        end 


        if(type=="资产变更单")
            if datas["Fbillno"].lstrip.rstrip==""
                resule=resule +  "单据编号不允许为空！\r\n";
                return resule; 
            end 
            @assetalter=Assetalter.where("Fbillno = ?" , datas["Fbillno"]) 
            if @assetalter.length>0
                resule=resule +  "单据编码在系统已存在！\r\n";
            end
        end

        if(type=="资产借出/归还单")
                if datas["Document_number"].lstrip.rstrip==""
                    resule=resule +  "单据编号不允许为空！\r\n";
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
                @AssetTurnoverDetail=AssetTurnoverDetail.where("Document_number = ? and id <> ?" , datas["Document_number"],datas["id"]) 
                if @AssetTurnoverDetail.length>0
                    resule=resule +  "单据编码在系统已存在！\r\n";
                end
        end 



        if(type=="资产盘点单")
            if datas["FBillno"].lstrip.rstrip==""
                resule=resule +  "单据编号不允许为空！\r\n";
            end
            if datas["fdate"].lstrip.rstrip==""
                resule=resule +  "单据日期不允许为空！\r\n";
            end
          
            if (!datas.include? 'datas')
                resule=resule +  "分录数据行数量为0\r\n";  
            end 
            @assetCountingreport=AssetCountingreport.where("BillNo = ? and id <> ?" , datas["FBillno"],datas["id"]) 
            if @assetCountingreport.length>0
                resule=resule +  "单据编码在系统已存在！\r\n";
            end
    end 
        return resule
    end  



 
#单据体更新状态检验
    def   Update_Fbillstatus_Check_Entry(type,datas,datas_entry,index,fbillstatus)
        resule=" "
        if(type=="资产借出/归还单")   
            # if (fbillstatus=="归还")
            #     if datas_entry[1][7].lstrip.rstrip!=""
            #         if datas_entry[1][7]<datas["Borrowing_date"]
            #             resule=resule +  "第" + index.to_s + "行分录归还时间不允许小于借出时间\r\n";
            #         end 
            #     end  
            # end 
        end 
    end 

#单据头更新状态检验
    def   Update_Fbillstatus_Check(type,id,fbillstatus)

        result=""  


        if(type=="使用状态")




            @usestate=Usestate.find(params[:id])   
            if(fbillstatus=="审核") 
                if(@usestate[0].fbillstatus=="已审核")
                    return "该使用状态已经是已审核状态，不允许再审核！"
                end 
            end        

            if(fbillstatus=="反审核")
                if(@usestate[0].fbillstatus=="未审核")
                    return "该使用状态是未审核状态，不允许反审核！"
                end
                if( Assetcard.where( " Usestate_id  =  ?",  "#{ @usestate[0].Name}" ).length>0)#资产卡片
                    return  "使用状态：为'#{@usestate[0].Name} '已被使用，不允许反审核！\n" ;
                end 


                if( Assetalter.where( "Usestate_id  =  ?",  "#{ @usestate[0].Name}" ).length>0)#变更单
                    return  "使用状态：为"+@usestate[0].Name+"已被使用，不允许反审核！\n" ;
                end  



            end  
        end


        if(type=="部门")


            @department=Department.find(params[:id])    
            if(fbillstatus=="审核") 
                if(@department[0].fbillstatus=="已审核")
                    return "该部门已经是已审核状态，不允许再审核！"
                end 
            end       

            if(fbillstatus=="反审核")
                if(@department[0].fbillstatus=="未审核")
                    return "该部门是未审核状态，不允许反审核！"
                end
                @department=Department.find(params[:id])    
                if( Assetcard.where( " department_id  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产卡片
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end 
                if( AssetTurnoverDetail.where( " Borrowing_Department  =  ?",  "#{@department[0].departmentname}" ).length>0)#借用、归还单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  
 
                if( AssetPicking.where( "Picking_Dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产领用单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetAllocateEntry.where( "IMPdept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产调拨单 
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetAllocateEntry.where( "EXPdept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产调拨单 
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( Assetalter.where( "department_id  =  ?",  "#{ @department[0].departmentname}" ).length>0)#变更单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( Assetalter.where( "department_id_Old  =  ?",  "#{ @department[0].departmentname}" ).length>0)#变更单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  
     
                if( AssetCountingreportEntry.where( "Book_dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘点单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetCountingreportEntry.where( "Invent_seat  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘点单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  
    
                if( AssetGainEntry.where( "Book_dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘盈单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetGainEntry.where( "Actual_dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘盈单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetLossEntry.where( "Book_dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘亏单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetLossEntry.where( "Actual_dept  =  ?",  "#{ @department[0].departmentname}" ).length>0)#资产盘亏单
                    return  "部门："+@department[0].departmentname+"已被使用，不允许反审核！\n" ;
                end  
  
            end  
        end




        if(type=="资产类别")


            @assettype=Assettype.find(params[:id])   
            if(fbillstatus=="审核") 
                if(@assettype[0].fbillstatus=="已审核")
                    return "该资产类别已经是已审核状态，不允许再审核！"
                end 
            end      
            if(fbillstatus=="反审核")
                if(@assettype[0].fbillstatus=="未审核")
                    return "该资产类别是未审核状态，不允许反审核！"
                end
                @assettype=Assettype.find(params[:id])   
                if( Assetcard.where( " Assettype_id  =  ?",  "#{ @assettype[0].Name}" ).length>0)#资产卡片
                    return  "资产类别：为'#{@assettype[0].Name} '已被使用，不允许反审核！\n" ;
                end 
 
                if( Assetalter.where( "Assettype_id  =  ?",  "#{ @assettype[0].Name}" ).length>0)#变更单
                    return  "资产类别：为"+@assettype[0].Name+"已被使用，不允许反审核！\n" ;
                end  

            end  
        end


        if(type=="资产状态") 
            @assetstatus=Assetstatus.find(params[:id])   
            if(fbillstatus=="审核") 
                if(@assetstatus[0].fbillstatus=="已审核")
                    return "该资产状态已经是已审核状态，不允许再审核！"
                end 
            end     
            if(fbillstatus=="反审核")
                if(@assetstatus[0].fbillstatus=="未审核")
                    return "该资产状态是未审核状态，不允许反审核！"
                end
                @assetstatus=Assetstatus.find(params[:id])   
                if( Assetcard.where( " Assetstatus_id  =  ?",  "#{ @assetstatus[0].Name}" ).length>0)#资产卡片
                    return  "资产状态:'#{@assetstatus[0].Name} '已被使用，不允许反审核！\n" ;
                end 

                if( Assetalter.where( "Assetstatus_id  =  ?",  "#{ @assetstatus[0].Name}" ).length>0)#变更单
                    return  "资产状态"+@assetstatus[0].Name+"已被使用，不允许反审核！\n" ;
                end  
            end  
        end

        if(type=="变动方式")

            @addtype=Addtype.find(params[:id])   
            if(fbillstatus=="审核") 
                if(@addtype[0].fbillstatus=="已审核")
                    return "该变动方式已经是已审核状态，不允许再审核！"
                end 
            end    
            if(fbillstatus=="反审核")
                if(@addtype[0].fbillstatus=="未审核")
                    return "该变动方式是未审核状态，不允许反审核！"
                end
                if( Assetcard.where( " Addtype_id  =  ?",  "#{ @addtype[0].Name}" ).length>0)#资产卡片
                    return  "变动方式'#{@addtype[0].Name} '已被使用，不允许反审核！\n" ;
                end 
                if( AssetDisposal.where( " Disposemethod  =  ?",  "#{ @addtype[0].Name}" ).length>0)#资产卡片
                    return  "变动方式'#{@addtype[0].Name} '已被使用，不允许反审核！\n" ;
                end  

                if( Assetalter.where( "Addtype_id  =  ?",  "#{ @addtype[0].Name}" ).length>0)#变更单
                    return  "变动方式:"+@addtype[0].Name+"已被使用，不允许反审核！\n" ;
                end  
            end  
        end

        if(type=="资产位置")
            @assetseate=Assetseate.find(params[:id])   
            if(fbillstatus=="审核") 
                if(@assetseate[0].fbillstatus =="已审核")
                    return "该资产位置已经是已审核状态，不允许再审核！"
                end 
            end  

            if(fbillstatus=="反审核")
                if(@assetseate[0].fbillstatus=="未审核")
                    return "该资产位置是未审核状态，不允许反审核！"
                end

                if( Assetcard.where( " Assetseat_id  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产卡片
                    return  "资产位置:'#{@assetseate[0].Name} '已被使用，不允许反审核！\n" ;
                end 
                if( Assetalter.where( "Assetseat_id  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#变更单
                    return  "资产位置:"+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  




                if( AssetTurnoverDetailEntry.where( " Last_seat  =  ?",  "#{@assetseate[0].Name}" ).length>0)#借用、归还单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  
 
                if( AssetPickingEntry.where( "Picking_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产领用单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetAllocateEntry.where( "Asset_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产调拨单 
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetAllocateEntry.where( "IMP_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产调拨单 
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

         
     
                if( AssetCountingreportEntry.where( "Invent_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘点单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetCountingreportEntry.where( "Book_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘点单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  
    
                if( AssetGainEntry.where( "Book_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘盈单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetGainEntry.where( "Actual_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘盈单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetLossEntry.where( "Book_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘亏单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  

                if( AssetLossEntry.where( "Actual_seat  =  ?",  "#{ @assetseate[0].Name}" ).length>0)#资产盘亏单
                    return  "资产位置："+@assetseate[0].Name+"已被使用，不允许反审核！\n" ;
                end  



            end  
        end

        if(type=="计量单位")
            @unit=Unit.find(params[:id])   
            if(fbillstatus=="审核") 
                    if(@unit[0].fbillstatus=="已审核")
                        return "该计量单位已经是已审核状态，不允许再审核！"
                    end 
            end 
            if(fbillstatus=="反审核") 
                if(@unit[0].fbillstatus=="未审核")
                    return "该计量单位是未审核状态，不允许反审核！"
                end
                if( Assetcard.where( " Unit_id  =  ?",  "#{ @unit[0].name}" ).length>0)#资产卡片
                    return  "计量单位:'#{@unit[0].name} '已被使用，不允许反审核！\n" ;
                end 

                if( Assetalter.where( "Unit_id  =  ?",  "#{ @unit[0].name}" ).length>0)#变更单
                    return  "计量单位:"+@unit[0].name+"已被使用，不允许反审核！\n" ;
                end  
            end  
        end


        if(type=="资产借出/归还单")   
            @assetTurnoverDetail=AssetTurnoverDetail.find(params[:id]) 
            @assetTurnoverDetailEntry  = AssetTurnoverDetailEntry.where( "AssetTurnoverDetail_id =  ?",  params[:id])  
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@assetTurnoverDetail.fbillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end 
                if(@assetTurnoverDetail.Type_of_business.lstrip.rstrip=="借出")
                    @assetTurnoverDetailEntry.each do |i|
                        @assetcard_by_assetCode=Assetcard.where("assetCode = ?  and Usestate_id='可用' " ,i.assetcards_Code.lstrip.rstrip);  
                        if @assetcard_by_assetCode.length==0
                            result=result+"第#{i.fseq}行资产卡片为非可用状态，不允许审核！"
                        end
                    end
                end  
            end
            if(fbillstatus.lstrip.rstrip=="反审核")
                if(@assetTurnoverDetail.fbillstatus.lstrip.rstrip=="未审核")
                    return "该单据是未审核状态，不允许反审核！"
                end


 
                if(@assetTurnoverDetail.Type_of_business.lstrip.rstrip=="借出")  
                    @assetTurnoverDetailEntry=AssetTurnoverDetailEntry.where("FSrcFbillno= '#{@assetTurnoverDetail.Document_number}'") 
                    if(@assetTurnoverDetailEntry.length>0)
                        return "该单据已有下游单据生成，不允许反审核！请删除下游单据后再进行反审核！"    
                    end
                end   



            end
        end 

        if(type.lstrip.rstrip=="资产盘盈单") 
            @AssetGain=AssetGain.find(params[:id]) 
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@AssetGain.fbillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end
            end
            if(fbillstatus.lstrip.rstrip=="反审核")
                if(@AssetGain.fbillstatus.lstrip.rstrip=="未审核")
                    return "该单据是未审核状态，不允许反审核！"
                end
            end
        end


        if(type.lstrip.rstrip=="资产盘亏单")
            @AssetLoss=AssetLoss.find(params[:id]) 
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@AssetLoss.fbillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end
            end
            if(fbillstatus.lstrip.rstrip=="反审核")
                if(@AssetLoss.fbillstatus.lstrip.rstrip=="未审核")
                    return "该单据是未审核状态，不允许反审核！"
                end
            end
        end


        if(type.lstrip.rstrip=="资产作业单")
            @assetCountingreport=AssetCountingreport.find(params[:id]) 
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@assetCountingreport.fbillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end
            end
            if(fbillstatus.lstrip.rstrip=="反审核")
                @AssetGainEntry1  = AssetGainEntry.where( "FSrcFbillno =  ?",  @assetCountingreport.BillNo)
                @AssetLossEntry1  = AssetLossEntry.where( "FSrcFbillno =  ?",   @assetCountingreport.BillNo)
                if(@AssetGainEntry1.length>0||@AssetLossEntry1.length>0)
                    result=result+"已存在下游单据，不允许反审核！请删除下游单据！\r\n"
                end 
                if(@assetCountingreport.fbillstatus.lstrip.rstrip=="未审核")
                    return "该单据是未审核状态，不允许反审核！"
                end
            end
        end
        
        if(type.lstrip.rstrip=="资产处置单")
            @assetDisposal=AssetDisposal.find(params[:id]) 
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@assetDisposal.Fbillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end
            end
            if(fbillstatus.lstrip.rstrip=="反审核")
                if(@assetDisposal.Fbillstatus.lstrip.rstrip=="未审核")
                    return "该单据已经是未审核状态，不允许再反审核！"
                end
            end
        end


        if(type.lstrip.rstrip=="资产调拨单")
            @index=0;
            @AssetAllocate=AssetAllocate.find(params[:id]) 
            @AssetAllocateEntry  = AssetAllocateEntry.where( "Asset_Allocate_id =  ?",   params[:id]) 
            if(fbillstatus.lstrip.rstrip=="审核")
                if(@AssetAllocate.FBillstatus.lstrip.rstrip=="已审核")
                    return "该单据已经是已审核状态，不允许再审核！"
                end
                @AssetAllocateEntry.each do |i| 
                    @index=@index+1;
                     @assetcard_by_assetCode=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);   
                      if(@assetcard_by_assetCode[0].Assetseat_id.lstrip.rstrip!=i.Asset_seat.lstrip.rstrip) 
                        result=result+"第"+@index.to_s+"行目录资产资产位置与资产原资产位置不一致，不允许审核！\r\n"
                      end
                      if(@assetcard_by_assetCode[0].department_id.lstrip.rstrip!=i.EXPdept.lstrip.rstrip)
                        result=result+"第"+@index.to_s+"行目录资产调出部门与资产使用部门不一致，不允许审核！\r\n"
                      end
                      if(@assetcard_by_assetCode[0].Employeeld.lstrip.rstrip!=i.Employeeld.lstrip.rstrip)
                        result=result+"第"+@index.to_s+"行目录原使用人与资产使用人不一致，不允许审核！\r\n"
                      end
                    end  
            end 
            if(fbillstatus.lstrip.rstrip=="反审核")
                if(@AssetAllocate.FBillstatus.lstrip.rstrip=="未审核")
                    return "该单据已经是未审核状态，不允许再反审核！"
                end
                @AssetAllocateEntry.each do |i| 
                    @index=@index+1; 
                     @assetcard=Assetcard.where("assetCode = ?  " ,i.Code.lstrip.rstrip);     
                      if(@assetcard[0].Assetseat_id.lstrip.rstrip!=i.IMP_seat.lstrip.rstrip) 
                        result=result+"第"+@index.to_s+"行目录资产调入资产位置与资产原资产位置不一致，不允许反审核！\r\n"
                      end
                      if(@assetcard[0].department_id.lstrip.rstrip!=i.IMPdept.lstrip.rstrip)
                        result=result+"第"+@index.to_s+"行目录资产调入部门与资产使用部门不一致，不允许反审核！\r\n"
                      end
                      if(@assetcard[0].Employeeld.lstrip.rstrip!=i.Newuser.lstrip.rstrip)
                        result=result+"第"+@index.to_s+"行目录现在使用人与资产使用人不一致，不允许反审核！\r\n"
                      end
                    end  
                  
            end  
        end 

         

        if(type=="资产卡片")
            if(fbillstatus=="反审核")
                @assetcard=Assetcard.find(id)  
                if( AssetTurnoverDetailEntry.where( "assetcards_Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#借用、归还单 
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
                if( Assetalter.where( "assetCode  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产变更单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
     
                if( AssetPickingEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产领用单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
                if( AssetAllocateEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产调拨单 
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
    
                if( AssetDisposalEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产处置单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
                if( AssetCountingreportEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产盘点单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
    
                if( AssetGainEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产盘盈单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
                if( AssetLossEntry.where( "Code  =  ?",  "#{ @assetcard.assetCode}" ).length>0)#资产盘亏单
                    return  "资产卡片编码"+@assetcard.assetCode+"已被使用，不允许反审核！\n" ;
                end  
            end  
        end
        if(type=="资产领用单")
            if(fbillstatus=="反审核")
                @assetPicking=AssetPicking.find(id)
                if( @assetPicking.Fbillstatus=="未审核")#借用、归还单 
                    return "该单据已经未审核状态，不允许反审核！\r\n";
                end
                sql = "select * from asset_picking_entries where FSrcFbillno = '#{@assetPicking.FBillno}'    LIMIT 1 "  
                @assetPickingEntry =AssetPickingEntry.find_by_sql (sql) 
                if @assetPickingEntry.length>0
                    return "已有下游业务发生，不允许反审核!\r\n";
                end
            end
            if(fbillstatus=="审核")
                if( AssetPicking.where( "id= #{id}  and  Fbillstatus  ='已审核' " ).length>0)#借用、归还单 
                    return "该单据已经审核状态，不允许再审核！\r\n";
                end 

                if(@assetPicking.Type_of_business=="领用")
                    @assetPickingEntry=AssetPickingEntry.where("AssetPicking_id=#{id}")
                    index=0;
                    @assetPickingEntry.each do |i|
                        @assetcard=Assetcard.where("assetCode='#{i.Code}'")
                        if(  @assetcard[0].Usestate_id!="可用") 
                            index=index+1
                            result=result +   "第" + index.to_s + "行数据行资产编码为:"+i.Code.to_s+"为非可用状态，不允许审核！\r\n";   
                        end
                    end 
                end 
            end
        end
        return result
    end
end
    
 

