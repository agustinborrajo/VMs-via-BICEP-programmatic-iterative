// 
// main.bicep ####
//
// main.bicep invokes vm.bicep module
// main.bicep iterates and creates 3 VMs via vm.bicep module
//


param location string = resourceGroup().location
param vmBaseName string = 'programaticVMloop'
@secure()
param adminUsername string
@secure()
param adminPassword string
param vnetName string
param subnetName string
param vmCount int = 3

// Loop to deploy VMs
var vmIndices = [for i in range(0, vmCount): i]

module vmsArray 'vm.bicep' = [for i in vmIndices: {
  name: 'vm${i}'
  params: {
    vmName: '${vmBaseName}${i}'
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
    vnetName: vnetName
    subnetName: subnetName
  }
}]
