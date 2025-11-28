INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Hybrid Cloud Networking - Configure secure connectivity between on-premises and cloud',
  'cloud-infrastructure',
  'skill',
  '[{"solution": "Configure AWS Site-to-Site VPN", "cli": {"macos": "aws ec2 describe-vpn-connections", "linux": "aws ec2 describe-vpn-connections", "windows": "aws ec2 describe-vpn-connections"}, "manual": "Set up VPN gateway, customer gateway, and VPN connection in AWS console", "note": "IPSec VPN suitable for moderate bandwidth up to 1.25 Gbps per tunnel"}, {"solution": "Setup AWS Direct Connect", "cli": {"macos": "aws ec2 describe-vpn-connections", "linux": "aws ec2 describe-vpn-connections", "windows": "aws ec2 describe-vpn-connections"}, "manual": "Request Direct Connect connection from AWS, configure routing via BGP", "note": "1-100 Gbps dedicated connection with lower latency"}, {"solution": "Configure Azure Site-to-Site VPN", "cli": {"macos": "az network vpn-connection show", "linux": "az network vpn-connection show", "windows": "az network vpn-connection show"}, "manual": "Create virtual network gateway and VPN connection in Azure", "note": "RouteBased VPN gateway with dual tunnels for HA"}, {"solution": "Setup Azure ExpressRoute", "cli": {"macos": "az network express-route show", "linux": "az network express-route show", "windows": "az network express-route show"}, "manual": "Order ExpressRoute from connectivity provider and configure peering", "note": "Private connection up to 100 Gbps with 99.95%+ availability"}, {"solution": "Configure GCP Cloud VPN", "cli": {"macos": "gcloud compute vpn-gateways list", "linux": "gcloud compute vpn-gateways list", "windows": "gcloud compute vpn-gateways list"}, "manual": "Create VPN gateway and tunnels in GCP, configure BGP routing", "note": "HA VPN provides 99.99% SLA, classic VPN up to 3 Gbps per tunnel"}]'::jsonb,
  'script',
  'AWS/Azure/GCP account, VPN/networking knowledge, on-premises router configuration',
  'Not implementing redundancy, using internet-dependent VPN for critical workloads, not monitoring BGP sessions, forgetting to configure firewall rules',
  'VPN/Direct Connect tunnel shows UP status, BGP session established, successful ping between on-premises and cloud resources, network traffic flowing with low latency',
  'Master hybrid cloud connectivity patterns using VPN, Direct Connect, and ExpressRoute with proper routing and high availability',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cloud-infrastructure-skills-hybrid-cloud-networking-skill-md',
  'admin:HAIKU_SKILL_1764289624_86615'
);
