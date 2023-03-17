locals {
    ambiente                = lookup(var.ambiente,var.env)
    default_ttl_seconds    = var.env == "p" && var.tempo_expiracao_registro > 604800 ? var.tempo_expiracao_registro : 86400 #1 dia

    tags = {
        env         = var.env
        ambiente    = local.ambiente
    }
}