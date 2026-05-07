#!/bin/bash

echo "Avvio della creazione del database FestivalCinematografico..."

# Unisce tutti i file SQL e li invia a MySQL in un colpo solo. 
# Ti chiederà la password una sola volta!
cat drop.sql schema.sql triggers.sql procedures.sql data.sql operations.sql | mysql -u root -p

echo "Database creato e popolato con successo!"