@{
    AllNodes = @(    
        @{
            NodeName                    = $env:COMPUTERNAME;
            PSDscAllowPlainTextPassword = $true;
            PSDscAllowDomainUser        = $true;
 
            # Client data
            Passphrase                  = "NCTinc2012"
            DomainName                  = "nctdev.local"
            DomainNetBIOS               = "nctdev"
            ProductKey                  = "NQGJR-63HC8-XCRQH-MYVCH-3J3QR" 
            LanguagePackPath            = "c:\DSC-Share\Media\SP2016LanguagePack"
            SharePointBinaryPath        = "c:\DSC-Share\Media\SP2016Binaries"  
            SXSLocalPath                = "c:\SXS"  
            SXSRemotePath               = "c:\DSC-Share\Media\sxs"
            
            #Environment data
            InstallPath                 = "E:\SharePoint\Install"
            DataPath                    = "E:\SharePoint\Data"
            DatabaseServer              = "sqlvm.nctdev.local"
            AdminContentDatabaseName    = "SP2016_CENTRAL_ADMIN"
             
        }
)}