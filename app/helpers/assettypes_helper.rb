module AssettypesHelper
    #根据传的资产卡片的资产名称，判断是否为最明细
    def Check_IsLowesLevel(name)
        @assettype = Assettype.where("ParentAssettype = '#{name}' ") 
        if @assettype.length>0
            return "该资产卡片“#{name}”不是最明细资产卡片，请重新选择！"
        else
            return ""
        end
    end
    #根据传的资产卡片的资产名称，判断是否为审核状态
    def Check_IsAudit(name)
        @assettype = Assettype.where("Name = '#{name}' and fbillstatus = '已审核'") 
        if @assettype.length==0
            return "该资产卡片“#{name}”为已审核状态，不允许新增"
        else
            return ""
        end
    end
end
