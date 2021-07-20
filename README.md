# Lambda@Edge Security Headers 
Terraform that deploy Lambda@Edge to inject headers in CloudFront Distribution

Provisioned resources:
* Lambda Function
* IAM Role
* IAM Policy
* Lambda Permission

## Required Version of Terraform
* 0.14.9

## How To Use 
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

## Mandatory Variables
This code does not need mandatory variables to work, if it is necessary to change the name of function, it can be done by changing the variable ```lambda_function_name``` in variables.tf before apply.

## JavaScript with the Headers
Edit the index.js file at the root of this repository according to the desired headers. Example:
```java
'use strict';
exports.handler = (event, context, callback) => {
	const response = event.Records[0].cf.response;
	const headers = response.headers;

	headers["strict-transport-security"] = [{key: "Strict-Transport-Security", value: "max-age=31536000; includeSubdomains; preload"}]; 
	headers["content-security-policy"] = [{key: "Content-Security-Policy", value: 'upgrade-insecure-requests'}]; 
	headers["x-content-type-options"] = [{key: "X-Content-Type-Options", value: "nosniff"}]; 
	headers["x-frame-options"] = [{key: "X-Frame-Options", value: "SAMEORIGIN"}]; 
	headers["x-xss-protection"] = [{key: "X-XSS-Protection", value: "1; mode=block"}]; 
	headers["referrer-policy"] = [{key: "Referrer-Policy", value: "no-referrer-when-downgrade"}];
	headers["x-permitted-cross-domain-policies"] = [{key: "X-Permitted-Cross-Domain-Policies", value: "none"}];
    
	callback(null, response);
};
```

