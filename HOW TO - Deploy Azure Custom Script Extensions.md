# HOW TO: Deploy Azure Custom Script Extensions

Deploying a PowerShell script as a Custom Script Extension to an IaaS VM in Azure is a pretty simple operation.

1. Log into the Azure Portal.
2. Navigate to your target Virtual Machine.
3. Click Extensions.
4. Click "Custom Script Extensions".
5. Browse to your ps1/bash script. It'll upload to CRP storage for you.
6. Click OK.
7. Wait for completion. You can check the runtime status to see if it's still going.

The run will still say "in progress" until your application of choice has completed its work. The whole script and all sub-processes must exit before the run is considered complete.

If you're having trouble seeing exactly what I mean by "Custom Script Extension" you can go directly here to get a better idea: https://ms.portal.azure.com/#create/Microsoft.CustomScriptExtension

Additional resources for deep diving into this topic are available here:
* [Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows)
* [Linux](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-linux)
