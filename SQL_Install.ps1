Configuration SQLStandAlone
{
    
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xActiveDirectory
    Import-DSCResource -ModuleName xNetworking
    Import-DSCResource -ModuleName xSQLServer



    #region Credentials
    $Script:FarmAdmin = Get-Credential -Username "nctdev\nctinstall" -Message "Farm Admin"
    $Script:FarmDomainAdmin = Get-Credential -Username "nctdev\nctinstall" -Message "Domain Administrator"  
    #endregion
  
    node $AllNodes.NodeName
    {
        xFireWall SQLFirewallRule
        {
            Name = "AllowSQLConnection"
            DisplayName = 'Allow SQL Connection'
            Group = 'DSC Configuration Rules'
            Ensure = 'Present'
            Enabled = 'True'
            Profile = ('Domain') 
            Direction = 'InBound'
            LocalPort = ('1433') 
            Protocol = 'TCP'
            Description = 'Firewall Rule to allow SQL communication'
            DependsOn = @("[xADDomain]Domain","[xADUser]FarmAdmin")
        }
  
        WindowsFeature ADDS
        {
            Name = "AD-Domain-Services"
            IncludeAllSubFeature = $true
            Ensure = "Present"
        }
  
        WindowsFeature ADDSTools
        {
            Name = 'RSAT-AD-Tools'
            IncludeAllSubFeature = $true
            Ensure = "Present"
        }
  
        xADDomain Domain
        {
            DomainName = $AllNodes.DomainName
            DomainAdministratorCredential = $Script:FarmDomainAdmin
            SafemodeAdministratorPassword = $Script:FarmDomainAdmin
            DependsOn = "[WindowsFeature]ADDS"
        }
  
        xADUser FarmAdmin
        {
            DomainName = $AllNodes.DomainName
            Username = $Script:FarmAdmin.UserName.Replace(($AllNodes.DomainNetBIOS + "\"),"")
            Password = $Script:FarmAdmin
            PasswordNeverExpires = $true
            DependsOn = "[xADDomain]Domain"
        }
        
        xSQLServerSetup SQLSetup
        {
            InstanceName = "MSSQLServer"
            SourcePath = $AllNodes.SQLBinaryPath
            Features = "SQLENGINE"
            InstallSQLDataDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLUserDBDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLUserDBLogDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLTempDBDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLTempDBLogDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLBackupDir = "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data"
            SQLSysAdminAccounts = $Script:FarmAdmin.UserName
            SQLSvcAccount = $Script:FarmDomainAdmin
            AgtSvcAccount = $Script:FarmDomainAdmin
            PSDscRunAsCredential = $Script:FarmDomainAdmin
            DependsOn = @("[xADDomain]Domain","[xADUser]FarmAdmin","[xFirewall]SQLFirewallRule")
        }
 
    File SXSFolder
    {
        SourcePath = $AllNodes.SXSRemotePath
        Type = "Directory"
        DestinationPath = $AllNodes.SxsLocalPath
        Recurse = $true;
        Credential = $Script:FarmDomainAdmin
        Force = $true
        PSDSCRunAsCredential = $Script:FarmDomainAdmin
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
  
SQLStandAlone -ConfigurationData .\SPStandAlone-ConfigData.psd1
