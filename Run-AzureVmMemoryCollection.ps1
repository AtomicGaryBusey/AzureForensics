###############################################################################
# Use this script as a Custom Script Extension (CSE) in Azure to generate a 
# full memory dump from any Windows VM using DumpIt and upload it to Azure Blob 
# Storage for retrieval and forensic analysis.
# You don't have to use DumpIt, you can use any command-line capable memory
# tools you may already have. Just modify the script accordingly.
###############################################################################
# Version: 1.0
# Author: Alex Harmon (@AtomicGaryBusey)
###############################################################################
# Requires:
# 1. AzCopy for Windows x64: https://github.com/Azure/azure-storage-azcopy
# 2. DumpIt for Windows x64: https://www.comae.com/ (requires purchase)
# 3. You will need to set up your own tools download locations from some
#    web-accessible location. My links are for example only.
###############################################################################
# Known issues:
# 1. The latest version of AzCopy (10.1.2) does not run on an Azure DS1_v2 size
#    VM due to a low memory constraint. See this for more details:
#    https://github.com/Azure/azure-storage-azcopy/issues/402
###############################################################################

# Download and prepare the AzCopy application.
# Requires that you have already uploaded AzCopy to your forensic utility watering hole.
Invoke-WebRequest -Uri 'https://account.blob.core.windows.net/container/azcopy.zip<SASURI>' -OutFile .\azcopy.zip
Expand-Archive -Path .\azcopy.zip -DestinationPath .\
Remove-Item -Path .\azcopy.zip

# An alternative AzCopy download method provided in the AzCopy GitHub repo:
#    Invoke-WebRequest -Uri https://aka.ms/downloadazcopy-v10-windows -OutFile .\azcopyv10.zip
#    Expand-Archive azcopyv10.zip -DestinationPath .\

# Download and prepare the DumpIt application.
# Requires that you have already uploaded DumpIt to your forensic utility watering hole.
# DumpIt x64 requires a purchase. Please support Matt Suiche. He does good work. It's worth it.
Invoke-WebRequest -Uri 'https://account.blob.core.windows.net/container/dumpit.zip<SASURI>' -OutFile .\dumpit.zip
Expand-Archive -Path .\dumpit.zip -DestinationPath .\
Remove-Item -Path .\Dumpit.zip

# Execute a full memory dump using DumpIt.
.\DumpIt.exe /N /Q

# Upload the generated files to Azure Storage.
.\azcopy.exe copy "*.json" "https://account.blob.core.windows.net/container<SASURL>" --overwrite=false --from-to=LocalBlob --blob-type=BlockBlob --put-md5;
.\azcopy.exe copy "*.dmp" "https://account.blob.core.windows.net/container<SASURL>" --overwrite=false --from-to=LocalBlob --blob-type=BlockBlob --put-md5;

# Clean up work items.
Remove-Item -Path .\azcopy.exe
Remove-Item -Path .\DumpIt.exe
Remove-Item -Path .\*.json
Remove-Item -Path .\*.dmp
