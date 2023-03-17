output "cosmodb_database_id" {
    value = azurerm_cosmosdb_mongo_database.mongodb_database.id
}

output "cosmodb_collection_id" {
    value = azurerm_cosmosdb_mongo_collection.mongodb_collection.id
}