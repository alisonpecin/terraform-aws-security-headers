variable "lambda_runtime" {
  description = "Version of Lambda runtime"
  default     = "nodejs12.x"
}

variable "lambda_memory_size" {
  description = "Dedicated memory for Lambda Function"
  default     = 128
}

variable "lambda_timeout" {
  description = "Execution timeout for Lambda Function"
  default     = 3
}
