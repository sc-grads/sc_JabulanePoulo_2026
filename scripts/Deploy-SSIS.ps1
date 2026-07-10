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

# Function to load SQL Server assemblies
function Load-SqlServerAssemblies {
    try {
        # Try loading from common installation paths
        $sqlVersion = "160"  # SQL Server 2022
        $possiblePaths = @(
            "C:\Program Files\Microsoft SQL Server\${sqlVersion}\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll",
            "C:\Program Files (x86)\Microsoft SQL Server\${sqlVersion}\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll",
            "C:\Program Files\Microsoft SQL Server\150\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll",
            "C:\Program Files (x86)\Microsoft SQL Server\150\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll",
            "C:\Program Files\Microsoft SQL Server\140\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll",
            "C:\Program Files (x86)\Microsoft SQL Server\140\SDK\Assemblies\Microsoft.SqlServer.Management.IntegrationServices.dll"
        )
        
        foreach ($path in $possiblePaths) {
            if (Test-Path $path) {
                Write-Host "Loading assembly from: $path"
                [System.Reflection.Assembly]::LoadFrom($path) | Out-Null
                return $true
            }
        }
        
        # Fallback: Try loading from GAC
        Write-Host "Attempting to load from GAC..."
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null
        
        # Try loading required dependencies
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.Sdk.Sfc") | Out-Null
        [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null
        
        return $true
    }
    catch {
        Write-Error "Failed to load SQL Server assemblies: $_"
        return $false
    }
}

# Main deployment function
function Deploy-SSISProject {
    try {
        Write-Host "=== SSIS Deployment Script ==="
        Write-Host "Server: $ServerName"
        Write-Host "Folder: $FolderName"
        Write-Host "Project: $ProjectName"
        Write-Host "Package Path: $PackagePath"
        Write-Host "================================"
        
        # Check if package exists
        if (-not (Test-Path $PackagePath)) {
            Write-Error "Package file not found: $PackagePath"
            Write-Host "Current directory contents:"
            Get-ChildItem -Recurse | Select-Object FullName, Length
            exit 1
        }
        
        Write-Host "Package found: $PackagePath"
        Write-Host "Package size: $((Get-Item $PackagePath).Length) bytes"
        
        # Load assemblies
        Write-Host "Loading SQL Server assemblies..."
        if (-not (Load-SqlServerAssemblies)) {
            Write-Error "Failed to load required assemblies. Please ensure SQL Server Management Studio or SQL Server SDK is installed."
            exit 1
        }
        Write-Host "Assemblies loaded successfully."
        
        # Create connection using Windows Authentication
        $connectionString = "Data Source=$ServerName;Initial Catalog=master;Integrated Security=SSPI;"
        Write-Host "Connecting to SQL Server: $ServerName"
        
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
        $sqlConnection.Open()
        Write-Host "Connected to SQL Server successfully."
        
        # Create Integration Services object
        $integrationServices = New-Object Microsoft.SqlServer.Management.IntegrationServices.IntegrationServices($sqlConnection)
        
        # Check if SSISDB exists
        Write-Host "Checking SSISDB catalog..."
        $ssisCatalog = $integrationServices.Catalogs["SSISDB"]
        
        if (-not $ssisCatalog) {
            Write-Host "SSISDB does not exist. Creating SSIS Catalog..."
            # Note: You need to provide a password for the SSISDB encryption
            $catalogPassword = "YourStrongPassword123!"  # Change this or pass as parameter
            try {
                $ssisCatalog = $integrationServices.CreateCatalog("SSISDB", $catalogPassword, $true)
                Write-Host "SSIS Catalog created successfully."
            }
            catch {
                Write-Error "Failed to create SSIS Catalog: $_"
                $sqlConnection.Close()
                exit 1
            }
        }
        else {
            Write-Host "SSISDB catalog already exists."
        }
        
        # Check if folder exists, create if not
        Write-Host "Checking folder: $FolderName"
        $folder = $ssisCatalog.Folders[$FolderName]
        
        if (-not $folder) {
            Write-Host "Folder '$FolderName' does not exist. Creating..."
            try {
                $folder = New-Object Microsoft.SqlServer.Management.IntegrationServices.CatalogFolder($ssisCatalog, $FolderName, "Folder for Timesheet Migration")
                $folder.Create()
                Write-Host "Folder created successfully."
            }
            catch {
                Write-Error "Failed to create folder: $_"
                $sqlConnection.Close()
                exit 1
            }
        }
        else {
            Write-Host "Folder '$FolderName' already exists."
        }
        
        # Delete existing project if it exists
        Write-Host "Checking for existing project: $ProjectName"
        $project = $folder.Projects[$ProjectName]
        
        if ($project) {
            Write-Host "Project '$ProjectName' already exists. Deleting for clean deployment..."
            try {
                $project.Drop()
                Write-Host "Project deleted successfully."
            }
            catch {
                Write-Error "Failed to delete existing project: $_"
                $sqlConnection.Close()
                exit 1
            }
        }
        else {
            Write-Host "Project '$ProjectName' does not exist."
        }
        
        # Deploy new project
        Write-Host "Deploying project from: $PackagePath"
        try {
            # Read the .ispac file
            $projectBinary = [System.IO.File]::ReadAllBytes($PackagePath)
            
            # Deploy the project
            $deployedProject = $folder.DeployProject($ProjectName, $projectBinary)
            
            if ($deployedProject) {
                Write-Host "Project deployed successfully!"
                Write-Host "Project ID: $($deployedProject.ID)"
                Write-Host "Project Name: $($deployedProject.Name)"
                Write-Host "Deployed Date: $($deployedProject.CreatedDate)"
            }
            else {
                Write-Error "Project deployment returned null."
                $sqlConnection.Close()
                exit 1
            }
        }
        catch {
            Write-Error "Failed to deploy project: $_"
            Write-Host "Error details: $($_.Exception.Message)"
            $sqlConnection.Close()
            exit 1
        }
        
        # Deploy environment if specified
        if ($EnvironmentName) {
            $environmentPath = "ssis-environments/${EnvironmentName}.env"
            if (Test-Path $environmentPath) {
                Write-Host "Deploying environment: $EnvironmentName"
                # Environment deployment logic would go here
                Write-Host "Environment deployment not implemented in this version."
            }
            else {
                Write-Host "Environment file not found: $environmentPath"
            }
        }
        
        # Close connection
        $sqlConnection.Close()
        
        Write-Host "================================"
        Write-Host "SSIS Deployment completed successfully!"
        Write-Host "================================"
        return 0
    }
    catch {
        Write-Error "Fatal error during SSIS deployment: $_"
        Write-Host "Error: $($_.Exception.Message)"
        if ($_.Exception.StackTrace) {
            Write-Host "Stack trace: $($_.Exception.StackTrace)"
        }
        return 1
    }
}

# Execute deployment
$exitCode = Deploy-SSISProject
exit $exitCode