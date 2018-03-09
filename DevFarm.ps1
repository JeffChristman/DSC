Configuration SharePointFarm
{
    <# Credentials #>
    $Credsnctinstall = Get-Credential -UserName "nctindia\nctinstall" -Message "Please provide credentials"

    Import-DscResource -ModuleName "PSDesiredStateConfiguration"
    Import-DscResource -ModuleName "SharePointDSC" -ModuleVersion "1.9.0.0"

    Node $AllNodes.Where{$_.ServerNumber -eq '1'}.NodeName
    {
        if($System.Collections.Hashtable.NonNodeData.FullInstallation)
        {
            SPInstallPrereqs PrerequisitesInstallation
            {
                InstallerPath = $ConfigurationData.NonNodeData.SPPrereqsInstallerPath;
                OnlineMode = $True;
                Ensure = "Present";
                PSDscRunAsCredential = $Credsnctinstall;
            }
        }
        if($ConfigurationData.NonNodeData.FullInstallation)
        {
            SPInstall BinaryInstallation
            {
                BinaryDir = $ConfigurationData.NonNodeData.SPInstallationBinaryPath;
                ProductKey = $ConfigurationData.NonNodeData.SPProductKey;
                Ensure = "Present";
                PSDscRunAsCredential = $Credsnctinstall;
            }
        }
        SPFarm 1d4243f4-6730-4c05-8684-cd8e7cd0c0b8
        {
            Passphrase = New-Object System.Management.Automation.PSCredential ('Passphrase', (ConvertTo-SecureString -String $ConfigurationData.NonNodeData.PassPhrase -AsPlainText -Force));
            AdminContentDatabaseName = "SP2016_CENTRAL_ADMIN";
            FarmAccount = $Credsnctinstall;
            FarmConfigDatabaseName = "SP_Config";
            CentralAdministrationPort = 50000;
            PsDscRunAsCredential = $Credsnctinstall;
            CentralAdministrationAuth = "NTLM";
            ServerRole = $Node.ServerRole;
            RunCentralAdmin = $True;
            Ensure = "Present";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
        }
        SPManagedAccount 30c7f2ef-dbe4-4cb9-a59e-f727fbf5bde2
        {
            Account = $Credsnctinstall;
            AccountName = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Ensure = "Present";
            EmailNotification = 5;
            Schedule = "";
            PreExpireDays = 2;
        }
        SPWebApplication cse.nctindia.local
        {
            DatabaseName = "WSS_Content_CSE";
            Url = "https://cse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            ApplicationPool = "NCTCentral";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\CSE";
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "cse.nctindia.local";
            AuthenticationMethod = "NTLM";
            ApplicationPoolAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
            Port = "443";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            HostHeader = "cse.nctindia.local";
            AuthenticationProvider = "Windows Authentication";
        }
        SPWebApplication fse.nctindia.local
        {
            DatabaseName = "WSS_Content_FSE";
            Url = "https://fse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            ApplicationPool = "NCTCentral";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\FSE";
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "fse.nctindia.local";
            AuthenticationMethod = "NTLM";
            ApplicationPoolAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
            Port = "443";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            HostHeader = "fse.nctindia.local";
            AuthenticationProvider = "Windows Authentication";
        }
        SPWebApplication mse.nctindia.local
        {
            DatabaseName = "WSS_Content_MSE";
            Url = "https://mse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            ApplicationPool = "NCTCentral";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\MSE";
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "mse.nctindia.local";
            AuthenticationMethod = "NTLM";
            ApplicationPoolAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
            Port = "443";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            HostHeader = "mse.nctindia.local";
            AuthenticationProvider = "Windows Authentication";
        }
        SPWebApplication nctcentral.nctindia.local
        {
            DatabaseName = "WSS_Content_NCTCentral";
            Url = "https://nctcentral.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            ApplicationPool = "NCTCentral";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\NCTCentral";
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "nctcentral.nctindia.local";
            AuthenticationMethod = "NTLM";
            ApplicationPoolAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
            Port = "443";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            HostHeader = "nctcentral.nctindia.local";
            AuthenticationProvider = "Windows Authentication";
        }
        SPWebApplication sse.nctindia.local
        {
            DatabaseName = "WSS_Content_SSE";
            Url = "https://sse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            ApplicationPool = "NCTCentral";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\SSE";
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "sse.nctindia.local";
            AuthenticationMethod = "NTLM";
            ApplicationPoolAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
            Port = "443";
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            HostHeader = "sse.nctindia.local";
            AuthenticationProvider = "Windows Authentication";
        }
        SPWebAppPermissions 09b9b155-71ab-4ec3-a9c4-c574787ec686
        {
            AllPermissions = $True;
            WebAppUrl = "https://cse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppPermissions 6b58798b-02f5-4244-8aa5-5ab5e00a0741
        {
            AllPermissions = $True;
            WebAppUrl = "https://fse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppPermissions a046a982-117d-439a-b3a9-a878abad1474
        {
            AllPermissions = $True;
            WebAppUrl = "https://mse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppPermissions a7602241-283c-41d7-8489-bff086464dcf
        {
            AllPermissions = $True;
            WebAppUrl = "https://nctcentral.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppPermissions b1141ee2-7111-4b3f-8136-af71e9a1e001
        {
            AllPermissions = $True;
            WebAppUrl = "https://sse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPAlternateUrl 9e5e5aeb-dd1d-40f9-8eca-45f9e7081f6e
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "http://sp2016ind:50000";
            WebAppUrl = "http://sp2016ind:50000/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPAlternateUrl 0f4b51e8-a0b9-43d2-89bf-e99ab7ec0716
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://cse.nctindia.local";
            WebAppUrl = "https://cse.nctindia.local/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPAlternateUrl 40203ae0-dfb3-4619-b65e-942633907ba3
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://fse.nctindia.local";
            WebAppUrl = "https://fse.nctindia.local/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPAlternateUrl e8b627be-9843-49f4-8ef8-ec399d5b4947
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://mse.nctindia.local";
            WebAppUrl = "https://mse.nctindia.local/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPAlternateUrl c87b8953-f9c1-401d-9928-86160b321340
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://nctcentral.nctindia.local";
            WebAppUrl = "https://nctcentral.nctindia.local/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPAlternateUrl 66d21f5c-244a-43e3-80e8-ce01f873feb2
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://sse.nctindia.local";
            WebAppUrl = "https://sse.nctindia.local/";
            Zone = "Default";
            Ensure = "Present";
        }
        SPServiceAppPool MMS
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Name = "MMS";
            ServiceAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
        }
        SPServiceAppPool SecurityTokenServiceApplicationPool
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Name = "SecurityTokenServiceApplicationPool";
            ServiceAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
        }
        SPServiceAppPool SharePointWebServicesSystem
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Name = "SharePoint Web Services System";
            ServiceAccount = $Credsnctinstall.UserName;
            Ensure = "Present";
        }
        SPContentDatabase WSS_Content_CSE
        {
            Enabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            MaximumSiteCount = 5000;
            Name = "WSS_Content_CSE";
            Ensure = "Present";
            WarningSiteCount = 2000;
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            WebAppUrl = "https://cse.nctindia.local";
        }
        SPContentDatabase WSS_Content_FSE
        {
            Enabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            MaximumSiteCount = 5000;
            Name = "WSS_Content_FSE";
            Ensure = "Present";
            WarningSiteCount = 2000;
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            WebAppUrl = "https://fse.nctindia.local";
        }
        SPContentDatabase WSS_Content_MSE
        {
            Enabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            MaximumSiteCount = 5000;
            Name = "WSS_Content_MSE";
            Ensure = "Present";
            WarningSiteCount = 2000;
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            WebAppUrl = "https://mse.nctindia.local";
        }
        SPContentDatabase WSS_Content_NCTCentral
        {
            Enabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            MaximumSiteCount = 5000;
            Name = "WSS_Content_NCTCentral";
            Ensure = "Present";
            WarningSiteCount = 2000;
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            WebAppUrl = "https://nctcentral.nctindia.local";
        }
        SPContentDatabase WSS_Content_SSE
        {
            Enabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            MaximumSiteCount = 5000;
            Name = "WSS_Content_SSE";
            Ensure = "Present";
            WarningSiteCount = 2000;
            DatabaseServer = $ConfigurationData.NonNodeData.DatabaseServer;
            WebAppUrl = "https://sse.nctindia.local";
        }
        SPSite 41df9f6c-de88-447e-a644-9771d102a1d3
        {
            OwnerAlias = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://cse.nctindia.local";
            SecondaryOwnerAlias = "nctindia\satya";
            Language = 1033;
            SecondaryEmail = "";
            CompatibilityLevel = 15;
            Template = "STS#1";
            ContentDatabase = "WSS_Content_CSE";
            DependsOn =  @("[SPWebApplication]cse.nctindia.local");
        }
        SPDesignerSettings SiteCollectionf352d0cb-9190-4b83-acb2-040e997f108e
        {
            Url = "https://cse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            AllowSharePointDesigner = $True;
            AllowDetachPagesFromDefinition = $False;
            SettingsScope = "SiteCollection";
            AllowCustomiseMasterPage = $False;
            AllowCreateDeclarativeWorkflow = $True;
            AllowSavePublishDeclarativeWorkflow = $True;
            AllowSaveDeclarativeWorkflowAsTemplate = $True;
            AllowManageSiteURLStructure = $False;
        }
        SPSite fd18a745-0af1-46bc-9786-35cb1798e2bc
        {
            OwnerAlias = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://fse.nctindia.local";
            SecondaryOwnerAlias = "nctindia\satya";
            Language = 1033;
            SecondaryEmail = "";
            CompatibilityLevel = 15;
            Template = "STS#1";
            ContentDatabase = "WSS_Content_FSE";
            DependsOn =  @("[SPWebApplication]fse.nctindia.local");
        }
        SPDesignerSettings SiteCollection57022f5a-f8bc-4b8c-928f-34142ef59d30
        {
            Url = "https://fse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            AllowSharePointDesigner = $True;
            AllowDetachPagesFromDefinition = $False;
            SettingsScope = "SiteCollection";
            AllowCustomiseMasterPage = $False;
            AllowCreateDeclarativeWorkflow = $True;
            AllowSavePublishDeclarativeWorkflow = $True;
            AllowSaveDeclarativeWorkflowAsTemplate = $True;
            AllowManageSiteURLStructure = $False;
        }
        SPSite fb3d85f2-d14e-4b4d-a435-316656fe8249
        {
            OwnerAlias = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://mse.nctindia.local";
            SecondaryOwnerAlias = "nctindia\satya";
            Language = 1033;
            SecondaryEmail = "";
            CompatibilityLevel = 15;
            Template = "STS#1";
            ContentDatabase = "WSS_Content_MSE";
            DependsOn =  @("[SPWebApplication]mse.nctindia.local");
        }
        SPDesignerSettings SiteCollectiond08a8c10-cb72-490a-be6b-073fd830c5bb
        {
            Url = "https://mse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            AllowSharePointDesigner = $True;
            AllowDetachPagesFromDefinition = $False;
            SettingsScope = "SiteCollection";
            AllowCustomiseMasterPage = $False;
            AllowCreateDeclarativeWorkflow = $True;
            AllowSavePublishDeclarativeWorkflow = $True;
            AllowSaveDeclarativeWorkflowAsTemplate = $True;
            AllowManageSiteURLStructure = $False;
        }
        SPSite 6c8ef974-499f-4e13-b91c-077e522772b8
        {
            OwnerAlias = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://nctcentral.nctindia.local";
            SecondaryOwnerAlias = "nctindia\satya";
            Language = 1033;
            SecondaryEmail = "";
            CompatibilityLevel = 15;
            Template = "STS#1";
            ContentDatabase = "WSS_Content_NCTCentral";
            DependsOn =  @("[SPWebApplication]nctcentral.nctindia.local");
        }
        SPDesignerSettings SiteCollection3c68f51a-b242-4674-890f-bcb51ce0d172
        {
            Url = "https://nctcentral.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            AllowSharePointDesigner = $True;
            AllowDetachPagesFromDefinition = $False;
            SettingsScope = "SiteCollection";
            AllowCustomiseMasterPage = $False;
            AllowCreateDeclarativeWorkflow = $True;
            AllowSavePublishDeclarativeWorkflow = $True;
            AllowSaveDeclarativeWorkflowAsTemplate = $True;
            AllowManageSiteURLStructure = $False;
        }
        SPSite 4ecc1b82-38e2-49c0-88d1-f082d9badc12
        {
            OwnerAlias = $Credsnctinstall.UserName;
            PsDscRunAsCredential = $Credsnctinstall;
            Url = "https://sse.nctindia.local";
            SecondaryOwnerAlias = "nctindia\satya";
            Language = 1033;
            SecondaryEmail = "";
            CompatibilityLevel = 15;
            Template = "STS#1";
            ContentDatabase = "WSS_Content_SSE";
            DependsOn =  @("[SPWebApplication]sse.nctindia.local");
        }
        SPDesignerSettings SiteCollectione0125595-91b4-48b7-9ed0-2cefbf6d1a44
        {
            Url = "https://sse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            AllowSharePointDesigner = $True;
            AllowDetachPagesFromDefinition = $False;
            SettingsScope = "SiteCollection";
            AllowCustomiseMasterPage = $False;
            AllowCreateDeclarativeWorkflow = $True;
            AllowSavePublishDeclarativeWorkflow = $True;
            AllowSaveDeclarativeWorkflowAsTemplate = $True;
            AllowManageSiteURLStructure = $False;
        }
        SPDiagnosticLoggingSettings ApplyDiagnosticLogSettings
        {
            ErrorReportingAutomaticUploadEnabled = $False;
            ScriptErrorReportingRequireAuth = $True;
            DownloadErrorReportingUpdatesEnabled = $False;
            LogSpaceInGB = 1000;
            DaysToKeepLogs = 14;
            ScriptErrorReportingEnabled = $False;
            EventLogFloodProtectionTriggerPeriod = 2;
            PsDscRunAsCredential = $Credsnctinstall;
            AppAnalyticsAutomaticUploadEnabled = $False;
            EventLogFloodProtectionThreshold = 5;
            EventLogFloodProtectionNotifyInterval = 5;
            CustomerExperienceImprovementProgramEnabled = $False;
            LogPath = $ConfigurationData.NonNodeData.LogPath;
            LogCutInterval = 30;
            ErrorReportingEnabled = $False;
            ScriptErrorReportingDelay = 60;
            EventLogFloodProtectionQuietPeriod = 2;
            EventLogFloodProtectionEnabled = $True;
            LogMaxDiskSpaceUsageEnabled = $False;
        }
        SPWebAppPolicy de5c0fb1-5d47-4141-82cf-02da33d522d4
        {
            PsDscRunAsCredential = $Credsnctinstall;
            SetCacheAccountsPolicy = $False;
            WebAppUrl = "https://cse.nctindia.local/";
            Members = MSFT_SPWebPolicyPermissions{
                Username =  $Credsnctinstall.UserName
                IdentityType = "Claims"
                PermissionLevel = "Full Read"
                ActAsSystemAccount = $False
            };
        }
        SPWebAppPolicy 6f1b4658-ea8d-4a97-b89b-8e49d429145c
        {
            PsDscRunAsCredential = $Credsnctinstall;
            SetCacheAccountsPolicy = $False;
            WebAppUrl = "https://fse.nctindia.local/";
            Members = MSFT_SPWebPolicyPermissions{
                Username =  $Credsnctinstall.UserName
                IdentityType = "Claims"
                PermissionLevel = "Full Read"
                ActAsSystemAccount = $False
            };
        }
        SPWebAppPolicy 1f17bff4-23f9-4d12-bba2-07745dae64b7
        {
            PsDscRunAsCredential = $Credsnctinstall;
            SetCacheAccountsPolicy = $False;
            WebAppUrl = "https://mse.nctindia.local/";
            Members = MSFT_SPWebPolicyPermissions{
                Username =  $Credsnctinstall.UserName
                IdentityType = "Claims"
                PermissionLevel = "Full Read"
                ActAsSystemAccount = $False
            };
        }
        SPWebAppPolicy d89b7b24-3697-46be-adfe-c28c5ca6301a
        {
            PsDscRunAsCredential = $Credsnctinstall;
            SetCacheAccountsPolicy = $False;
            WebAppUrl = "https://nctcentral.nctindia.local/";
            Members = MSFT_SPWebPolicyPermissions{
                Username =  $Credsnctinstall.UserName
                IdentityType = "Claims"
                PermissionLevel = "Full Read"
                ActAsSystemAccount = $False
            };
        }
        SPWebAppPolicy 0e560521-b989-4428-83b5-0510c7f0d931
        {
            PsDscRunAsCredential = $Credsnctinstall;
            SetCacheAccountsPolicy = $False;
            WebAppUrl = "https://sse.nctindia.local/";
            Members = MSFT_SPWebPolicyPermissions{
                Username =  $Credsnctinstall.UserName
                IdentityType = "Claims"
                PermissionLevel = "Full Read"
                ActAsSystemAccount = $False
            };
        }
        SPAntivirusSettings AntivirusSettings
        {
            PsDscRunAsCredential = $Credsnctinstall;
            ScanOnUpload = $False;
            NumberOfThreads = 5;
            AllowDownloadInfected = $True;
            AttemptToClean = $False;
            ScanOnDownload = $False;
            TimeoutDuration = 300;
        }
        SPAppStoreSettings cse.nctindia.localaefbf2d8-b2e2-433b-88ba-da68f600eaa7
        {
            AllowAppsForOffice = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            WebAppUrl = "https://cse.nctindia.local/";
            AllowAppPurchases = $True;
        }
        SPAppStoreSettings fse.nctindia.local50ce0a59-2541-465f-989c-c524a7b864c7
        {
            AllowAppsForOffice = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            WebAppUrl = "https://fse.nctindia.local/";
            AllowAppPurchases = $True;
        }
        SPAppStoreSettings mse.nctindia.localc2213871-f0d7-4b73-9db1-a407c03e5fcb
        {
            AllowAppsForOffice = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            WebAppUrl = "https://mse.nctindia.local/";
            AllowAppPurchases = $True;
        }
        SPAppStoreSettings nctcentral.nctindia.local3036e44b-6e78-4127-ad30-1f98a67bb9af
        {
            AllowAppsForOffice = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            WebAppUrl = "https://nctcentral.nctindia.local/";
            AllowAppPurchases = $True;
        }
        SPAppStoreSettings sse.nctindia.local84082db0-ccca-4650-b03e-8bcb8cafb862
        {
            AllowAppsForOffice = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            WebAppUrl = "https://sse.nctindia.local/";
            AllowAppPurchases = $True;
        }
        SPBlobCacheSettings 07133363-c5c4-4551-9ab6-71b25e647023
        {
            MaxSizeInGB = 10;
            PsDscRunAsCredential = $Credsnctinstall;
            FileTypes = "\.(gif|jpg|jpeg|jpe|jfif|bmp|dib|tif|tiff|themedbmp|themedcss|themedgif|themedjpg|themedpng|ico|png|wdp|hdp|css|js|asf|avi|flv|m4v|mov|mp3|mp4|mpeg|mpg|rm|rmvb|wma|wmv|ogg|ogv|oga|webm|xap)$";
            EnableCache = $False;
            Location = $ConfigurationData.NonNodeData.BlobCacheLocation;
            MaxAgeInSeconds = 0;
            Zone = "Default";
            WebAppUrl = "https://cse.nctindia.local/";
        }
        SPBlobCacheSettings 3f6c8a29-82ef-4b8f-a873-83ccc36187a5
        {
            MaxSizeInGB = 10;
            PsDscRunAsCredential = $Credsnctinstall;
            FileTypes = "\.(gif|jpg|jpeg|jpe|jfif|bmp|dib|tif|tiff|themedbmp|themedcss|themedgif|themedjpg|themedpng|ico|png|wdp|hdp|css|js|asf|avi|flv|m4v|mov|mp3|mp4|mpeg|mpg|rm|rmvb|wma|wmv|ogg|ogv|oga|webm|xap)$";
            EnableCache = $False;
            Location = $ConfigurationData.NonNodeData.BlobCacheLocation;
            MaxAgeInSeconds = 0;
            Zone = "Default";
            WebAppUrl = "https://fse.nctindia.local/";
        }
        SPBlobCacheSettings 2f821af7-19dc-4d9c-8433-d3372b18d743
        {
            MaxSizeInGB = 10;
            PsDscRunAsCredential = $Credsnctinstall;
            FileTypes = "\.(gif|jpg|jpeg|jpe|jfif|bmp|dib|tif|tiff|themedbmp|themedcss|themedgif|themedjpg|themedpng|ico|png|wdp|hdp|css|js|asf|avi|flv|m4v|mov|mp3|mp4|mpeg|mpg|rm|rmvb|wma|wmv|ogg|ogv|oga|webm|xap)$";
            EnableCache = $False;
            Location = $ConfigurationData.NonNodeData.BlobCacheLocation;
            MaxAgeInSeconds = 0;
            Zone = "Default";
            WebAppUrl = "https://mse.nctindia.local/";
        }
        SPBlobCacheSettings d34103ac-c891-44ac-a344-f088a2d23ec2
        {
            MaxSizeInGB = 10;
            PsDscRunAsCredential = $Credsnctinstall;
            FileTypes = "\.(gif|jpg|jpeg|jpe|jfif|bmp|dib|tif|tiff|themedbmp|themedcss|themedgif|themedjpg|themedpng|ico|png|wdp|hdp|css|js|asf|avi|flv|m4v|mov|mp3|mp4|mpeg|mpg|rm|rmvb|wma|wmv|ogg|ogv|oga|webm|xap)$";
            EnableCache = $False;
            Location = $ConfigurationData.NonNodeData.BlobCacheLocation;
            MaxAgeInSeconds = 0;
            Zone = "Default";
            WebAppUrl = "https://nctcentral.nctindia.local/";
        }
        SPBlobCacheSettings 9acc22de-f201-41cd-83ed-546ee8d4613b
        {
            MaxSizeInGB = 10;
            PsDscRunAsCredential = $Credsnctinstall;
            FileTypes = "\.(gif|jpg|jpeg|jpe|jfif|bmp|dib|tif|tiff|themedbmp|themedcss|themedgif|themedjpg|themedpng|ico|png|wdp|hdp|css|js|asf|avi|flv|m4v|mov|mp3|mp4|mpeg|mpg|rm|rmvb|wma|wmv|ogg|ogv|oga|webm|xap)$";
            EnableCache = $False;
            Location = $ConfigurationData.NonNodeData.BlobCacheLocation;
            MaxAgeInSeconds = 0;
            Zone = "Default";
            WebAppUrl = "https://sse.nctindia.local/";
        }
        SPConfigWizard 8824ffcf-f9a2-46f1-9614-d2789415960f
        {
            PsDscRunAsCredential = $Credsnctinstall;
            DatabaseUpgradeDays = @("mon");
            Ensure = "Present";
            DatabaseUpgradeTime = "*";
        }
        SPFarmAdministrators 8586954a-2604-4d56-b574-e6c8fd31e442
        {
            Members = @("BUILTIN\administrators", $Credsnctinstall.UserName);
            PsDscRunAsCredential = $Credsnctinstall;
            MembersToInclude = @("");
            Name = "SPFarmAdministrators";
            MembersToExclude = @("");
        }
        SPFarmSolution b7c55416-908d-48c9-ae15-ea368c440f18
        {
            Version = "2.3.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.appointment.workflow.v.1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.appointment.workflow.v.1.0.0.wsp";
        }
        SPFarmSolution d13c982b-e849-4bf0-8e17-4a8407442f9a
        {
            Version = "2.5.5";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @("https://mse.nctindia.local/","https://nctcentral.nctindia.local/","https://fse.nctindia.local/","https://sse.nctindia.local/","https://cse.nctindia.local/");
            Name = "nct.caseworks.data.v.2.5.5.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.data.v.2.5.5.wsp";
        }
        SPFarmSolution 1f47125e-aad4-479f-a266-f8117461cbfe
        {
            Version = "1.3.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.caseworks.fields.doctype.v1.3.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.fields.doctype.v1.3.0.wsp";
        }
        SPFarmSolution 403b876e-8048-4b99-a304-57f99c60b385
        {
            Version = "1.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.caseworks.orphaneddocuments.v.1.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.orphaneddocuments.v.1.0.wsp";
        }
        SPFarmSolution 1618cb5c-bb8a-48d0-81a9-b96d1758d385
        {
            Version = "1.8.4";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.caseworks.scan.v.1.8.4.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.scan.v.1.8.4.wsp";
        }
        SPFarmSolution 81370db4-4987-4f4a-b404-622692432782
        {
            Version = "3.1";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @("https://mse.nctindia.local/","https://nctcentral.nctindia.local/","https://fse.nctindia.local/","https://sse.nctindia.local/","https://cse.nctindia.local/");
            Name = "nct.caseworks.tabbedwebparts.v.3.1.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.tabbedwebparts.v.3.1.wsp";
        }
        SPFarmSolution a6c732fd-91f0-4edd-9311-d7fa4f41abbc
        {
            Version = "1.1";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.caseworks.webpartcommander.v.1.1.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.caseworks.webpartcommander.v.1.1.wsp";
        }
        SPFarmSolution d9dbb760-380b-4516-b763-01e1ec2c1b0f
        {
            Version = "1.0.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.cleanup.temp.documents.v.1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.cleanup.temp.documents.v.1.0.0.wsp";
        }
        SPFarmSolution bd26e0f0-78dc-4caf-ae66-e6ed2ab680e3
        {
            Version = "2.1.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.document.flow.v.2.1.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.document.flow.v.2.1.0.wsp";
        }
        SPFarmSolution 9b0baa68-a0e6-4710-b3a5-c1a85c3800d1
        {
            Version = "1.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.email.processing.appointment.v.1.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.email.processing.appointment.v.1.0.wsp";
        }
        SPFarmSolution 933404a6-a5d8-40ed-98d8-168eccf17c41
        {
            Version = "1.0.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.email.processing.v.1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.email.processing.v.1.0.0.wsp";
        }
        SPFarmSolution 613e8290-9aa1-4523-8c45-f32921c16b4b
        {
            Version = "2.3.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.features.v.2.3.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.features.v.2.3.0.wsp";
        }
        SPFarmSolution 604e3abd-aecb-4113-a203-9fcdaa16cb8a
        {
            Version = "1.0.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.field.flag.v1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.field.flag.v1.0.0.wsp";
        }
        SPFarmSolution e43676c0-b30f-4dae-96ae-ff1d5ee2d254
        {
            Version = "1.0.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.field.folderlookup.v.1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.field.folderlookup.v.1.0.0.wsp";
        }
        SPFarmSolution c9b0ce7c-09df-4930-9e66-a5e8220e8a81
        {
            Version = "1.4.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.forms.autofill.v.1.4.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.forms.autofill.v.1.4.0.wsp";
        }
        SPFarmSolution d7aa3de2-456d-484b-8478-7866ab2ed8dc
        {
            Version = "1.0.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.formsubmit.post.v.1.0.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.formsubmit.post.v.1.0.0.wsp";
        }
        SPFarmSolution 391979be-59ba-48d2-b55d-ffc43e1891ce
        {
            Version = "1.6.2";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.foundation.service.v.1.6.2.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.foundation.service.v.1.6.2.wsp";
        }
        SPFarmSolution e08e90a8-0ab9-476a-bb42-3aeb2359bc4b
        {
            Version = "1.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.list.item.update.v.1.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.list.item.update.v.1.0.wsp";
        }
        SPFarmSolution 4aad6535-0be1-4f82-846a-fa049afe6b56
        {
            Version = "1.6.0";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.print2nct.v.1.6.0.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.print2nct.v.1.6.0.wsp";
        }
        SPFarmSolution 6fcfd531-3db9-44a2-97eb-179a32424c78
        {
            Version = "";
            Deployed = $True;
            SolutionLevel = "14";
            PsDscRunAsCredential = $Credsnctinstall;
            WebApplications = @();
            Name = "nct.sample.code.wsp";
            Ensure = "Present";
            LiteralPath = $AllNodes.Where{$Null -ne $_.SPSolutionPath}.SPSolutionPath+"nct.sample.code.wsp";
        }
        SPIrmSettings 91a42514-2ad2-4c29-b176-507ab8efaf07
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Ensure = "Absent";
            UseADRMS = $True;
            RMSserver = "";
        }
        SPWebAppWorkflowSettings 812501bf-8756-4199-b86c-fbcc70f02e91
        {
            ExternalWorkflowParticipantsEnabled = $False;
            UserDefinedWorkflowsEnabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            EmailToNoPermissionWorkflowParticipantsEnable = $True;
            Url = "https://cse.nctindia.local/";
        }
        SPWebAppWorkflowSettings fb16cfe9-301a-4884-97d0-4b608d36816f
        {
            ExternalWorkflowParticipantsEnabled = $False;
            UserDefinedWorkflowsEnabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            EmailToNoPermissionWorkflowParticipantsEnable = $True;
            Url = "https://fse.nctindia.local/";
        }
        SPWebAppWorkflowSettings 51fbdea1-fa28-4365-b616-41b9f85ec8c3
        {
            ExternalWorkflowParticipantsEnabled = $False;
            UserDefinedWorkflowsEnabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            EmailToNoPermissionWorkflowParticipantsEnable = $True;
            Url = "https://mse.nctindia.local/";
        }
        SPWebAppWorkflowSettings ee5bebe0-4739-4e03-ae26-f4c2aea50286
        {
            ExternalWorkflowParticipantsEnabled = $False;
            UserDefinedWorkflowsEnabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            EmailToNoPermissionWorkflowParticipantsEnable = $True;
            Url = "https://nctcentral.nctindia.local/";
        }
        SPWebAppWorkflowSettings 19f4f3be-825d-4a28-ab77-15b73991cde1
        {
            ExternalWorkflowParticipantsEnabled = $False;
            UserDefinedWorkflowsEnabled = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            EmailToNoPermissionWorkflowParticipantsEnable = $True;
            Url = "https://sse.nctindia.local/";
        }
        SPWebAppThrottlingSettings d19f503f-980e-4d2e-954c-ed68be53f421
        {
            AdminThreshold = 20000;
            EventHandlersEnabled = $False;
            ChangeLogEnabled = $True;
            AllowObjectModelOverride = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            ListViewLookupThreshold = 12;
            RequestThrottling = $True;
            ChangeLogExpiryDays = 120;
            HappyHourEnabled = $False;
            Url = "https://cse.nctindia.local/";
            UniquePermissionThreshold = 50000;
            ListViewThreshold = 5000;
            HappyHour = MSFT_SPWebApplicationHappyHour{
                Duration = "0"
                Hour = "22"
                Minute = "0"
            };
        }
        SPWebAppThrottlingSettings c8e3c901-9a7e-4322-8b3f-88a5955375f6
        {
            AdminThreshold = 20000;
            EventHandlersEnabled = $False;
            ChangeLogEnabled = $True;
            AllowObjectModelOverride = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            ListViewLookupThreshold = 12;
            RequestThrottling = $True;
            ChangeLogExpiryDays = 120;
            HappyHourEnabled = $False;
            Url = "https://fse.nctindia.local/";
            UniquePermissionThreshold = 50000;
            ListViewThreshold = 5000;
            HappyHour = MSFT_SPWebApplicationHappyHour{
                Duration = "0"
                Hour = "22"
                Minute = "0"
            };
        }
        SPWebAppThrottlingSettings 31ecc191-4104-4e1c-bf16-b214c0577f5b
        {
            AdminThreshold = 20000;
            EventHandlersEnabled = $False;
            ChangeLogEnabled = $True;
            AllowObjectModelOverride = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            ListViewLookupThreshold = 12;
            RequestThrottling = $True;
            ChangeLogExpiryDays = 120;
            HappyHourEnabled = $False;
            Url = "https://mse.nctindia.local/";
            UniquePermissionThreshold = 50000;
            ListViewThreshold = 5000;
            HappyHour = MSFT_SPWebApplicationHappyHour{
                Duration = "0"
                Hour = "22"
                Minute = "0"
            };
        }
        SPWebAppThrottlingSettings 86c93192-ac18-4d28-a0bc-724dab73ec20
        {
            AdminThreshold = 20000;
            EventHandlersEnabled = $False;
            ChangeLogEnabled = $True;
            AllowObjectModelOverride = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            ListViewLookupThreshold = 12;
            RequestThrottling = $True;
            ChangeLogExpiryDays = 120;
            HappyHourEnabled = $False;
            Url = "https://nctcentral.nctindia.local/";
            UniquePermissionThreshold = 50000;
            ListViewThreshold = 5000;
            HappyHour = MSFT_SPWebApplicationHappyHour{
                Duration = "0"
                Hour = "22"
                Minute = "0"
            };
        }
        SPWebAppThrottlingSettings bc840621-5ba8-43f8-a29c-6e0d133a9eb0
        {
            AdminThreshold = 20000;
            EventHandlersEnabled = $False;
            ChangeLogEnabled = $True;
            AllowObjectModelOverride = $True;
            PsDscRunAsCredential = $Credsnctinstall;
            ListViewLookupThreshold = 12;
            RequestThrottling = $True;
            ChangeLogExpiryDays = 120;
            HappyHourEnabled = $False;
            Url = "https://sse.nctindia.local/";
            UniquePermissionThreshold = 50000;
            ListViewThreshold = 5000;
            HappyHour = MSFT_SPWebApplicationHappyHour{
                Duration = "0"
                Hour = "22"
                Minute = "0"
            };
        }
        SPWebAppSiteUseAndDeletion 73252f2c-46c3-475a-8c11-143eddf52dfa
        {
            AutomaticallyDeleteUnusedSiteCollections = $False;
            PsDscRunAsCredential = $Credsnctinstall;
            UnusedSiteNotificationsBeforeDeletion = 4;
            SendUnusedSiteCollectionNotifications = $False;
            UnusedSiteNotificationPeriod = 90;
            Url = "https://cse.nctindia.local/";
        }
        SPWebAppSiteUseAndDeletion 493dd5d3-6d7e-47fe-8a63-8223e046b75a
        {
            AutomaticallyDeleteUnusedSiteCollections = $False;
            PsDscRunAsCredential = $Credsnctinstall;
            UnusedSiteNotificationsBeforeDeletion = 4;
            SendUnusedSiteCollectionNotifications = $False;
            UnusedSiteNotificationPeriod = 90;
            Url = "https://fse.nctindia.local/";
        }
        SPWebAppSiteUseAndDeletion f26114ef-4458-4981-94b2-b02e5d71f0c6
        {
            AutomaticallyDeleteUnusedSiteCollections = $False;
            PsDscRunAsCredential = $Credsnctinstall;
            UnusedSiteNotificationsBeforeDeletion = 4;
            SendUnusedSiteCollectionNotifications = $False;
            UnusedSiteNotificationPeriod = 90;
            Url = "https://mse.nctindia.local/";
        }
        SPWebAppSiteUseAndDeletion e4b9b894-0af6-4bfd-a544-401e6bbc2472
        {
            AutomaticallyDeleteUnusedSiteCollections = $False;
            PsDscRunAsCredential = $Credsnctinstall;
            UnusedSiteNotificationsBeforeDeletion = 4;
            SendUnusedSiteCollectionNotifications = $False;
            UnusedSiteNotificationPeriod = 90;
            Url = "https://nctcentral.nctindia.local/";
        }
        SPWebAppSiteUseAndDeletion 3e55c524-647f-4d43-b4c3-2a05d062652f
        {
            AutomaticallyDeleteUnusedSiteCollections = $False;
            PsDscRunAsCredential = $Credsnctinstall;
            UnusedSiteNotificationsBeforeDeletion = 4;
            SendUnusedSiteCollectionNotifications = $False;
            UnusedSiteNotificationPeriod = 90;
            Url = "https://sse.nctindia.local/";
        }
        SPWebAppProxyGroup 3c13a628-3d7e-4d86-b9cb-1502b9cc7681
        {
            ServiceAppProxyGroup = "Default";
            WebAppUrl = "https://cse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppProxyGroup 00dab7df-7e58-4370-8986-d06b8752c4cc
        {
            ServiceAppProxyGroup = "Default";
            WebAppUrl = "https://fse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppProxyGroup 25c4249e-cfc7-41a1-a18b-7ddae56237bc
        {
            ServiceAppProxyGroup = "Default";
            WebAppUrl = "https://mse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppProxyGroup 1459b746-de08-4b8a-bb30-5bc0a474de63
        {
            ServiceAppProxyGroup = "Default";
            WebAppUrl = "https://nctcentral.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebAppProxyGroup 44a83251-f740-4c43-9b80-ac709a9bb7d0
        {
            ServiceAppProxyGroup = "Default";
            WebAppUrl = "https://sse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
        }
        SPWebApplicationExtension a8ef8322-8311-4723-bd03-d61f284ba638
        {
            Url = "https://cse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "cse.nctindia.local";
            AuthenticationMethod = "NTLM";
            Zone = "Default";
            Ensure = "Present";
            Port = "443";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\CSE";
            WebAppUrl = "https://cse.nctindia.local/";
            HostHeader = "cse.nctindia.local";
        }
        SPWebApplicationExtension 4788c00f-fd38-4f48-bd35-9f884b7616b0
        {
            Url = "https://fse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "fse.nctindia.local";
            AuthenticationMethod = "NTLM";
            Zone = "Default";
            Ensure = "Present";
            Port = "443";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\FSE";
            WebAppUrl = "https://fse.nctindia.local/";
            HostHeader = "fse.nctindia.local";
        }
        SPWebApplicationExtension e4618ff8-209d-4f8a-9253-7e1c4a2a8e6f
        {
            Url = "https://mse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "mse.nctindia.local";
            AuthenticationMethod = "NTLM";
            Zone = "Default";
            Ensure = "Present";
            Port = "443";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\MSE";
            WebAppUrl = "https://mse.nctindia.local/";
            HostHeader = "mse.nctindia.local";
        }
        SPWebApplicationExtension 04690a20-408a-49cd-a5b0-7ca66bcfab48
        {
            Url = "https://nctcentral.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "nctcentral.nctindia.local";
            AuthenticationMethod = "NTLM";
            Zone = "Default";
            Ensure = "Present";
            Port = "443";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\NCTCentral";
            WebAppUrl = "https://nctcentral.nctindia.local/";
            HostHeader = "nctcentral.nctindia.local";
        }
        SPWebApplicationExtension bf75cfd3-3926-4682-908c-500b8576362f
        {
            Url = "https://sse.nctindia.local";
            PsDscRunAsCredential = $Credsnctinstall;
            UseSSL = $True;
            AllowAnonymous = $False;
            Name = "sse.nctindia.local";
            AuthenticationMethod = "NTLM";
            Zone = "Default";
            Ensure = "Present";
            Port = "443";
            Path = "C:\inetpub\wwwroot\wss\VirtualDirectories\SSE";
            WebAppUrl = "https://sse.nctindia.local/";
            HostHeader = "sse.nctindia.local";
        }
        SPWebAppGeneralSettings 058a3fce-391a-4307-832f-bd0b64628b42
        {
            BlogAPI = $True;
            BlogAPIAuthenticated = $False;
            SecurityValidationTimeoutMinutes = 30;
            PsDscRunAsCredential = $Credsnctinstall;
            CustomerExperienceProgram = $False;
            SecurityValidation = $True;
            SelfServiceSiteCreationEnabled = $False;
            MaximumUploadSize = 2047;
            SecurityValidationExpires = $True;
            RSS = $True;
            RecycleBinEnabled = $True;
            BrowserFileHandling = "Strict";
            RecycleBinCleanupEnabled = $True;
            AllowOnlineWebPartCatalog = $True;
            SecondStageRecycleBinQuota = 50;
            AlertsLimit = 500;
            Alerts = $True;
            PresenceEnabled = $True;
            Url = "https://cse.nctindia.local/";
            RecycleBinRetentionPeriod = 30;
        }
        SPWebAppGeneralSettings bb16f2db-a38c-4721-9033-4d69b83dcb97
        {
            BlogAPI = $True;
            BlogAPIAuthenticated = $False;
            SecurityValidationTimeoutMinutes = 30;
            PsDscRunAsCredential = $Credsnctinstall;
            CustomerExperienceProgram = $False;
            SecurityValidation = $True;
            SelfServiceSiteCreationEnabled = $False;
            MaximumUploadSize = 2047;
            SecurityValidationExpires = $True;
            RSS = $True;
            RecycleBinEnabled = $True;
            BrowserFileHandling = "Strict";
            RecycleBinCleanupEnabled = $True;
            AllowOnlineWebPartCatalog = $True;
            SecondStageRecycleBinQuota = 50;
            AlertsLimit = 500;
            Alerts = $True;
            PresenceEnabled = $True;
            Url = "https://fse.nctindia.local/";
            RecycleBinRetentionPeriod = 30;
        }
        SPWebAppGeneralSettings 6e8be435-985b-439c-84b5-26918babbe97
        {
            BlogAPI = $True;
            BlogAPIAuthenticated = $False;
            SecurityValidationTimeoutMinutes = 30;
            PsDscRunAsCredential = $Credsnctinstall;
            CustomerExperienceProgram = $False;
            SecurityValidation = $True;
            SelfServiceSiteCreationEnabled = $False;
            MaximumUploadSize = 2047;
            SecurityValidationExpires = $True;
            RSS = $True;
            RecycleBinEnabled = $True;
            BrowserFileHandling = "Strict";
            RecycleBinCleanupEnabled = $True;
            AllowOnlineWebPartCatalog = $True;
            SecondStageRecycleBinQuota = 50;
            AlertsLimit = 500;
            Alerts = $True;
            PresenceEnabled = $True;
            Url = "https://mse.nctindia.local/";
            RecycleBinRetentionPeriod = 30;
        }
        SPWebAppGeneralSettings 2af36c59-58d7-4bcf-a2cf-b2ef12829e8c
        {
            BlogAPI = $True;
            BlogAPIAuthenticated = $False;
            SecurityValidationTimeoutMinutes = 30;
            PsDscRunAsCredential = $Credsnctinstall;
            CustomerExperienceProgram = $False;
            SecurityValidation = $True;
            SelfServiceSiteCreationEnabled = $False;
            MaximumUploadSize = 2047;
            SecurityValidationExpires = $True;
            RSS = $True;
            RecycleBinEnabled = $True;
            BrowserFileHandling = "Strict";
            RecycleBinCleanupEnabled = $True;
            AllowOnlineWebPartCatalog = $True;
            SecondStageRecycleBinQuota = 50;
            AlertsLimit = 500;
            Alerts = $True;
            PresenceEnabled = $True;
            Url = "https://nctcentral.nctindia.local/";
            RecycleBinRetentionPeriod = 30;
        }
        SPWebAppGeneralSettings aada9079-02d2-4cb9-a3d3-0cf423c66ca2
        {
            BlogAPI = $True;
            BlogAPIAuthenticated = $False;
            SecurityValidationTimeoutMinutes = 30;
            PsDscRunAsCredential = $Credsnctinstall;
            CustomerExperienceProgram = $False;
            SecurityValidation = $True;
            SelfServiceSiteCreationEnabled = $False;
            MaximumUploadSize = 2047;
            SecurityValidationExpires = $True;
            RSS = $True;
            RecycleBinEnabled = $True;
            BrowserFileHandling = "Strict";
            RecycleBinCleanupEnabled = $True;
            AllowOnlineWebPartCatalog = $True;
            SecondStageRecycleBinQuota = 50;
            AlertsLimit = 500;
            Alerts = $True;
            PresenceEnabled = $True;
            Url = "https://sse.nctindia.local/";
            RecycleBinRetentionPeriod = 30;
        }
        SPWebAppBlockedFileTypes ded626dc-fe97-4212-93b7-9c3fe6de8a00
        {
            Url = "https://cse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            Blocked = @("ashx","asmx","json","soap","svc","xamlx");
        }
        SPWebAppBlockedFileTypes e1655b57-350d-4cfb-9058-305857e2a8af
        {
            Url = "https://fse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            Blocked = @("ashx","asmx","json","soap","svc","xamlx");
        }
        SPWebAppBlockedFileTypes 98d85e0f-4cc6-4687-9805-fae74e5063c1
        {
            Url = "https://mse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            Blocked = @("ashx","asmx","json","soap","svc","xamlx");
        }
        SPWebAppBlockedFileTypes 9a5f14e9-b161-422b-b6cc-83e0ce7aba03
        {
            Url = "https://nctcentral.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            Blocked = @("ashx","asmx","json","soap","svc","xamlx");
        }
        SPWebAppBlockedFileTypes bc361a19-7a5b-44da-998d-6487f61e4b2c
        {
            Url = "https://sse.nctindia.local/";
            PsDscRunAsCredential = $Credsnctinstall;
            Blocked = @("ashx","asmx","json","soap","svc","xamlx");
        }
        SPFarmPropertyBag f853735b-93e5-4a4c-8eef-6f89c536e5a5
        {
            PsDscRunAsCredential = $Credsnctinstall;
            Key = "WopiLicensing";
            Ensure = "Present";
            Value = "HostBIEnabled,HostExtendedBIEnabled";
        }
        foreach($ServiceInstance in $Node.ServiceInstances)
        {
            SPServiceInstance ($ServiceInstance.Name.Replace(" ", "") + "Instance")
            {
                Name = $ServiceInstance.Name;
                Ensure = $ServiceInstance.Ensure;
                PsDscRunAsCredential = $Credsnctinstall
            }
        }
        LocalConfigurationManager
        {
            RebootNodeIfNeeded = $True
        }

    }

}
SharePointFarm -ConfigurationData .\ConfigurationData.psd1
