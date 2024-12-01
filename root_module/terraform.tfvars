rg = {
  rg1 = {
    name     = "rghcl"
    location = "centralindia"
  }
}

vnet = {
  vnet1 = {
    name                = "vnethcl"
    location            = "centralindia"
    resource_group_name = "rghcl"
    address_space       = ["10.0.0.0/16"]

  }
}


subnet = {
  subnet1 = {
    name                 = "subnethcl"
    resource_group_name  = "rghcl"
    virtual_network_name = "vnethcl"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

nic = {
  nic1 = {
    name                 = "nichcl"
    location             = "centralindia"
    resource_group_name  = "rghcl"
    subnet_name          = "subnethcl"
    virtual_network_name = "vnethcl"
    pip_name             = "mypip1"
  }

}

vm = {
  vm1 = {
    name                = "VMhcl"
    location            = "centralindia"
    resource_group_name = "rghcl"
    size                = "Standard_B1s"
    nic_name            = "nichcl"
    vm_secret           = "Radhey"
    keyvault_name       = "keyvaulthcl465"
  }
}

keyvault = {

  kv1 = {
    name                = "keyvaulthcl465"
    location            = "centralindia"
    resource_group_name = "rghcl"
    secret_name         = "Radhey"
    value2              = "Komalsingh@654321"



  }
}

pip = {

  pip1 = {
    name                = "mypip1"
    location            = "centralindia"
    resource_group_name = "rghcl"
    allocation_method   = "Static"



  }
}

nsg = {

  nsg1 = {
    name                = "nsghcl"
    location            = "centralindia"
    resource_group_name = "rghcl"
    security_rules = [
      {
        security_rule_name         = "Allow-RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },

      {
        security_rule_name         = "Allow-HTTP"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

}

nsgsubnet = {
  nsgsubnet1 = {
    nsg_name             = "nsghcl"
    subnet_name          = "subnethcl"
    virtual_network_name = "vnethcl"
    resource_group_name  = "rghcl"



  }
}


