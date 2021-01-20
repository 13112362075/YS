class AssetListController < ApplicationController

    def api_success(code: 0,message:'请求成功', count: '3',data:{}) 
        render json:{code: code, msg: message, count: count,data: data};
      end
    
    
     def Get_DataApi
      
        sql="SELECT * FROM  assetcards " 
        assetcard =Assetcard.find_by_sql ( sql)
        total_count=assetcard.count
        data=assetcard.as_json;
        api_success(count: total_count,data: data) 
      end

      def show

      end


      def filter
      end 

end
