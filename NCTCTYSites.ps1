Configuration NCTCTYSites
{
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -ModuleName sharePointDSC 
          
    $Script:FarmDomainAdmin = Get-Credential #-Username "nctdev\nctinstall" -Message "Domain Administrator"  
    $Script:FarmAdmin = $Script:FarmDomainAdmin
            
    #endregion
    node $AllNodes.NodeName
    {
   
    #**********************************************************
    # Install Binaries
    #
    # This section installs SharePoint and its Prerequisites
    #**********************************************************
        
    SPInstallPrereqs InstallPrereqs
    {
        Ensure               = "Present"
        InstallerPath        = $AllNodes.SharePointBinaryPath + "\prerequisiteinstaller.exe"
        OnlineMode           = $false 
        SQLNCli              = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\sqlncli.msi"
        DOTNETFX             = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\dotNetfx45_Full_setup.exe"
        NETFX                = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\NDP453-KB2969351-x86-x64-AllOS-ENU.exe"
        Sync                 = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\Synchronization.msi"
        AppFabric            = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\WindowsServerAppFabricSetup_x64.exe"
        IDFX11               = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\MicrosoftIdentityExtensions-64.msi"
        MSIPCClient          = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\setup_msipc_x64.exe"
        WCFDataServices56    = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\WcfDataServices.exe"
        KB3092423            = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\AppFabric-KB3092423-x64-ENU.exe"
        MSVCRT11             = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\vcredist_x64.exe"
        MSVCRT14             = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\vc_redist.x64.exe"
        ODBC                 = $AllNodes.SharePointBinaryPath + "\prerequisiteinstallerfiles\msodbcsql.msi"
        SXSPath              = $AllNodes.SXSLocalPath
        PSDSCRunAsCredential = $Script:FarmAdmin

     }

    SPInstall InstallSharePoint
    {
        Ensure               = "Present"
        BinaryDir            = $AllNodes.SharePointBinaryPath 
        ProductKey           = $AllNodes.ProductKey
        InstallPath          = $AllNodes.InstallPath
        DataPath             = $AllNodes.DataPath
        DependsOn            = "[SPInstallPrereqs]InstallPrereqs"

     }
        
    #**********************************************************
    # Basic farm configuration
    #
    # This section creates the new SharePoint farm object, and
    # provisions generic services and components used by the
    # whole farm
    #**********************************************************
                
    SPFarm CreateSPFarm
    {
        Ensure                    = "Present"
        DatabaseServer            = $AllNodes.DatabaseServer
        FarmConfigDatabaseName    = "NCTSP_Config"
        Passphrase                =  New-Object System.Management.Automation.PSCredential ('Passphrase', (ConvertTo-SecureString $AllNodes.Passphrase -AsPlainText -Force));
        AdminContentDatabaseName  = "CaseWorks_CENTRAL_ADMIN";
        FarmAccount               = $Script:FarmAdmin
        PsDscRunAsCredential      = $Script:FarmAdmin
        RunCentralAdmin           = $true
        CentralAdministrationPort = 50000;
        CentralAdministrationAuth = "NTLM";
        ServerRole                = "Application"
        DependsOn                 = "[SPInstall]InstallSharePoint"
    }
        
            
    #**********************************************************
    # Service instances
    #
    # This section describes which services should be running
    # and not running on the server
    #**********************************************************

    SPServiceInstance ClaimsToWindowsTokenServiceInstance
    {  
        Name                    = "Claims to Windows Token Service"
        Ensure                  = "Present"
        PsDscRunAsCredential    = $Script:FarmAdmin
        DependsOn               = "[SPFarm]CreateSPFarm"
    }   

    SPServiceInstance SecureStoreServiceInstance
    {  
        Name                    = "Secure Store Service"
        Ensure                  = "Present"
        PsDscRunAsCredential    = $Script:FarmAdmin
        DependsOn               = "[SPFarm]CreateSPFarm"
    }
        
                
    #**********************************************************
    # Service applications
    #
    # This section creates service applications and required
    # dependencies
    #**********************************************************
        

    SPServiceAppPool MMS        
    {
        Name                   = "MMS";
        ServiceAccount         = $Script:FarmAdmin.Username;
        PsDSCRunAsCredential   = $Script:FarmAdmin;
        Ensure                 = "Present";
    }  
        
                              
    SPServiceInstance CentralAdministrationInstance
    {
        Name                    = "Central Administration";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
        
    SPServiceInstance ManagedMetadataWebServiceInstance
    {
        Name                    = "Managed Metadata Web Service";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
        
    SPServiceInstance MicrosoftSharePointFoundationWebApplicationInstance
    {
        Name                    = "Microsoft SharePoint Foundation Web Application";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    
    SPServiceInstance MicrosoftSharePointFoundationWorkflowTimerServiceInstance
    {
        Name                    = "Microsoft SharePoint Foundation Workflow Timer Service";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    
    SPServiceInstance SearchHostControllerServiceInstance
    {
        Name                    = "Search Host Controller Service";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    
    SPServiceInstance SearchQueryandSiteSettingsServiceInstance
    {
        Name                    = "Search Query and Site Settings Service";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    
    SPServiceInstance SharePointServerSearchInstance
    {
        Name                    = "SharePoint Server Search";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    
    SPServiceInstance UserProfileServiceInstance
    {
        Name                    = "User Profile Service";
        Ensure                  = "Present";
        PsDSCRunAsCredential    = $Script:FarmDomainAdmin;
    }
    }
}
  
#region LCM Config
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
#endregion
  
NCTCTYSites -ConfigurationData .\County-ConfigData.psd1