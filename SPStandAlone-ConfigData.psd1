@{
    AllNodes = @(    
    @{
        NodeName = $env:COMPUTERNAME;
        PSDscAllowPlainTextPassword = $true;
        PSDscAllowDomainUser = $true;
 
        #region Parameters
        Passphrase = "NCTinc2012"
        DomainName = "nctdev.local"
        DomainNetBIOS = "nctdev"
        ProductKey = "NQGJR-63HC8-XCRQH-MYVCH-3J3QR" 
        LanguagePackPath = "c:\DSC-Share\Media\SP2016LanguagePack"
        SharePointBinaryPath = "c:\DSC-Share\Media\SP2016Binaries"  
        SQLBinaryPath = "c:\DSC-Share\Media\SQL2016Binaries"
        SXSLocalPath = "c:\SXS" # The content from the Network Share will be copied locally at that location; 
        SXSRemotePath = "c:\DSC-Share\Media\sxs"
        #endregion  
    }
)}