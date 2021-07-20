# Lambda@Edge Security Headers 
Terraform that deploy Lambda@Edge to inject headers in CloudFront Distribution

Provisioned resources:
* Lambda Function
* IAM Role
* IAM Policy
* Lambda Permission

### Required Version of Terraform
* 0.14.9

### How To Use 
Clone this repository
```shell
$ git clone git@github.com:alisonpecin/terraform-aws-security-headers.git
```

Configure credentials to get access to AWS
```shell
$ aws configure
AWS Access Key ID [****************DEFC]: 
AWS Secret Access Key [****************Gzhm]: 
Default region name [us-east-1]: 
Default output format [json]: 
``` 

Enter in folder and run ```terraform init```
```shell
$ cd terraform-aws-security-headers
$ terraform init
```

Apply the code
```shell
$ terraform apply 
```

### Mandatory Variables
This code does not need mandatory variables to work, if it is necessary to change the name of function, it can be done by changing the variable ```all``` in variables.tf before apply.

