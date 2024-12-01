module "rgkt" {

  source = "../child_module/rg"
  rg     = var.rg
}

module "vnetkt" {

  source     = "../child_module/vnet"
  vnet       = var.vnet
  depends_on = [module.rgkt]
}
module "subnetkt" {

  source     = "../child_module/subnet"
  subnet     = var.subnet
  depends_on = [module.vnetkt]
}

module "nickt" {

  source     = "../child_module/nic"
  nic        = var.nic
  depends_on = [module.subnetkt]
}

module "vmkt" {

  source     = "../child_module/virtual_machine"
  vm         = var.vm
  depends_on = [module.nickt, module.keyvaultkt, module.pipkt]
}

module "keyvaultkt" {
  source     = "../child_module/keyvault"
  keyvault   = var.keyvault
  depends_on = [module.rgkt]

}

module "pipkt" {

  source     = "../child_module/publicip"
  pip        = var.pip
  depends_on = [module.rgkt]

}

module "nsgkt" {
  source     = "../child_module/NSG"
  nsg        = var.nsg
  depends_on = [module.rgkt]

}

module "nsgsubnetkt" {
  source     = "../child_module/nsgsubnetasso"
  nsgsubnet  = var.nsgsubnet
  depends_on = [module.rgkt, module.subnetkt, module.vnetkt, module.nsgkt]

}

