variable "rg_name" {
    description = "Name of Resource Group"
    default     = ""
}

variable "location" {
    description = "Resion, Where you want to deploy this reosurce"
    default     = "westeurope"
}

variable "tags" {
    description = "Tags of Resource Group"
    type        = map(string)

    default = {
        name = ""
        env  = ""
    }
}