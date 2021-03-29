class AssetListController < ApplicationController

  #返回Json
    def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
        render json:{code: code, msg: message, count: count,data: data};
      end
    
    #获取单据接口
     def Get_DataApi 
      sql="SELECT * FROM  assetcards  where 1=1 "  
      if (params.include? 'key')  
        if(params[:key].include?"Assettype_selected")
          if params[:key][:Assettype_selected]!="资产类型-列表"
          sql=sql+" and assetcards.Assettype_id = '#{ params[:key][:Assettype_selected]}'"
          end
        else
          #添加条件
          if(params[:key][:assetCode].lstrip.rstrip!="") 
            sql=sql+" and assetcards.assetCode like '%#{ params[:key][:assetCode]}%'"
          end
          if(params[:key][:Assettype_id].lstrip.rstrip!="") 
           sql=sql+" and assetcards.Assettype_id like '%#{ params[:key][:Assettype_id]}%'"
         end
         if(params[:key][:assetstatusid] .lstrip.rstrip!="") 
           sql=sql+" and assetcards.Assetstatus_id = '#{ params[:key][:assetstatusid]}'"
         end
         if(params[:key][:departmentid] .lstrip.rstrip!="") 
           sql=sql+" and assetcards.department_id = '#{ params[:key][:departmentid]}'"
         end
         if(params[:key][:userid].lstrip.rstrip!="") 
           sql=sql+" and assetcards.Employeeld = '#{ params[:key][:userid]}'"
         end 
         if(params[:key][:fbillstatus].lstrip.rstrip!="全部") 
           sql=sql+" and assetcards.fbillstatus = '#{ params[:key][:fbillstatus]}'"
         end
        end 
      else
        sql=sql+" and assetcards.fbillstatus ='已审核'"
      end  
      puts sql
        assetcard =Assetcard.find_by_sql (sql)
        total_count=assetcard.count
        data=assetcard.as_json;
        api_success(count: total_count,data: data) 
      end

      def show
        @assetcard=Assetcard.all
        @assettype = Assettype.all
        @department = Department.all
        @user = User.all
        @assetstatus =  Assetstatus.all   
      end 
end
