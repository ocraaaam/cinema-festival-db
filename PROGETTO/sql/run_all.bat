@echo off
echo Avvio della creazione del database FestivalCinematografico...

type drop.sql schema.sql triggers.sql procedures.sql data.sql operations.sql | mysql -u root -p

echo.
echo Database creato e popolato con successo!
pause