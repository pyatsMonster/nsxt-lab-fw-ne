#Explain built in services are not in group service TF script
#explain the lrule id, might be replaced with something automatic like a list of map because we don't need the lrule text
#explain sequence_number

mapgroups = {
   SVI-SUBNET = { IP = ["10.37.128.16/28","10.37.128.0/28","10.36.129.128/26"] }
   FSOP-SUBNET = { IP = ["10.37.128.16/28","10.37.128.0/28"] }
   SVC = { TAG = ["SERVICE"] }
   MGT = { TAG = ["MANAGEMENT"] }
   GPUAD-MGT-PROD-ADMIN = { TAG = ["GPUAD","MANAGEMENT","PROD","ADMIN"] }
   GPUAD-MGT-NONPROD-ADMIN = { TAG = ["GPUAD","MANAGEMENT","NONPROD","ADMIN"] }
   KALI-MGT = { TAG = ["KALI","MANAGEMENT"] }
   VCF-VREALIZE = { TAG = ["VREALIZE","VCF"] }
   PIAXIT-CONVERTER = { TAG = ["MONTOOLS"] }
   PIAXIT-VM = { TAG = ["MEDIA GW"] }
   SVI = { SEGMENT-TAG = ["SVI"] }
   DFW = { SEGMENT-TAG = ["DFW"]}
   CROSSREG-LS = { SEGMENT-TAG = ["CROSSREG-LS"]}
   REGIONAL-LS = { SEGMENT-TAG = ["REGIONAL-LS"]}
   RDS-MGT-PROD-ADMIN = { TAG = ["RDS","MANAGEMENT","PROD","ADMIN"] }
   JUMPSERVER-MGT-PROD-BASTION = { TAG = ["JUMPSERVER","MANAGEMENT","PROD","BASTION"] }
   MONTOOLS-PROD = { TAG = ["PROD","MANAGEMENT","ADMIN","MONTOOLS"] }
   PROD-MANAGEMENT-ADMIN-APM = { TAG = ["PROD","MANAGEMENT","ADMIN","APM"] }
   NONPROD-MANAGEMENT-ADMIN-APM = { TAG = ["NONPROD","MANAGEMENT","ADMIN","APM"] }
   PROD-MANAGEMENT-ADMIN-COMPUT-STO-MGMT = { TAG = ["PROD","MANAGEMENT","ADMIN","COMPUT-STO-MGMT"] }
   PROD-MANAGEMENT-ADMIN-FWMGMT = { TAG = ["PROD","MANAGEMENT","ADMIN","FWMGMT"] }
   PROD-MANAGEMENT-ADMIN-INFRAMON = { TAG = ["PROD","MANAGEMENT","ADMIN","INFRAMON"] }

   SERVICE-PROD-INT-PIC-DNS= { TAG = ["SERVICE","PROD","INT","PIC", "DNS"] }
   SERVICE-PROD-INT-PIC-PROXY= { TAG = ["SERVICE","PROD","INT","PIC", "PROXY"] }
   SERVICE-NONPROD-INT-PIC-PROXY= { TAG = ["SERVICE","NONPROD","INT","PIC", "PROXY"] }

   MANAGEMENT-PROD-ADMIN-COMPUT-STO-MGMT = { TAG = ["MANAGEMENT","PROD","ADMIN","COMPUT-STO-MGMT"] }
   MANAGEMENT-PROD-ADMIN-APM = { TAG = ["MANAGEMENT","PROD","ADMIN","APM"] }
   MANAGEMENT-NONPROD-ADMIN-APM = { TAG = ["MANAGEMENT","NONPROD","ADMIN","APM"] }
   MANAGEMENT-PROD-ADMIN-RDS = { TAG = ["MANAGEMENT","PROD","ADMIN","RDS"] }
   MANAGEMENT-PROD-BASTION-JUMPSERVER = { TAG = ["MANAGEMENT","PROD","JUMPSERVER","BASTION"] }
   MANAGEMENT-PROD-ADMIN-INFRAMON = { TAG = ["MANAGEMENT","PROD","ADMIN","INFRAMON"] }
   MANAGEMENT-NONPROD-ADMIN-INFRAMON = { TAG = ["MANAGEMENT","NONPROD","ADMIN","INFRAMON"] }
   MANAGEMENT-PROD-ADMIN-FWMGMT = { TAG = ["MANAGEMENT","PROD","ADMIN","FWMGMT"] }
   MANAGEMENT-NONPROD-ADMIN-GPUAD = { TAG = ["MANAGEMENT","NONPROD","ADMIN","GPUAD"] }
   MANAGEMENT-PROD-ADMIN-GPUAD = { TAG = ["MANAGEMENT","PROD","ADMIN","GPUAD"] }
   MANAGEMENT-PROD-ADMIN-MONTOOLS = { TAG = ["MANAGEMENT","PROD","ADMIN","MONTOOLS"] }
   MANAGEMENT-PROD-ADMIN-GTACACS = { TAG = ["MANAGEMENT","PROD","ADMIN","GTACACS"] }
 
}

mapservices = {
   #ESP = { IP = ["50"] }
   #AH = { IP = ["51"] }
   SMPOD_ICMPv4 = { ICMP = ["ICMPv4"] }
   SMPOD_SSH = { TCP = ["22"] }
   SMPOD_HTTP = { TCP = ["80"] }
   SMPOD_HTTPS = { TCP = ["443"] }
   SMPOD_NTP = { UDP = ["123"] }
   SMPOD_FTP = { ALG = ["FTP","21"] }
   MS-NETBIOS-DS = { TCP = ["135","137","138","139","445"], UDP = ["135","137","138","139","445"] }
   LDAP-LDAPS-ALL = { TCP = ["389","636"], UDP = ["389","636"] }
   KERBEROS-ALL = { TCP = ["88"], UDP = ["88"] }
   DNS-ALL = { TCP = ["53"], UDP = ["53"] }
   MSFT-GC-GCS = { TCP = ["3268","3269"] }
   ADWS = { TCP = ["9389"] }
   AD-HIGHPORTS = { TCP = ["49152-65535"] }
   KPASSWD-ALL = { TCP = ["464"], UDP = ["464"] }
   PIAXIT = { TCP = ["9089"] }
   WINRM = { TCP = ["5985","5986"] }
   HTTPS_8443 = { TCP = ["8443"] }
   VMARE_VAMI = { TCP = ["5480"] }
   TCP_3000_3001 = { TCP = ["3000-3001"] }
}

mappolicies = {
	  GPUAD = {
	  	category = "Application"
		  sequence_number = "10"
		  rules = {
			  lrule1 = {
			    display = "GPUAD-MGT-PROD-ADMIN"
			    sources = ["MANAGEMENT-PROD-ADMIN-GPUAD"]
			    destinations = ["MANAGEMENT-PROD-ADMIN-GPUAD"]
			    services = []
			    scope    = ["MANAGEMENT-PROD-ADMIN-GPUAD"]
			    action = "ALLOW"
			    disabled = "false"
			  }
			  lrule2 = {
			    display = "SERVEUR-PROD->YELLOW-FOREST"
			    sources = ["RDS-MGT-PROD-ADMIN","JUMPSERVER-MGT-PROD-BASTION", "PROD-MANAGEMENT-ADMIN-COMPUT-STO-MGMT","MANAGEMENT-PROD-ADMIN-INFRAMON"]
			    destinations = ["MANAGEMENT-PROD-ADMIN-GPUAD"]
			    services = ["SMPOD_ICMPv4","SMPOD_NTP","MS-NETBIOS-DS","LDAP-LDAPS-ALL","KERBEROS-ALL","DNS-ALL","MSFT-GC-GCS","ADWS","AD-HIGHPORTS","KPASSWD-ALL"]
			    scope    = ["MANAGEMENT-PROD-ADMIN-GPUAD","RDS-MGT-PROD-ADMIN","JUMPSERVER-MGT-PROD-BASTION","PROD-MANAGEMENT-ADMIN-COMPUT-STO-MGMT"]
			    action = "ALLOW"
			    disabled = "false"
			  }
			  lrule3 = {
			    display = "MANAGEMENT-NONPROD-ADMIN-GPUAD"
			    sources = ["MANAGEMENT-NONPROD-ADMIN-GPUAD"]
			    destinations = ["MANAGEMENT-NONPROD-ADMIN-GPUAD"]
			    services = []
			    scope    = ["MANAGEMENT-NONPROD-ADMIN-GPUAD"]
			    action = "ALLOW"
			    disabled = "false"
			  }
                          lrule4 = {
                            display = "SERVEUR-PROD->NONPROD YELLOW-FOREST"
                            sources = ["MANAGEMENT-PROD-ADMIN-COMPUT-STO-MGMT","MANAGEMENT-PROD-ADMIN-INFRAMON"]
                            destinations = ["MANAGEMENT-NONPROD-ADMIN-GPUAD"]
                            services = ["SMPOD_ICMPv4","SMPOD_NTP","MS-NETBIOS-DS","LDAP-LDAPS-ALL","KERBEROS-ALL","DNS-ALL","MSFT-GC-GCS","ADWS","AD-HIGHPORTS","KPASSWD-ALL"]
                            scope    = ["MANAGEMENT-NONPROD-ADMIN-GPUAD","MANAGEMENT-PROD-ADMIN-COMPUT-STO-MGMT"]
                            action = "ALLOW"
                            disabled = "false"
                          }
		  }
	  }
    INFRAMON = {
      category = "Application"
      sequence_number = "100"
      rules = {
              lrule1 = {
                display = "INFRAMON-PROD<->INFRAMON-PROD"
                sources = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                destinations = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                services = []
                scope    = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                action = "ALLOW"
                disabled = "false"
              }
              lrule2 = {
                display = "INFRAMON-NONPROD<->INFRAMON-NONPROD"
                sources = ["MANAGEMENT-NONPROD-ADMIN-INFRAMON"]
                destinations = ["MANAGEMENT-NONPROD-ADMIN-INFRAMON"]
                services = []
                scope    = ["MANAGEMENT-NONPROD-ADMIN-INFRAMON"]
                action = "ALLOW"
                disabled = "false"
              }
              lrule3 = {
                display = "INFRAMON-PROD->INFRAMON-NONPROD"
                sources = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                destinations = ["MANAGEMENT-NONPROD-ADMIN-INFRAMON"]
                services = ["DNS-ALL","LDAP-LDAPS-ALL","KERBEROS-ALL","MS-NETBIOS-DS","KPASSWD-ALL","SMPOD_ICMPv4","MSFT-GC-GCS","AD-HIGHPORTS"]
                scope    = ["MANAGEMENT-PROD-ADMIN-INFRAMON","MANAGEMENT-NONPROD-ADMIN-INFRAMON"]
                action = "ALLOW"
                disabled = "false"
              }
              lrule4 = {
                display = "GPUAD-PROD->INFRAMON-PROD"
                sources = ["MANAGEMENT-PROD-ADMIN-GPUAD"]
                destinations = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                services = ["TCP_3000_3001"]
                scope    = ["MANAGEMENT-PROD-ADMIN-INFRAMON","MANAGEMENT-PROD-ADMIN-GPUAD"]
                action = "ALLOW"
                disabled = "false"
              }
              lrule5 = {
                display = "GPUAD-NON-PROD->INFRAMON-PROD"
                sources = ["MANAGEMENT-NONPROD-ADMIN-GPUAD"]
                destinations = ["MANAGEMENT-PROD-ADMIN-INFRAMON"]
                services = ["TCP_3000_3001"]
                scope    = ["MANAGEMENT-PROD-ADMIN-INFRAMON","MANAGEMENT-NONPROD-ADMIN-GPUAD"]
                action = "ALLOW"
                disabled = "false"
              }
      }
    }
}
