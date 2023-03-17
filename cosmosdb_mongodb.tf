resource "azurerm_cosmosdb_account" "cosmosdbmongoacc" {
  name                = "${var.nome_sistema}-cosmosdb-account-${local.ambiente}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  offer_type          = "Standard"
  kind                = "MongoDB"

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 1
  }

  geo_location {
    location          = var.regiao_sec
    failover_priority = 0
  }

  tags                = merge(local.tags)

}

resource "azurerm_cosmosdb_mongo_database" "mongodb_database" {
  name                = "cosmosdb-mongo-${var.nome_sistema}-${local.ambiente}"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdbmongoacc.name
}

resource "azurerm_cosmosdb_mongo_collection" "mongodb_collection" {
  name                = "cosmosdb-${var.nome_sistema}-${local.ambiente}"
  resource_group_name = azurerm_cosmosdb_account.cosmosdbmongoacc.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdbmongoacc.name
  database_name       = azurerm_cosmosdb_mongo_database.mongodb_database.name

  default_ttl_seconds = local.default_ttl_seconds
  shard_key           = var.shard_key
  throughput          = var.throughput

  index {
    keys   = var.keys
    unique = true
  }
}