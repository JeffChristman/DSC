Configuration SetPullMode
{
    param([string]$guid)
    Node SPVM
    {
        LocalConfigurationManager
        {
            AllowModuleOverWrite =$True
            ConfigurationMode = "ApplyOnly"
            ConfigurationID = $guid
            RefreshMode = "Pull"
            DownloadManagerName = "WebDownloadManager"
            DownloadManagerCustomData = @{
                ServerUrl = "http://advm:8080/PSDSCPullServer.svc/";
                AllowUnsecureConnection = "true"
            }
            RebootNodeIfNeeded = $true
        }
    }
}
 
SetPullMode –guid "98e2382d-8ecf-47f2-a2ed-7b83c27b7b48"                   
 
Set-DSCLocalConfigurationManager –Computer SPVM -Path ./SetPullMode –Verbose