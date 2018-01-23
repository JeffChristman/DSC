Configuration NoSPSolutions
{
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName SharePointDSC
   
    #region Credentials
        $Script:FarmAdmin = Get-Credential -Username "nctdev\nctinstall" -Message "Farm Admin"
        $Script:FarmDomainAdmin = Get-Credential -Username "nctdev\nctinstall" -Message "Domain Administrator"  
        $PassPhrase = "NCTinc2016"
    #endregion
  
    node $AllNodes.NodeName
    {
            
        #**********************************************************
        # NCT Solutions 
        #
        # This section deployes the NCT Solutions in the 
        # SharePoint farm, 
        # 
        #**********************************************************
 
       SPFarmSolution nct.appointment.workflow.v.1.0.0.wsp
            {
                Name                  = "nct.appointment.workflow.v.1.0.0.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.appointment.workflow.v.1.0.0.wsp"
                Ensure                = "Absent"
                Version               = "1.0.0"
                WebApplications       = @("http://nctcentral.nctdev.com")
                Deployed              =$false
                PsDscRunAsCredential  = $Script:FarmAdmin
            }
        
        SPFarmSolution nct.caseworks.data.v.5.15.2_working.wsp
            {
                Name                  = "nct.caseworks.data.v.5.15.2_working.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.data.v.5.15.2_working.wsp"
                Ensure                = "Absent"
                Version               = "5.15.2"
                WebApplications       = @("http://nctcentral.nctdev.com")
                Deployed              =$false
                PsDscRunAsCredential  = $Script:FarmAdmin
            }

        SPFarmSolution nct.caseworks.orphaneddocuments.v.1.0.wsp
            {
                Name                  = "nct.caseworks.orphaneddocuments.v.1.0.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.orphaneddocuments.v.1.0.wsp"
                Ensure                = "Absent"
                Version               = "1.0"
                WebApplications       = @("http://nctcentral.nctdev.com")
                Deployed              =$false
                PsDscRunAsCredential  = $Script:FarmAdmin
            }
        
        SPFarmSolution nct.caseworks.fields.doctype.v1.3.0.wsp
            {
                Name                  = "nct.caseworks.fields.doctype.v1.3.0.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.fields.doctype.v1.3.0.wsp"
                Ensure                = "Absent"
                Version               = "1.3.0"
                WebApplications       = @("http://nctcentral.nctdev.com")
                Deployed              =$false
                PsDscRunAsCredential  = $Script:FarmAdmin
            }
         
        SPFarmSolution nct.caseworks.scan.v.1.8.4.wsp
            {
                Name                  = "nct.caseworks.scan.v.1.8.4.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.scan.v.1.8.4.wsp"
                Ensure                = "Absent"
                Version               = "1.8.4"
                Deployed              =$false
                WebApplications       = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential  = $Script:FarmAdmin
            }

        SPFarmSolution nct.caseworks.tabbedwebparts.v.3.1.wsp
            {
                Name                  = "nct.caseworks.tabbedwebparts.v.3.1.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.tabbedwebparts.v.3.1.wsp"
                Ensure                = "Absent"
                Version               = "3.1"
                Deployed              =$false
                WebApplications       = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential  = $Script:FarmAdmin
            }

        SPFarmSolution nct.caseworks.webpartcommander.v.1.1.wsp
            {
                Name                  = "nct.caseworks.webpartcommander.v.1.1.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.caseworks.webpartcommander.v.1.1.wsp"
                Ensure                = "Absent"
                Version               = "2.3.0"
                Deployed              =$false
                WebApplications       = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential  = $Script:FarmAdmin
            }
        
       SPFarmSolution nct.cleanup.temp.documents.v.1.0.0.wsp
            {
                Name                  = "nct.cleanup.temp.documents.v.1.0.0.wsp"
                LiteralPath           = "C:\DSC-Share\Media\NCT_WSP\nct.cleanup.temp.documents.v.1.0.0.wsp"
                Ensure                = "Absent"
                Version               = "1.0.0"
                Deployed              =$false
                WebApplications       = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential  = $Script:FarmAdmin
            }

        
        SPFarmSolution nct.document.flow.v.4.015.0.wsp
            {
                Name                 = "nct.document.flow.v.4.015.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.document.flow.v.4.015.0.wsp"
                Ensure               = "Absent"
                Version              = "4.015.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
             
        SPFarmSolution nct.document.merge.v.1.015.0.wsp
            {
                Name                 = "nct.document.merge.v.1.015.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.document.merge.v.1.015.0.wsp"
                Ensure               = "Absent"
                Version              = "1.015.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
        
        SPFarmSolution nct.email.processing.appointment.v.1.0.wsp
            {
                Name                 = "nct.email.processing.appointment.v.1.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.email.processing.appointment.v.1.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
        
               
        
       SPFarmSolution nct.email.processing.v.1.0.0.wsp
            {
                Name                 = "nct.email.processing.v.1.0.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.email.processing.v.1.0.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
             
       
       SPFarmSolution nct.features.v.2.3.0.wsp
            {
                Name                 = "nct.features.v.2.3.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.features.v.2.3.0.wsp"
                Ensure               = "Absent"
                Version              = "2.3.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
             
        SPFarmSolution nct.field.flag.v1.0.0.wsp
            {
                Name                 = "nct.field.flag.v1.0.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.field.flag.v1.0.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }     
        
        SPFarmSolution nct.field.folderlookup.v.1.0.0.wsp
            {
                Name                 = "nct.field.folderlookup.v.1.0.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.field.folderlookup.v.1.0.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }     
        
        SPFarmSolution nct.forms.autofill.v.1.4.0.wsp
            {
                Name                 = "nct.forms.autofill.v.1.4.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.forms.autofill.v.1.4.0.wsp"
                Ensure               = "Absent"
                Version              = "1.4.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
             
        SPFarmSolution nct.formsubmit.post.v.1.0.0.wsp
            {
                Name                 = "nct.formsubmit.post.v.1.0.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.formsubmit.post.v.1.0.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
            
        SPFarmSolution nct.foundation.service.v.1.015.0.wsp
            {
                Name                 = "nct.foundation.service.v.1.015.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.foundation.service.v.1.015.0.wsp"
                Ensure               = "Absent"
                Version              = "1.015.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
            
        SPFarmSolution nct.list.item.update.v.1.0.wsp
            {
                Name                 = "nct.list.item.update.v.1.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.list.item.update.v.1.0.wsp"
                Ensure               = "Absent"
                Version              = "1.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
                       
        
        SPFarmSolution nct.print2nct.v.1.6.0.wsp
            {
                Name                 = "nct.print2nct.v.1.6.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.print2nct.v.1.6.0.wsp"
                Ensure               = "Absent"
                Version              = "1.6.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }


        SPFarmSolution nct.privileged.document.access.v.1.014.0.wsp
            {
                Name                 = "nct.privileged.document.access.v.1.014.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.privileged.document.access.v.1.014.0.wsp"
                Ensure               = "Absent"
                Version              = "1.014.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }
  
    SPFarmSolution nct.workflowmanager.v.1.014.0.wsp
            {
                Name                 = "nct.workflowmanager.v.1.014.0.wsp"
                LiteralPath          = "C:\DSC-Share\Media\NCT_WSP\nct.workflowmanager.v.1.014.0.wsp"
                Ensure               = "Absent"
                Version              = "1.014.0"
                Deployed              =$false
                WebApplications      = @("http://nctcentral.nctdev.com")
                PsDscRunAsCredential = $Script:FarmAdmin
            }

         
    }
}
  
<#region LCM Config
[DSCLocalConfigurationManager()]
Configuration LCMConfig
{
    Node $env:ComputerName
    {
        Settings
        {
            ActionAfterReboot = 'ContinueConfiguration';
            RebootNodeIfNeeded = $true;
        }
    }
}
LCMConfig
Set-DscLocalConfigurationManager LCMConfig -Force -Verbose
endregion#>
  
NoSPSolutions -ConfigurationData .\SPStandAlone-ConfigData.psd1