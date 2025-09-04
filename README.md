If you're configuring a NAT Gateway to support Amazon EKS cluster creation—especially in a private or hybrid networking setup—you'll need to allow outbound access to specific AWS service endpoints (URLs). These are the domains your cluster and nodes must reach to pull images, talk to control plane services, assume roles, send logs, etc.

Below is a list of service endpoints that typically require NAT Gateway access. These are the publicly resolvable AWS service domains (not VPC endpoint hostnames):


| Purpose / Service                    | Domain Pattern                                               |
| ------------------------------------ | ------------------------------------------------------------ |
| EKS Control Plane (API)              | `eks.REGION.amazonaws.com`                                   |
| ECR API & Image Pull                 | `ecr.REGION.amazonaws.com`, `*.dkr.ecr.REGION.amazonaws.com` |
| EC2 API                              | `ec2.REGION.amazonaws.com`                                   |
| STS (IAM role assumption/IRSA)       | `sts.REGION.amazonaws.com`                                   |
| CloudWatch Logs                      | `logs.REGION.amazonaws.com`                                  |
| Elastic Load Balancing (ALB/NLB)     | `elasticloadbalancing.REGION.amazonaws.com`                  |
| X-Ray (optional)                     | `xray.REGION.amazonaws.com`                                  |
| S3 (assets, manifests, AMIs, etc.)   | `s3.REGION.amazonaws.com`                                    |
| EKS Auth (Pod identity agent)        | `eks-auth.REGION.api.aws`                                    |
| App Mesh envoy management (optional) | `appmesh-envoy-management.REGION.amazonaws.com`              |



Required AWS Service Domains (for NAT gateway egress)

Based on AWS documentation, incoming node traffic via NAT must be able to reach:

EKS control plane (API operations)

eks.REGION.amazonaws.com

ECR (Elastic Container Registry)

ecr.REGION.amazonaws.com

*.dkr.ecr.REGION.amazonaws.com (image pull endpoint)

EC2 API (used by Amazon EKS components, optimized AMIs, etc.)

ec2.REGION.amazonaws.com

STS (Security Token Service, including for IRSA - IAM Roles for Service Accounts)

sts.REGION.amazonaws.com

CloudWatch Logs

logs.REGION.amazonaws.com

Elastic Load Balancing (if using LoadBalancer services)

elasticloadbalancing.REGION.amazonaws.com

X-Ray (if enabled for distributed tracing)

xray.REGION.amazonaws.com

S3 (pulling AMIs, bootstrap assets, manifests, etc.)

s3.REGION.amazonaws.com

EKS Auth (Pod Identity Agent credential retrieval)

eks-auth.REGION.api.aws 
AWS Documentation
+1
Medium

Optional Service Domains (depending on add-ons/features)

You may also need access to:

App Mesh envoy management (if using AWS App Mesh)

appmesh-envoy-management.REGION.amazonaws.com 
Medium

Summary Table
Purpose / Service	Domain Pattern
EKS Control Plane (API)	eks.REGION.amazonaws.com
ECR API & Image Pull	ecr.REGION.amazonaws.com, *.dkr.ecr.REGION.amazonaws.com
EC2 API	ec2.REGION.amazonaws.com
STS (IAM role assumption/IRSA)	sts.REGION.amazonaws.com
CloudWatch Logs	logs.REGION.amazonaws.com
Elastic Load Balancing (ALB/NLB)	elasticloadbalancing.REGION.amazonaws.com
X-Ray (optional)	xray.REGION.amazonaws.com
S3 (assets, manifests, AMIs, etc.)	s3.REGION.amazonaws.com
EKS Auth (Pod identity agent)	eks-auth.REGION.api.aws
App Mesh envoy management (optional)	appmesh-envoy-management.REGION.amazonaws.com
