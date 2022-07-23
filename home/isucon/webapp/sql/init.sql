DELETE FROM tenant WHERE id > 100;
DELETE FROM visit_history WHERE created_at >= '1654041600';
UPDATE id_generator SET id=2678400000 WHERE stub='a';
TRUNCATE TABLE visit;
INSERT INTO visit (tenant_id, competition_id, player_id, created_at) SELECT tenant_id, competition_id, player_id, MIN(created_at) AS min_created_at FROM visit_history GROUP BY tenant_id, competition_id, player_id;
ALTER TABLE id_generator AUTO_INCREMENT=2678400000;
ALTER TABLE player ADD INDEX (tenant_id, created_at DESC);
