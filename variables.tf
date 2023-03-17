variable "subscription_id" {
    description = "Passar sua subscription do Azure aonde os recursos serão gerados"
}

variable "rg" {
    description = "Resource Group que será criado|utilizado na criação dos recursos de banco de dados"
}

variable "regiao" {
    description = "Região ao qual os recursos serão criados"
}

variable "regiao_sec" {
    description = "Região Secundaria para criação de redundancia do banco de dados CosmosDB."
}

variable "ambiente" {
    type = map
    default = {
        d = "dev",
        h = "hml",
        p = "prd"
    }
}

variable "env" {
    default = "d"

    validation {
        condition = contains(["d","h","p"],var.env)
        error_message = "Argument 'env' must be either 'd' (dev), 'h' (hml) or 'p' (prd)"
    }
}

variable "nome_sistema" {
    description = "Nome do sistema ao qual os recursos serão destinados"
}

variable "tempo_expiracao_registro" {
    description = "TTL - Time To Live, tempo de expiração do dado na collection do CosmosDB. Default 7 Dias."
    default = 604800 
}

variable "shard_key" {
    description = "Nome da coluna para chave de particionamento|sharding"
}

variable "throughput" {
    description = "Capacidade de RU/s que a collection terá. Por padrão será o minimo de 400."
    default = 400
}

variable "keys" {
    description = "Colunas para determinar a chave de particionamento da tabela. Por default será a coluna _id"
    type        = list(string)
    default     = ["_id"] 
}

