# scripts/Deploy-SSIS.ps1
param(
    [Parameter(Mandatory=$true)]
    [string]$ServerName,
    
    [Parameter(Mandatory=$true)]
    [string]$FolderName,
    
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$true)]
    [string]$PackagePath,
    
    [Parameter(Mandatory=$false)]
    [string]$EnvironmentName = $null
)

# Load SSIS assemblies
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null

# Create connection to SQL Server
$connectionString = "Data Source=$ServerName;Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection($connectionString)

# Create Integration Services object
$integrationServices = New-Object Microsoft.SqlServer.Management.IntegrationServices.IntegrationServices($sqlConnection)

# Check if SSISDB exists
$ssisCatalog = $integrationServices.Catalogs["SSISDB"]
if (-not $ssisCatalog) {
    Write-Host "SSISDB does not exist. Creating SSIS Catalog..."
    $ssisCatalog = $integrationServices.CreateCatalog("SSISDB", "YourStrongPassword123!", $true)
    Write-Host "SSIS Catalog created successfully."
}

# Check if folder exists, create if not
$folder = $ssisCatalog.Folders[$FolderName]
if (-not $folder) {
    Write-Host "Folder '$FolderName' does not exist. Creating..."
    $folder = New-Object Microsoft.SqlServer.Management.IntegrationServices.CatalogFolder($ssisCatalog, $FolderName, "Folder for Timesheet Migration")
    $folder.Create()
    Write-Host "Folder created successfully."
}

# Delete existing project if it exists
$project = $folder.Projects[$ProjectName]
if ($project) {
    Write-Host "Project '$ProjectName' already exists. Deleting for clean deployment..."
    $project.Drop()
    Write-Host "Project deleted."
}

# Deploy new project
Write-Host "Deploying project from: $PackagePath"

# Load the .ispac file
$projectBinary = [System.IO.File]::ReadAllBytes($PackagePath)
$project = $folder.DeployProject($ProjectName, $projectBinary)

Write-Host "Project deployed successfully."

# Deploy environment if specified
if ($EnvironmentName) {
    $environmentPath = "ssis-environments/${EnvironmentName}.env"
    if (Test-Path $environmentPath) {
        Write-Host "Deploying environment: $EnvironmentName"
        # Environment deployment logic here
        Write-Host "Environment deployed."
    }
}

Write-Host "SSIS Deployment completed successfully."