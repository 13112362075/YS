module   DataCheckHelper

    def  Delete_Check(type,id) 
        if( Assetcard.where( " Employeeld  =  ?",  "#{id}" ).length>0)
            return  Assetcard.where( " Employeeld  =  ?",  "#{id}" ).length>0;
        end 
        if( AssetRecoveryEntry.where( " Requisition_Employeeld  =  ?",  "#{id}" ).length>0)
            return  AssetRecoveryEntry.where( " Requisition_Employeeld  =  ?",  "#{id}" ).length>0;
        end 
        return "false"
      end
end
