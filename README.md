Provisioning Scalable and Secure Web Application Architecture in AWS

This project is about using Terraform which is an Iac(Infrastucture as a code) tool to provision a secure and scalable web application in AWS.

This architecture is a three tier architecture which means it has the Presentation layer which is responsible for handling the user interface and user interactions. The second layer is the Application Layer which is the middle layer and acts as an intermediary between the presentation layer and the data storage layer. The third layer is the data layer also known as the data access layer, is responsible for managing data storage, retrieval, and manipulation. It interacts directly with databases or other data storage systems to store and retrieve data as requested by the application layer.

The Load balancer resides in the public subnet as it is exposed to the internet and recieves client request and forwards it to the appropriate server. it makes sure it distributes the traffic evenly among the ec2 instances which are the virtual servers. The autoscaling group is responsible for provisioning ec2 instances in a private subnet and in multiple availability zones, it takes care of scalability. For security reasons it only allows traffic from the load balancer. The rds instance is also launched in its own private subnet and allows traffic from the auto scaling group only. 

The architecture diagram is also attached to this github as "three-tier.drawio.png" file.

To lauch the setup using terraform kindly use the commands below accordinly:
1) terraform init
2) terraform plan
3) terraform apply

After doing so, you would receive a prompt so just type "yes"

To destroy the resources use the command "terraform destroy" and type yes when you see the prompt.

The resources would be deleted successfully. Thank you.