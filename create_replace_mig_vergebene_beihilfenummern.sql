-- **************************************************************************
--
-- Erstellt oder ersetzt die Datenbank-View MIG_VERGEBENE_BEIHILFENUMMERN
-- In dieser View werden aus der Tabelle APER alle Datensätze zusammengestellt, die
-- * in der Spalte RPSTNR den Wert 'A' (Antragstelelr)
-- * in der Spalte MANDA den Wert 1 (RP Kassel)
-- haben.
--
-- Connect-User: ELBA_ADM
--
-- version:    1.0.0
--
-- author:     S. Grünewald, Comline AG
-- created:    31.01.2018
--

SET FEEDBACK ON
SPOOL %LOGPFAD%\create_replace_mig_vergebene_beihilfenummern.%UMGEBUNG%.log

UNDEFINE grantees

SET pagesize 0
SET linesize 200
SET long 200000

DEFINE grantees    = ELBA

CREATE OR REPLACE FORCE VIEW mig_vergebene_beihilfenummern (
   BEIHILFENUMMER, 
   LGUID, 
   RGUID) 
AS SELECT 
   aper.persnr, 
   aper.lguid, 
   aper.rguid
FROM aper
WHERE aper.rpstnr = 'A'
AND aper.manda = 1;

GRANT SELECT ON mig_vergebene_beihilfenummern TO &grantees;

SPOOL OFF

EXIT
