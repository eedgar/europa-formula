europa:
   cc_url: http://artifacts.zenoss.loc/europa/releases/CR3/serviced_1.0.0~trusty-0.1.CR3_amd64.deb
   gitrepos:
     - repo: git@github.com:zenoss/ZenPacks.zenoss.XUM.git
       path: ZenPacks.zenoss.XUM
     - repo: git@github.com:zenoss/ZenPacks.zenoss.RUM.git
       path: ZenPacks.zenoss.RUM
     - repo: git@github.com:zenoss/ZenPacks.zenoss.AixMonitor.git
       path: ZenPacks.zenoss.AixMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.AWS.git
       path: ZenPacks.zenoss.AWS
     - repo: git@github.com:zenoss/ZenPacks.zenoss.Cisco.APIC.git
       path: ZenPacks.zenoss.Cisco.APIC
     - repo: git@github.com:zenoss/ZenPacks.zenoss.CiscoInvicta.git
       path: ZenPacks.zenoss.CiscoInvicta
     - repo: git@github.com:zenoss/ZenPacks.zenoss.CiscoMonitor.git
       path: ZenPacks.zenoss.CiscoMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.CiscoUCS.git
       path: ZenPacks.zenoss.CiscoUCS
     - repo: git@github.com:zenoss/ZenPacks.zenoss.ControlCenter.git
       path: ZenPacks.zenoss.ControlCenter
     - repo: git@github.com:zenoss/ZenPacks.zenoss.DatabaseMonitor.git
       path: ZenPacks.zenoss.DatabaseMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.Dell.PowerEdge.git
       path: ZenPacks.zenoss.Dell.PowerEdge
     - repo: git@github.com:zenoss/ZenPacks.zenoss.ExportZenPack.git
       path: ZenPacks.zenoss.ExportZenPack
     - repo: git@github.com:zenoss/ZenPacks.zenoss.HPMonitor.git
       path: ZenPacks.zenoss.HPMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.HpuxMonitor.git
       path: ZenPacks.zenoss.HpuxMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.HttpMonitor.git
       path: ZenPacks.zenoss.HttpMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.IBMHMC.git
       path: ZenPacks.zenoss.IBMHMC
     - repo: git@github.com:zenoss/ZenPacks.zenoss.IBM.Power.git
       path: ZenPacks.zenoss.IBM.Power
     - repo: git@github.com:zenoss/ZenPacks.zenoss.Microsoft.Azure.git
       path: ZenPacks.zenoss.Microsoft.Azure
     - repo: git@github.com:zenoss/ZenPacks.zenoss.Microsoft.Windows.git
       path: ZenPacks.zenoss.Microsoft.Windows
     - repo: git@github.com:zenoss/ZenPacks.zenoss.NetAppMonitor.git
       path: ZenPacks.zenoss.NetAppMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.OpenStack.git
       path: ZenPacks.zenoss.OpenStack
     - repo: git@github.com:zenoss/ZenPacks.zenoss.PostgreSQL.git
       path: ZenPacks.zenoss.PostgreSQL
     - repo: git@github.com:zenoss/ZenPacks.zenoss.PropertyMonitor.git
       path: ZenPacks.zenoss.PropertyMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.PythonCollector.git
       path: ZenPacks.zenoss.PythonCollector
     - repo: git@github.com:zenoss/ZenPacks.zenoss.Rabbitmq.git
       path: ZenPacks.zenoss.Rabbitmq
     - repo: git@github.com:zenoss/ZenPacks.zenoss.SolarisMonitor.git
       path: ZenPacks.zenoss.SolarisMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.TomcatMonitor.git
       path: ZenPacks.zenoss.TomcatMonitor
     - repo: git@github.com:zenoss/ZenPacks.zenoss.vSphere.git
       path: ZenPacks.zenoss.vSphere
     - repo: git@github.com:zenoss/ZenPacks.zenoss.WBEM.git
       path: ZenPacks.zenoss.WBEM
     - repo: git@github.com:zenoss/ZenPacks.zenoss.XenServer.git
       path: ZenPacks.zenoss.XenServer
     - repo: git@github.com:zenoss/ZenPacks.zenoss.ZenETL.git
       path: ZenPacks.zenoss.ZenETL
     - repo: git@github.com:zenoss/ZenPacks.zenoss.ZenWebTx.git
       path: ZenPacks.zenoss.ZenWebTx

   extended_gitconfig: True

   # User info
   gitconfig: |
     [user]
       name = Eric Edgar
       email = eedgar@zenoss.com

   dockerhub:
      username: rocket
      email: rocketman110@gmail.com
      password: password

   ssh_keys:
      privkey: |
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpAIBAAKCAQEAri14UtcsvkAd+sACBZaZHcEDo2JFTCQoOr1ZenJFFTTF4fe1
          zZA53u9GzLoFabfdW4heBRxd3VucfAeOVBkvNCGgEFyKEVj1Xx+eK+Bs//3tgXqJ
          ....
          ....
          -----END RSA PRIVATE KEY-----

      pubkey: |
          ssh-rsa AAAAB3............pDg1DDur eedgar@zendev
